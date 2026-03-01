import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/ai_try_on_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart'
    hide Image;
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:image_picker/image_picker.dart';

class AITryOnView extends StatelessWidget {
  final Product product;

  AITryOnView({super.key, required this.product});

  final AITryOnController controller = Get.put(AITryOnController());

  @override
  Widget build(BuildContext context) {
    // Set product for AI Try-On (supports both Aiuta SDK and custom compositor)
    controller.setProduct(product);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'AI Try On'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Summary Card
            _buildProductSummary(),
            const SizedBox(height: 30),

            // Upload Section Title
            appTextView(
              text: 'Snap or Upload Your Photo',
              size: AppDimensions.FONT_SIZE_18,
              fontWeight: FontWeight.bold,
              color: AppColors.BLACK,
            ),
            const SizedBox(height: 8),
            appTextView(
              text: 'Place yourself in a well-lit area for the best results.',
              size: AppDimensions.FONT_SIZE_12,
              color: AppColors.TEXT_1,
            ),
            const SizedBox(height: 20),

            // Image Upload Area
            _buildUploadArea(),
            const SizedBox(height: 30),

            // Action Buttons
            _buildActionButtons(),
            const SizedBox(height: 40),

            // Preview Section
            _buildPreviewSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildProductSummary() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppCacheImageView(
              imageUrl: product.images?.first.imageUrl ?? '',
              height: 60,
              width: 60,
              boxFit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: product.name ?? 'Product',
                  size: AppDimensions.FONT_SIZE_14,
                  fontWeight: FontWeight.w600,
                ),
                appTextView(
                  text: 'Ready for AI magic!',
                  size: AppDimensions.FONT_SIZE_12,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Obx(() {
      final file = controller.selectedImage.value;
      final isPicking = controller.isPickingImage.value;

      return GestureDetector(
        onTap: isPicking ? null : () => _showImageSourceSheet(),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: file == null
                  ? AppColors.PRIMARY_COLOR.withOpacity(0.3)
                  : Colors.transparent,
              style: BorderStyle.solid,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: isPicking
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 15),
                    appTextView(
                      text: 'Accessing Media...',
                      fontWeight: FontWeight.w500,
                      color: AppColors.TEXT_1,
                    ),
                  ],
                )
              : file == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                    const SizedBox(height: 15),
                    appTextView(
                      text: 'Tap to Upload Photo',
                      fontWeight: FontWeight.w600,
                      color: AppColors.BLACK,
                    ),
                    const SizedBox(height: 5),
                    appTextView(
                      text: 'Camera or Gallery',
                      size: AppDimensions.FONT_SIZE_12,
                      color: AppColors.TEXT_1,
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        file,
                        // fit: BoxFit.cover
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => controller.clearImage(),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildIconButton(
            icon: Icons.camera_alt_outlined,
            label: 'Camera',
            onTap: () => controller.pickImage(ImageSource.camera),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildIconButton(
            icon: Icons.photo_library_outlined,
            label: 'Gallery',
            onTap: () => controller.pickImage(ImageSource.gallery),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.GRAY.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.PRIMARY_COLOR),
            const SizedBox(width: 8),
            appTextView(
              text: label,
              fontWeight: FontWeight.w500,
              size: AppDimensions.FONT_SIZE_14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Obx(() {
      // Show full preview after AI processing
      if (controller.showPreview.value &&
          controller.processedImage.value != null) {
        return _buildFullPreview();
      }

      // Show quick preview before processing
      if (controller.selectedImage.value != null &&
          !controller.isLoading.value) {
        return _buildQuickPreview();
      }

      return const SizedBox.shrink();
    });
  }

  Widget _buildQuickPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: 'Quick Preview',
          size: AppDimensions.FONT_SIZE_18,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildPreviewCard(
                title: 'Your Photo',
                child: Image.file(
                  controller.selectedImage.value!,
                  // fit: BoxFit.cover,
                  width: 140,
                ),
              ),
              const SizedBox(width: 15),
              _buildPreviewCard(
                title: 'Product',
                child: AppCacheImageView(
                  imageUrl: product.images?.first.imageUrl ?? '',
                  width: 140,
                  height: 200,
                  boxFit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              _buildPreviewCard(
                title: 'AI Result',
                child: controller.processedImage.value != null
                    ? Image.file(
                        controller.processedImage.value!,
                        // fit: BoxFit.cover,
                        width: 140,
                      )
                    : Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: AppColors.PRIMARY_COLOR,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              appTextView(
                                text: 'Tap Generate\nto see magic!',
                                size: AppDimensions.FONT_SIZE_11,
                                color: AppColors.TEXT_1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFullPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appTextView(
              text: 'AI Try-On Result',
              size: AppDimensions.FONT_SIZE_18,
              fontWeight: FontWeight.bold,
            ),
            GestureDetector(
              onTap: () => controller.resetProcessing(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 16,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                    const SizedBox(width: 4),
                    appTextView(
                      text: 'Try Again',
                      size: AppDimensions.FONT_SIZE_12,
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Before/After Comparison
        Container(
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Main Result Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image.file(
                      controller.processedImage.value!,
                      width: double.infinity,
                      height: 400,
                      // fit: BoxFit.,
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            appTextView(
                              text: 'AI Enhanced',
                              size: AppDimensions.FONT_SIZE_11,
                              color: AppColors.WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Comparison Thumbnails
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.selectedImage.value!,
                              height: 100,
                              width: double.infinity,
                              // fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          appTextView(
                            text: 'Before',
                            size: AppDimensions.FONT_SIZE_12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.TEXT_1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.processedImage.value!,
                              height: 100,
                              width: double.infinity,
                              // fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          appTextView(
                            text: 'After',
                            size: AppDimensions.FONT_SIZE_12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.PRIMARY_COLOR,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Action Buttons
        /*      Row(
          children: [
            Expanded(
              child: appButtonView(
                buttonName: 'Share Result',
                buttonColor: AppColors.WHITE,
                textColor: AppColors.PRIMARY_COLOR,
                borderColor: AppColors.PRIMARY_COLOR,
                borderWidth: 1.5,
                isIcon: true,
                icon: Icons.share,
                iconColor: AppColors.PRIMARY_COLOR,
                onTap: () {
                  appToastView(title: 'Share feature coming soon!');
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: appButtonView(
                buttonName: 'Add to Cart',
                buttonColor: AppColors.PRIMARY_COLOR,
                textColor: AppColors.WHITE,
                isIcon: true,
                icon: Icons.shopping_cart,
                onTap: () {
                  Get.back();
                  appToastView(title: 'Product added to cart!');
                },
              ),
            ),
          ],
        ),*/
      ],
    );
  }

  Widget _buildPreviewCard({required String title, required Widget child}) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
        ),
        const SizedBox(height: 8),
        appTextView(
          text: title,
          size: AppDimensions.FONT_SIZE_12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Obx(() {
      // Hide button when showing full preview
      if (controller.showPreview.value) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.isLoading.value)
              // Processing UI
              Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.processingProgress.value,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.purple,
                    ),
                    minHeight: 6,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appTextView(
                              text: controller.processingStage.value,
                              fontWeight: FontWeight.w600,
                              size: AppDimensions.FONT_SIZE_14,
                            ),
                            const SizedBox(height: 4),
                            appTextView(
                              text:
                                  '${(controller.processingProgress.value * 100).toInt()}% complete',
                              size: AppDimensions.FONT_SIZE_12,
                              color: AppColors.TEXT_1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              // Generate Button
              appButtonView(
                buttonName: controller.selectedImage.value == null
                    ? 'Upload Photo First'
                    : 'Generate AI Try On',
                buttonColor: controller.selectedImage.value == null
                    ? AppColors.GRAY.withOpacity(0.3)
                    : Colors.purple,
                textColor: AppColors.WHITE,
                isIcon: true,
                icon: Icons.auto_awesome,
                fontWeight: FontWeight.w600,
                onTap: controller.selectedImage.value == null
                    ? () => appToastView(title: 'Please upload a photo first')
                    : () => controller.processAI(),
              ),
          ],
        ),
      );
    });
  }

  void _showImageSourceSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            appTextView(
              text: 'Choose Source',
              size: AppDimensions.FONT_SIZE_18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
