import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
import 'package:travel_clothing_club_flutter/service/fashn_ai_service.dart';
import 'package:travel_clothing_club_flutter/service/image_compositor.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_clothing_club_flutter/utils/stripe_config.dart';
import 'package:dio/dio.dart' as dio;

class AITryOnController extends GetxController {
  // - PROPERTIES
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<File?> processedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final RxBool isLoading = false.obs;
  final RxBool isPickingImage = false.obs;
  final RxString processingStage = ''.obs;
  final RxDouble processingProgress = 0.0.obs;
  final RxBool showPreview = false.obs;
  final RxBool useFashnAI = false.obs;

  String? productImageUrl;
  Product? currentProduct;

  @override
  void onInit() {
    super.onInit();
    _checkFashnAIAvailability();
  }

  void _checkFashnAIAvailability() {
    useFashnAI.value = FashnAIService.isConfigured();
    if (useFashnAI.value) {
    } else {
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      isPickingImage.value = true;
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        processedImage.value = null;
        showPreview.value = false;
      }
    } catch (e) {
      appToastView(
        title:
            'Could not access ${source == ImageSource.camera ? 'camera' : 'gallery'}',
      );
    } finally {
      isPickingImage.value = false;
    }
  }

  void clearImage() {
    selectedImage.value = null;
    processedImage.value = null;
    showPreview.value = false;
    processingProgress.value = 0.0;
    processingStage.value = '';
  }

  /// Process AI Try-On using Fashn.AI or fallback to custom compositor
  Future<void> processAI() async {
    if (useFashnAI.value && currentProduct != null) {
      // Use Fashn.AI for professional try-on
      await _processWithFashnAI();
    } else {
      // Fallback to custom compositor
      await _processWithCustomCompositor();
    }
  }

  /// Use Fashn.AI API for virtual try-on
  Future<void> _processWithFashnAI() async {
    if (selectedImage.value == null) {
      appToastView(title: 'Please upload a photo first');
      return;
    }

    if (currentProduct == null || productImageUrl == null) {
      appToastView(title: 'Product information not available');
      return;
    }

    try {
      isLoading.value = true;
      showPreview.value = false;

      // Start with preparation
      processingStage.value = 'Preparing your image...';
      processingProgress.value = 0.05;

      // Detect garment category
      final category = FashnAIService.detectCategory(currentProduct!);

      performTryOn(
        modelImage: selectedImage.value!,
        productImageUrl: productImageUrl!,
      );
    } catch (e) {
      isLoading.value = false;

      String errorMsg = 'Try-on failed. Please try again.';
      final errorStr = e.toString().toLowerCase();

      if (errorStr.contains('timed out') || errorStr.contains('5 minutes')) {
        errorMsg =
            'AI servers are very busy right now. Please wait a few minutes and try again.';
      } else if (errorStr.contains('api key') ||
          errorStr.contains('configured')) {
        errorMsg =
            'AI service configuration error. Please check your settings.';
      } else if (errorStr.contains('failed') || errorStr.contains('error')) {
        errorMsg =
            'AI couldn\'t process this photo. Try a clearer photo with better lighting.';
      }

      // appToastView(title: errorMsg);
    }
  }

  /// Fallback to custom image compositor
  Future<void> _processWithCustomCompositor() async {
    if (selectedImage.value == null) {
      appToastView(title: 'Please upload a photo first');
      return;
    }

    if (productImageUrl == null || productImageUrl!.isEmpty) {
      appToastView(title: 'Product image not available');
      return;
    }

    isLoading.value = true;
    showPreview.value = false;

    // Simulate AI Processing stages
    await _simulateAIProcessing();

    // Perform image compositing
    processingStage.value = 'Creating your try-on...';
    final compositedFile = await ImageCompositor.smartComposite(
      userPhoto: selectedImage.value!,
      productImageUrl: productImageUrl!,
      opacity: 0.88,
      scale: 0.55,
    );

    if (compositedFile != null) {
      processedImage.value = compositedFile;
      isLoading.value = false;
      showPreview.value = true;
      appToastView(title: 'Try-On complete!');
    } else {
      isLoading.value = false;
      appToastView(title: 'Failed to process image. Please try again.');
    }
  }

  Future<void> _simulateAIProcessing() async {
    processingStage.value = 'Analyzing your photo...';
    processingProgress.value = 0.0;
    await Future.delayed(const Duration(milliseconds: 500));
    processingProgress.value = 0.25;

    processingStage.value = 'Detecting body landmarks...';
    await Future.delayed(const Duration(milliseconds: 600));
    processingProgress.value = 0.5;

    processingStage.value = 'Fitting the garment...';
    await Future.delayed(const Duration(milliseconds: 700));
    processingProgress.value = 0.75;

    processingStage.value = 'Applying final touches...';
    await Future.delayed(const Duration(milliseconds: 400));
    processingProgress.value = 0.9;
  }

  void resetProcessing() {
    processedImage.value = null;
    showPreview.value = false;
    processingProgress.value = 0.0;
    processingStage.value = '';
  }

  void setProductImageUrl(String url) {
    productImageUrl = url;
  }

  void setProduct(Product product) {
    currentProduct = product;
    if (product.images != null && product.images!.isNotEmpty) {
      productImageUrl = product.images!.first.imageUrl;
    }
  }

  // - pollFashnPrediction
  Future<Map<String, dynamic>?> pollFashnPrediction({
    required String predictionId,
    required String apiKey,
  }) async {
    final headers = {'Authorization': 'Bearer $apiKey'};

    while (true) {
      final url = Uri.parse('https://api.fashn.ai/v1/status/$predictionId');
      try {
        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200) {
          final statusData = jsonDecode(response.body);
          final status = statusData['status'];

          if (status == 'completed') {
            return statusData;
          } else if (status == 'failed') {
            return statusData;
          } else if (['starting', 'in_queue', 'processing'].contains(status)) {
            await Future.delayed(
              Duration(seconds: 3),
            ); // Wait for 3 seconds before polling again
          } else {
            return null;
          }
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
  }

  // - runFashnPrediction
  Future<String?> runFashnPrediction({
    required String modelName,
    required Map<String, dynamic> inputs,
    required String apiKey,
  }) async {
    final url = Uri.parse('https://api.fashn.ai/v1/run');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({'model_name': modelName, 'inputs': inputs});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['id']; // Return the prediction ID
      } else {
        appToastView(title: response.body);
        return null;
      }
    } catch (e) {
      // appToastView(title: ${e.toString()});
      return null;
    }
  }

  // - performTryOn
  void performTryOn({
    required File modelImage,
    required String productImageUrl,
  }) async {
    // Convert model image to base64
    final imageBytes = await modelImage.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final inputs = {
      'model_image': 'data:image/jpeg;base64,$base64Image',
      // 'model_image': modelImage.path,
      'garment_image': productImageUrl,
      'output_format': 'png',
      'return_base64': false, // Set to true if you want base64 output
    };

    String? predictionId = await runFashnPrediction(
      modelName: 'tryon-v1.6',
      inputs: inputs,
      apiKey: StripeConfig.fashnAPIKey,
    );

    if (predictionId != null) {
      Map<String, dynamic>? result = await pollFashnPrediction(
        predictionId: predictionId,
        apiKey: StripeConfig.fashnAPIKey,
      );

      if (result != null && result['status'] == 'completed') {
        // Process the output, e.g., display the image
        processingProgress.value = 1.0;
        processingStage.value = 'Success!';

        // processedImage.value = result['output'][0];
        processedImage.value = await _downloadImage(result['output'][0]);
        isLoading.value = false;
        showPreview.value = true;
        // appToastView(title: '✨ AI Try-On complete! Powered by Fashn.AI');
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
  }

  // Download generated image from URL
  Future<File> _downloadImage(String imageUrl) async {
    try {

      final response = await dio.Dio().get(
        imageUrl,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      // Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${tempDir.path}/fashn_tryon_$timestamp.png');

      await file.writeAsBytes(response.data);

      return file;
    } catch (e) {
      rethrow;
    }
  }
}
