import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';

class FullImageView extends StatelessWidget {
  final List images;
  final int initialIndex;

  const FullImageView({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarView(title: 'Product Images '),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Center(
              child: AppCacheImageView(
                imageUrl: images[index].imageUrl,
                // boxFit: BoxFit.cover,
                width: Get.width,
                height: Get.height,
              ),
            ),
          );
        },
      ),
    );
  }
}
