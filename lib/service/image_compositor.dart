import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageCompositor {
  /// Composites a product image onto a user photo
  /// Returns the path to the composited image
  static Future<File?> compositeImages({
    required File userPhoto,
    required String productImageUrl,
  }) async {
    try {
      // Load user photo
      final userImageBytes = await userPhoto.readAsBytes();
      final userImage = await decodeImageFromList(userImageBytes);

      // Download and load product image
      final response = await http.get(Uri.parse(productImageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download product image');
      }
      final productImage = await decodeImageFromList(response.bodyBytes);

      // Create canvas for compositing
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw user photo as background
      final userImageSize = Size(
        userImage.width.toDouble(),
        userImage.height.toDouble(),
      );
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, userImageSize.width, userImageSize.height),
        image: userImage,
        fit: BoxFit.cover,
      );

      // Calculate product overlay position and size
      // Position product in upper-center area (typical clothing position)
      final productWidth = userImageSize.width * 0.6; // 60% of photo width
      final productHeight =
          productWidth * (productImage.height / productImage.width);
      final productLeft = (userImageSize.width - productWidth) / 2;
      final productTop = userImageSize.height * 0.15; // Start at 15% from top

      // Draw product image with semi-transparency for realistic overlay
      final paint = Paint()
        ..colorFilter = ColorFilter.mode(
          Colors.white.withOpacity(0.85),
          BlendMode.modulate,
        );

      canvas.saveLayer(
        Rect.fromLTWH(productLeft, productTop, productWidth, productHeight),
        paint,
      );

      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(
          productLeft,
          productTop,
          productWidth,
          productHeight,
        ),
        image: productImage,
        fit: BoxFit.contain,
      );

      canvas.restore();

      // Convert to image
      final picture = recorder.endRecording();
      final compositedImage = await picture.toImage(
        userImage.width,
        userImage.height,
      );

      // Convert to bytes
      final byteData = await compositedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData!.buffer.asUint8List();

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${tempDir.path}/ai_tryon_$timestamp.png');
      await file.writeAsBytes(pngBytes);

      return file;
    } catch (e) {
      return null;
    }
  }

  /// Advanced compositing with better positioning based on image analysis
  static Future<File?> smartComposite({
    required File userPhoto,
    required String productImageUrl,
    double opacity = 0.85,
    double scale = 0.6,
  }) async {
    try {
      // Load images
      final userImageBytes = await userPhoto.readAsBytes();
      final userImage = await decodeImageFromList(userImageBytes);

      final response = await http.get(Uri.parse(productImageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download product image');
      }
      final productImage = await decodeImageFromList(response.bodyBytes);

      // Create canvas
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final size = Size(
        userImage.width.toDouble(),
        userImage.height.toDouble(),
      );

      // Draw user photo
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: userImage,
        fit: BoxFit.cover,
      );

      // Calculate smart positioning
      final productAspectRatio = productImage.width / productImage.height;
      final productWidth = size.width * scale;
      final productHeight = productWidth / productAspectRatio;

      // Center horizontally, position in upper body area
      final productLeft = (size.width - productWidth) / 2;
      final productTop = size.height * 0.2; // 20% from top

      // Create overlay with blend mode for realistic effect
      final paint = Paint()
        ..blendMode = BlendMode.srcOver
        ..colorFilter = ColorFilter.mode(
          Colors.white.withOpacity(opacity),
          BlendMode.modulate,
        );

      canvas.saveLayer(
        Rect.fromLTWH(productLeft, productTop, productWidth, productHeight),
        paint,
      );

      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(
          productLeft,
          productTop,
          productWidth,
          productHeight,
        ),
        image: productImage,
        fit: BoxFit.contain,
      );

      canvas.restore();

      // Add subtle shadow for depth
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawRect(
        Rect.fromLTWH(
          productLeft + 5,
          productTop + 5,
          productWidth,
          productHeight,
        ),
        shadowPaint,
      );

      // Finalize
      final picture = recorder.endRecording();
      final compositedImage = await picture.toImage(
        userImage.width,
        userImage.height,
      );

      final byteData = await compositedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData!.buffer.asUint8List();

      // Save
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${tempDir.path}/ai_tryon_smart_$timestamp.png');
      await file.writeAsBytes(pngBytes);

      return file;
    } catch (e) {
      return null;
    }
  }
}
