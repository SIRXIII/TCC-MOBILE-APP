// views/product_details_view.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/cart/controllers/cart_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/views/widgets/full_image_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/views/widgets/rental_days_selector_view.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import '../controllers/product_details_controller.dart';
import '../models/product_model.dart' hide Image;
import 'ai_try_on_view.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product = LoggedInUserData.instance.getSelectedProduct;

  ProductDetailsView({super.key});

  final CartController cartController = Get.put(CartController());
  // final TravelerHomeController travelerHomeController = Get.find();

  final LoggedInUserData loggedInUserData = LoggedInUserData.instance;

  // --> Build
  @override
  Widget build(BuildContext context) {
    final ProductDetailsController controller = Get.put(
      ProductDetailsController(),
    );

    controller.setProduct(product);

    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with Image Slider
          _buildAppBarWithSlider(controller),

          // Product Details
          _buildProductDetails(controller),

          // Seller Info
          _buildSellerInfo(controller),

          // Rental Days Selector
          RentalDaysSelectorView(
            minRental: int.parse(product.getMinRental()),
            maxRental: int.parse(product.getMaxRental()),
          ),

          // Size Selection
          _buildSizeSelection(controller),

          // Color Selection
          _buildColorSelection(controller),

          // Material Info
          _buildMaterialInfo(controller),

          // Ratings & Reviews
          // _buildRatingsReviews(controller),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(controller),
    );
  }

  SliverAppBar _buildAppBarWithSlider(ProductDetailsController controller) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      expandedHeight: 400,
      title: appTextView(
        // text: 'Product Detail',
        text: '',
        fontWeight: FontWeight.w600,
        color: AppColors.BLACK,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: () {
            // debugPrint('asdfs');
            Get.to(
              () => FullImageView(
                images: controller.product.value!.images!,
                initialIndex: controller.currentIndex.value,
              ),
            );
          },
          child: Stack(
            children: [
              // Image Slider
              PageView.builder(
                controller: controller.pageController,
                itemCount: product.images?.length ?? 0,
                onPageChanged: controller.changeImageIndex,
                itemBuilder: (context, index) {
                  return AppCacheImageView(
                    imageUrl: product.images?[index].imageUrl ?? '',
                    width: Get.width,
                    height: 300,
                    boxFit: BoxFit.cover,
                  );
                },
              ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  ),
                ),
              ),

              // Image Indicator
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.product.value?.images?.length ?? 0,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentIndex.value == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgIconWidget(assetName: AppImages.icBack),
        ),
      ),
      /*actions: [
        Obx(
          () => IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                controller.isFavorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: controller.isFavorite.value ? Colors.red : Colors.white,
              ),
            ),
            onPressed: controller.toggleFavorite,
          ),
        ),
      ],*/
      elevation: 0,
      pinned: true,
    );
  }

  SliverToBoxAdapter _buildProductDetails(ProductDetailsController controller) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name
            appTextView(
              text: controller.product.value?.name ?? '',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Roboto',
              color: AppColors.BLACK,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(height: 8),

            appTextView(
              text: controller.product.value!.getNote(),
              size: AppDimensions.FONT_SIZE_12,
              fontFamily: 'Roboto',
              color: AppColors.TEXT_1,
            ),
            /*  // Rating and Reviews
            Row(
              children: [
                // Rating Stars
                _buildRatingStars(controller.product.value?.rating ?? 0),
                const SizedBox(width: 8),
                Text(
                  '${controller.product.value?.rating}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${controller.product.value?.reviewCount} reviews)',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),*/

            // Price
            _buildPriceSection(controller),
            // const SizedBox(height: 16),

            /*  // Stock Status
            if (controller.product.value?.stock != null)
              Text(
                'In Stock: ${controller.product.value?.stock} items',
                style: TextStyle(
                  color: (controller.product.value?.stock ?? 0) > 0
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(ProductDetailsController controller) {
    final product = controller.product.value;
    if (product == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          appTextView(
            text: 'Price:',
            size: AppDimensions.FONT_SIZE_14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6,
              ),
              child: Row(
                children: [
                  appTextView(
                    text:
                        '\$${double.parse(product.basePrice!).toStringAsFixed(2)} ',
                    size: AppDimensions.FONT_SIZE_12,
                    fontFamily: 'Roboto',
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                  appTextView(
                    text: ' for ${product.minRental} days',
                    size: AppDimensions.FONT_SIZE_12,
                    fontFamily: 'Roboto',
                    color: AppColors.BLACK,
                  ),
                ],
              ),
            ),
          ),
          /* const SizedBox(width: 8),
          if (product.hasDiscount)
            Text(
              '\$${product.originalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
                decoration: TextDecoration.lineThrough,
              ),
            ),
          const SizedBox(width: 8),
          if (product.hasDiscount)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${product.discountPercentage.round()}% OFF',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSizeSelection(ProductDetailsController controller) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appTextView(
              text: 'Available Size:',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),

            // const SizedBox(height: 8),

            /*    Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    appTextView(
                      text: '${loggedInUserData.getSelectedProduct.sizes}',
                      size: AppDimensions.FONT_SIZE_12,
                      fontFamily: 'Roboto',
                      color: AppColors.BLACK,
                    ),
                  ],
                ),
              ),
            ),*/
            // ChoiceChip(
            //   label: Text('${loggedInUserData.getSelectedProduct.sizes}'),
            //   selected: true,
            //   // onSelected: (selected) => controller.selectSize(size),
            //   selectedColor: AppColors.PRIMARY_COLOR,
            //   labelStyle: TextStyle(
            //     color: AppColors.WHITE,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  loggedInUserData.getSelectedProduct.sizes?.map((size) {
                    return Obx(() {
                      bool isSelected =
                          controller.selectedSize.value == size.size;
                      return ChoiceChip(
                        label: Text(
                          size.getSize(),
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? AppColors.WHITE
                                : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (size.isStockAvailable()) {
                            controller.selectSize(size.size ?? '');
                          } else {
                            appToastView(title: 'Size currently not available');
                          }
                        },
                        selectedColor: AppColors.PRIMARY_COLOR,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    });
                  }).toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildColorSelection(ProductDetailsController controller) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appTextView(
              text: 'Available Color:',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 6),

            product.productColors.isEmpty
                ? appTextView(
                    text: 'N/A',
                    size: AppDimensions.FONT_SIZE_12,
                    fontFamily: 'Poppins',
                    // fontWeight: FontWeight.w500,
                  )
                : Wrap(
                    spacing: 12,
                    children: product.productColors.map((pc) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () => controller.selectColor(pc),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: pc.color,
                              shape: BoxShape.rectangle,
                              borderRadius: AppBorderRadius.BORDER_RADIUS_8,
                              border: Border.all(
                                color: controller.isSelected(pc)
                                    ? AppColors.PRIMARY_COLOR
                                    : Colors.grey.shade400,
                                width: controller.isSelected(pc) ? 3 : 1,
                              ),
                            ),
                            child: controller.isSelected(pc)
                                ? Icon(
                                    Icons.check,
                                    color: AppColors.WHITE,
                                    size: 16,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

            // Container(
            //   // color: loggedInUserData.getSelectedProduct.color?.toColor(),
            //   height: 20,
            //   width: 20,
            //   decoration: BoxDecoration(
            //     color: loggedInUserData.getSelectedProduct.color?.toColor(),
            //     borderRadius: BorderRadius.circular(6), // rounded corners
            //   ),
            // ),
            // Row(
            //   children: product.getColorList().map((color) {
            //     return Container(
            //       margin: const EdgeInsets.only(right: 6),
            //       width: 20,
            //       height: 20,
            //       decoration: BoxDecoration(
            //         color: color,
            //         shape: BoxShape.circle,
            //         border: Border.all(color: Colors.grey),
            //       ),
            //     );
            //   }).toList(),
            // ),

            /*     Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  loggedInUserData.getSelectedProduct.getColorList().map((
                    color,
                  ) {
                    return Obx(() {
                      bool isSelected = controller.selectedColor.value == color;
                      return FilterChip(
                        label: Text(color),
                        selected: isSelected,
                        onSelected: (selected) => controller.selectColor(color),
                        selectedColor: _getColorFromString(color),
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    });
                  }).toList() ??
                  [],
            ),*/
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMaterialInfo(ProductDetailsController controller) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appTextView(
              text: 'Fabric / Material:',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 6),
            Row(
              children: [
                // Icon(Icons.info_outline, color: Colors.blue[600]),
                // const SizedBox(width: 12),
                Expanded(
                  child: appTextView(
                    text:
                        controller.product.value?.material ??
                        'Material information not available',
                    size: AppDimensions.FONT_SIZE_12,
                    fontFamily: 'Roboto',
                    color: AppColors.BLACK,
                    // fontWeight: FontWeight.bold,
                  ),
                  // Text(
                  //   controller.product.value?.material ??
                  //       'Material information not available',
                  //   style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSellerInfo(ProductDetailsController controller) {
    // final seller = controller.product.value?.seller;
    // if (seller == null) return const SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppCacheImageView(
                  imageUrl: product.partner?.getProfileImage() ?? '',
                  height: 30, // make sure width = height for a perfect circle
                  width: 30,
                  isProfile: true,
                  boxFit: BoxFit.cover,
                  // fit: BoxFit.cover,
                ),

                const SizedBox(width: 12),

                // Seller Details
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appTextView(
                        text:
                            controller.product.value?.partner?.getName() ??
                            'N/A',
                        size: AppDimensions.FONT_SIZE_12,
                        fontFamily: 'Roboto',
                        color: AppColors.BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                      controller.product.value?.partner?.getRating() == ''
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: AppColors.PRIMARY_COLOR,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    controller.product.value?.partner
                                            ?.getRating() ??
                                        '0.0',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(ProductDetailsController controller) {
    return Container(
      height: Get.height * 0.14,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              /*       // Quantity Selector
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: controller.decreaseQuantity,
                    ),
                    Obx(
                      () => Text(
                        '${controller.quantity.value}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: controller.increaseQuantity,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Add to Cart Button
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.addToCart,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: AppColors.PRIMARY_COLOR),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
          */
              product.isStockAvailable()
                  ? Expanded(
                      child: Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                            bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'Add to Cart',
                              height: 40,
                              onPressed: () {
                                cartController.addToCart(
                                  product: product,
                                  size: controller.selectedSize.value,
                                  color:
                                      controller.selectedColor.value?.name ??
                                      '',
                                  // size: 'product.getSize()',
                                  rentalDays:
                                      controller.selectedRentalDayValue.value,
                                  quantity: 1,
                                );
                              },
                              isEnabled:
                                  controller.selectedRentalDayValue.value != -1,
                            ),
                          ),
                        ),
                      ),
                      /*appButtonView(
                  buttonHeight: 40,
                  buttonName: 'Add to Cart',
                  buttonColor: AppColors.PRIMARY_COLOR,
                  textColor: AppColors.WHITE,
                  onTap: () {
                    cartController.addToCart(
                      product: product,
                      size: controller.selectedSize.value,
                      rentalDays: controller.selectedRentalDayValue.value,
                      quantity: 1,
                    );

                    // appTextView(text: 'Added in cart Successfully');

                    // controller.addToCart(product);
                  },
                )*/
                      // ElevatedButton(
                      //   onPressed: controller.buyNow,
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColors.PRIMARY_COLOR,
                      //     foregroundColor: AppColors.WHITE,
                      //     padding: const EdgeInsets.symmetric(vertical: 12),
                      //   ),
                      //   child: const Text(
                      //     'Add to Cart',
                      //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      //   ),
                      // ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: appButtonView(
                            textSize: 13,
                            buttonHeight: 35,
                            buttonWidth: Get.width,
                            buttonName: 'Product Unavailable',
                            buttonColor: AppColors.GRAY.withValues(alpha: 0.5),
                            textColor: AppColors.WHITE,
                            // fontWeight: FontWeight.w600,
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),

              // Buy Now Button
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4.0,
              bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: appButtonView(
                isIcon: true,
                icon: Icons.auto_awesome,
                iconSize: 20,
                textSize: 13,
                buttonHeight: 40,
                buttonWidth: Get.width,
                buttonName: 'Try On With AI',
                buttonColor: Colors.purple,
                textColor: AppColors.WHITE,
                fontWeight: FontWeight.w600,
                onTap: () {
                  Get.to(() => AITryOnView(product: product));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
