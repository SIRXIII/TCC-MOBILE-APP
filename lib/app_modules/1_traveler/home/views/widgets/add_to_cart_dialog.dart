// // widgets/add_to_cart_dialog.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/1_traveler/cart/controllers/cart_controller.dart';
// import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
// import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
// import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
//
// class AddToCartDialog extends StatefulWidget {
//   final Product product;
//
//   const AddToCartDialog({super.key, required this.product});
//
//   @override
//   State<AddToCartDialog> createState() => _AddToCartDialogState();
// }
//
// class _AddToCartDialogState extends State<AddToCartDialog> {
//   // final CartController cartController = Get.find<CartController>();
//   final CartController cartController = Get.put(CartController());
//
//   final RxString _selectedSize = 'M'.obs;
//   final RxInt _rentalDays = 3.obs;
//   final RxInt _quantity = 1.obs;
//
//   final List<String> _availableSizes = ['S', 'M', 'L', 'XL'];
//   final List<Map<String, dynamic>> _rentalOptions = [
//     {'days': 3, 'label': '3 days', 'priceMultiplier': 1.0},
//     {'days': 4, 'label': '4 days', 'priceMultiplier': 1.2},
//     {'days': 7, 'label': '7 days', 'priceMultiplier': 1.5},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.all(20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Container(
//         constraints: const BoxConstraints(maxWidth: 500),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               _buildHeader(),
//
//               // Product Info
//               _buildProductInfo(),
//
//               // Size Selection
//               _buildSizeSection(),
//
//               // Rental Duration
//               _buildRentalDurationSection(),
//
//               // Quantity Selector
//               _buildQuantitySection(),
//
//               // Total Price
//               _buildTotalPriceSection(),
//
//               // Add to Cart Button
//               _buildAddToCartButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.shopping_cart, color: AppColors.PRIMARY_COLOR),
//           const SizedBox(width: 12),
//           const Text(
//             'Add to Cart',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(Icons.close, size: 20),
//             onPressed: () => Get.back(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductInfo() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           // Product Image
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               image: DecorationImage(
//                 image: AssetImage(widget.product.images![0].imageUrl ?? ''),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//
//           // Product Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.product.getName(),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   widget.product.category ?? '',
//                   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '\$${widget.product.getPrice().toStringAsFixed(2)} / day',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.PRIMARY_COLOR,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSizeSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Size',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           Obx(
//             () => Wrap(
//               spacing: 8,
//               children: _availableSizes.map((size) {
//                 return ChoiceChip(
//                   label: Text(size),
//                   selected: _selectedSize.value == size,
//                   onSelected: (selected) {
//                     _selectedSize.value = size;
//                   },
//                   selectedColor: AppColors.PRIMARY_COLOR,
//                   labelStyle: TextStyle(
//                     color: _selectedSize.value == size
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRentalDurationSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Rental Duration',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           Obx(
//             () => Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: _rentalOptions.map((option) {
//                 return ChoiceChip(
//                   label: Text(option['label']),
//                   selected: _rentalDays.value == option['days'],
//                   onSelected: (selected) {
//                     _rentalDays.value = option['days'];
//                   },
//                   selectedColor: AppColors.PRIMARY_COLOR,
//                   labelStyle: TextStyle(
//                     color: _rentalDays.value == option['days']
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuantitySection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Quantity',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           Obx(
//             () => Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Decrease Button
//                   IconButton(
//                     icon: const Icon(Icons.remove, size: 20),
//                     onPressed: _quantity.value > 1
//                         ? () {
//                             _quantity.value--;
//                           }
//                         : null,
//                     style: IconButton.styleFrom(
//                       foregroundColor: _quantity.value > 1
//                           ? Colors.black
//                           : Colors.grey,
//                     ),
//                   ),
//
//                   // Quantity Display
//                   Container(
//                     width: 40,
//                     alignment: Alignment.center,
//                     child: Text(
//                       _quantity.value.toString(),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//
//                   // Increase Button
//                   IconButton(
//                     icon: const Icon(Icons.add, size: 20),
//                     onPressed: () {
//                       _quantity.value++;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTotalPriceSection() {
//     return Obx(() {
//       final selectedOption = _rentalOptions.firstWhere(
//         (option) => option['days'] == _rentalDays.value,
//       );
//       final totalPrice =
//           widget.product.getPrice() *
//           _quantity.value *
//           _rentalDays.value *
//           (selectedOption['priceMultiplier'] as double);
//
//       return Container(
//         margin: const EdgeInsets.all(16),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.teal.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.teal.withOpacity(0.3)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Total Price',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             Text(
//               '\$${totalPrice.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.PRIMARY_COLOR,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildAddToCartButton() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: SizedBox(
//         width: double.infinity,
//         child: appButtonView(
//           buttonHeight: 40,
//           buttonName: 'Add to Cart',
//           buttonColor: AppColors.PRIMARY_COLOR,
//           textColor: AppColors.WHITE,
//           onTap: _addToCart,
//         ),
//         // ElevatedButton(
//         //   onPressed: _addToCart,
//         //   style: ElevatedButton.styleFrom(
//         //     backgroundColor: Colors.teal,
//         //     foregroundColor: Colors.white,
//         //     padding: const EdgeInsets.symmetric(vertical: 16),
//         //     shape: RoundedRectangleBorder(
//         //       borderRadius: BorderRadius.circular(8),
//         //     ),
//         //   ),
//         //   child: const Text(
//         //     'Add to Cart',
//         //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         //   ),
//         // ),
//       ),
//     );
//   }
//
//   void _addToCart() {
//     cartController.addToCart(
//       product: widget.product,
//       size: _selectedSize.value,
//       rentalDays: _rentalDays.value,
//       quantity: _quantity.value,
//     );
//
//     Get.back();
//   }
// }
