// // views/chat_support_view.dart
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/controllers/refund_controller.dart';
// import 'package:travel_clothing_club_flutter/app_modules/support/model/chat_message_model.dart';
// import 'package:travel_clothing_club_flutter/utils/constants/app_images.dart';
// import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
// import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
// import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
// import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
// import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
// import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
// import 'package:travel_clothing_club_flutter/utils/widgets/svg_icon_widget.dart';
// import '../controllers/chat_controller.dart';
//
// class ChatSupportView extends StatefulWidget {
//   const ChatSupportView({super.key});
//
//   @override
//   State<ChatSupportView> createState() => _ChatSupportViewState();
// }
//
// class _ChatSupportViewState extends State<ChatSupportView>
//     with SingleTickerProviderStateMixin {
//   final ChatController controller = Get.find<ChatController>();
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   late AnimationController _typingAnimationController;
//   late Animation<double> _typingAnimation;
//
//   final RefundController refundController = Get.find<RefundController>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize typing animation
//     _typingAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _typingAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _typingAnimationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }
//
//   // --> dispose
//   @override
//   void dispose() {
//     _typingAnimationController.dispose();
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   // --> Build
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: appBarView(title: 'Chat Support'),
//
//       /*AppBar(
//         elevation: 0,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Chat Support',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.BLACK,
//               ),
//             ),
//             Obx(
//               () => Text(
//                 controller.isTyping.value ? 'Typing...' : 'Online',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                   color: AppColors.BLACK,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: AppColors.background,
//         foregroundColor: Colors.white,
//         // actions: [
//         //   IconButton(
//         //     icon: const Icon(Icons.more_vert),
//         //     onPressed: _showMoreOptions,
//         //   ),
//         // ],
//       ),*/
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 18.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     SvgIconWidget(assetName: AppImages.icBack, size: 40),
//                     const SizedBox(width: 8),
//                     appTextView(
//                       textAlign: TextAlign.center,
//                       text: 'Support',
//                       size: AppDimensions.FONT_SIZE_16,
//                       fontFamily: 'Poppins',
//                       color: AppColors.BLACK,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     const Spacer(),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: refundController.selectedRefund
//                             .getStatusColor()
//                             .withOpacity(0.1),
//                         borderRadius: AppBorderRadius.BORDER_RADIUS_100,
//                         border: Border.all(
//                           color: refundController.selectedRefund
//                               .getStatusColor(),
//                         ),
//                       ),
//                       child: Text(
//                         refundController.selectedRefund.getStatus(),
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: refundController.selectedRefund
//                               .getStatusColor(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ).paddingSymmetric(horizontal: 16),
//                 Container(
//                   height: 1,
//                   color: Colors.grey.shade200,
//                 ).paddingOnly(top: 18, bottom: 28),
//
//                 Row(
//                   children: [
//                     // Left line
//                     Expanded(
//                       child: Container(height: 1, color: Colors.grey.shade300),
//                     ),
//
//                     // Button with padding
//                     InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Container(
//                           height: 30,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           decoration: BoxDecoration(
//                             color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(18),
//                             // border: Border.all(
//                             //   color: AppColors.PRIMARY_COLOR,
//                             //   width: 0.5,
//                             // ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'View Request Details',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.PRIMARY_COLOR,
//                                 // fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // Right line
//                     Expanded(
//                       child: Container(height: 1, color: Colors.grey.shade300),
//                     ),
//                   ],
//                 ).paddingOnly(bottom: 8),
//               ],
//             ),
//           ),
//
//           // Chat Messages
//           Expanded(child: Obx(() => _buildChatMessages())),
//
//           // Typing Indicator
//           Obx(
//             () => controller.isTyping.value
//                 ? _buildTypingIndicator()
//                 : const SizedBox(),
//           ),
//
//           // Message Input
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChatMessages() {
//     if (controller.messages.isEmpty) {
//       return _buildEmptyState();
//     }
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//
//     return ListView.builder(
//       controller: _scrollController,
//       padding: const EdgeInsets.all(16),
//       reverse: false,
//       itemCount: controller.messages.length,
//       itemBuilder: (context, index) {
//         final message = controller.messages[index];
//         return _buildMessageBubble(message);
//       },
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.chat_bubble_outline,
//             size: 80,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'No Messages',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Start a conversation with our support team',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(ChatMessage message) {
//     final isUser = message.isUser;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment: isUser
//             ? MainAxisAlignment.end
//             : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // if (!isUser) ...[
//           //   // Support Agent Avatar
//           //   Container(
//           //     width: 32,
//           //     height: 32,
//           //     decoration: BoxDecoration(
//           //       color: AppColors.PRIMARY_COLOR,
//           //       shape: BoxShape.circle,
//           //     ),
//           //     child: const Icon(
//           //       Icons.support_agent,
//           //       size: 18,
//           //       color: Colors.white,
//           //     ),
//           //   ),
//           //   const SizedBox(width: 8),
//           // ],
//
//           // Message Content
//           Flexible(
//             child: Column(
//               crossAxisAlignment: isUser
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//               children: [
//                 // Message Bubble
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: isUser
//                         ? AppColors.PRIMARY_COLOR.withValues(alpha: 0.7)
//                         : Colors.grey.shade100,
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(16),
//                       topRight: const Radius.circular(16),
//                       bottomLeft: isUser
//                           ? const Radius.circular(16)
//                           : const Radius.circular(4),
//                       bottomRight: isUser
//                           ? const Radius.circular(4)
//                           : const Radius.circular(16),
//                     ),
//                   ),
//                   child: message.type == MessageType.image
//                       ? _buildImageMessage(message)
//                       : _buildTextMessage(message, isUser),
//                 ),
//                 const SizedBox(height: 4),
//
//                 // Time Stamp
//                 Text(
//                   message.formattedTime,
//                   style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//
//           // if (isUser) ...[
//           //   const SizedBox(width: 8),
//           //   // User Avatar
//           //   Container(
//           //     width: 32,
//           //     height: 32,
//           //     decoration: const BoxDecoration(
//           //       color: Colors.green,
//           //       shape: BoxShape.circle,
//           //     ),
//           //     child: const Icon(Icons.person, size: 18, color: Colors.white),
//           //   ),
//           // ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextMessage(ChatMessage message, bool isUser) {
//     return Text(
//       message.message,
//       style: TextStyle(
//         color: isUser ? Colors.white : Colors.black87,
//         fontSize: 14,
//         height: 1.4,
//       ),
//     );
//   }
//
//   Widget _buildImageMessage(ChatMessage message) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 200,
//           height: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             image: const DecorationImage(
//               image: AssetImage('assets/placeholder.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: message.imageUrl != null
//               ? null
//               : const Center(
//                   child: Icon(Icons.photo, size: 40, color: Colors.white),
//                 ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           message.message,
//           style: const TextStyle(color: Colors.white, fontSize: 12),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTypingIndicator() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.support_agent,
//               size: 18,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildAnimatedTypingDot(0),
//                 _buildAnimatedTypingDot(1),
//                 _buildAnimatedTypingDot(2),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAnimatedTypingDot(int index) {
//     return AnimatedBuilder(
//       animation: _typingAnimationController,
//       builder: (context, child) {
//         return Padding(
//           padding: EdgeInsets.only(
//             left: index == 0 ? 0 : 4,
//             right: index == 2 ? 0 : 4,
//           ),
//           child: Opacity(
//             opacity: _getDotOpacity(index),
//             child: Container(
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade600,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   double _getDotOpacity(int index) {
//     final time = DateTime.now().millisecondsSinceEpoch / 1000;
//     final offset = index * 0.2;
//     return (0.5 + 0.5 * sin(time * 4 + offset)).clamp(0.3, 1.0);
//   }
//
//   Widget _buildMessageInput() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 28.0, left: 8, right: 8),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: Colors.grey.shade300)),
//         ),
//         child: Row(
//           children: [
//             // Attachment Button
//             // IconButton(
//             //   icon: const Icon(Icons.attach_file, color: Colors.grey),
//             //   onPressed: _showAttachmentOptions,
//             // ),
//
//             // Message Input Field
//             Expanded(
//               child: TextField(
//                 controller: _messageController,
//                 onChanged: (value) => controller.newMessage.value = value,
//                 decoration: InputDecoration(
//                   hintText: 'Type something here',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                 ),
//                 maxLines: null,
//                 textInputAction: TextInputAction.send,
//                 onSubmitted: (value) {
//                   if (value.trim().isNotEmpty) {
//                     controller.sendMessage(value);
//                     _messageController.clear();
//                   }
//                 },
//               ),
//             ),
//
//             const SizedBox(width: 8),
//
//             // Send Button
//             Obx(() {
//               final hasText = controller.newMessage.value.trim().isNotEmpty;
//               return appButtonView(
//                 buttonHeight: 40,
//                 buttonWidth: 60,
//                 textSize: 14,
//                 buttonName: 'Send',
//                 buttonColor: AppColors.PRIMARY_COLOR,
//                 textColor: AppColors.WHITE,
//                 onTap: () {
//                   if (hasText) {
//                     controller.sendMessage(_messageController.text);
//                     _messageController.clear();
//                   }
//                 },
//               );
//
//               //   IconButton(
//               //   icon: Container(
//               //     width: 40,
//               //     height: 40,
//               //     decoration: BoxDecoration(
//               //       color: hasText ? Colors.blue : Colors.grey.shade300,
//               //       shape: BoxShape.circle,
//               //     ),
//               //     child: ,
//               //   ),
//               //   onPressed: hasText
//               //       ? () {
//               //           controller.sendMessage(_messageController.text);
//               //           _messageController.clear();
//               //         }
//               //       : null,
//               // );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showMoreOptions() {
//     showModalBottomSheet(
//       context: Get.context!,
//       builder: (context) => SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.delete),
//               title: const Text('Clear Chat'),
//               onTap: () {
//                 Get.back();
//                 _showClearChatDialog();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('Support Info'),
//               onTap: () {
//                 Get.back();
//                 _showSupportInfo();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.phone),
//               title: const Text('Call Support'),
//               onTap: () {
//                 Get.back();
//                 _showCallSupportDialog();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAttachmentOptions() {
//     showModalBottomSheet(
//       context: Get.context!,
//       builder: (context) => SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Photo Library'),
//               onTap: () {
//                 Get.back();
//                 _pickImageFromGallery();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_camera),
//               title: const Text('Take Photo'),
//               onTap: () {
//                 Get.back();
//                 _takePhoto();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.description),
//               title: const Text('Document'),
//               onTap: () {
//                 Get.back();
//                 Get.snackbar(
//                   'Coming Soon',
//                   'Document upload feature will be available soon',
//                   snackPosition: SnackPosition.BOTTOM,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _pickImageFromGallery() {
//     // Simulate image picking
//     controller.sendImage('assets/chat_image.jpg');
//     Get.snackbar(
//       'Image Sent',
//       'Image has been shared in the chat',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   void _takePhoto() {
//     // Simulate taking photo
//     controller.sendImage('assets/camera_image.jpg');
//     Get.snackbar(
//       'Photo Sent',
//       'Photo has been shared in the chat',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   void _showClearChatDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Clear Chat'),
//         content: const Text(
//           'Are you sure you want to clear all chat messages? This action cannot be undone.',
//         ),
//         actions: [
//           TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
//           TextButton(
//             onPressed: () {
//               Get.back();
//               controller.clearChat();
//             },
//             child: const Text('Clear', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showSupportInfo() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Support Information'),
//         content: const Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('🕒 Support Hours: 24/7'),
//             SizedBox(height: 8),
//             Text('📞 Phone: +1 (555) 123-HELP'),
//             SizedBox(height: 8),
//             Text('✉️ Email: support@rideshare.com'),
//             SizedBox(height: 8),
//             Text('💬 Average Response Time: 2-5 minutes'),
//           ],
//         ),
//         actions: [
//           TextButton(onPressed: () => Get.back(), child: const Text('Close')),
//         ],
//       ),
//     );
//   }
//
//   void _showCallSupportDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Call Support'),
//         content: const Text(
//           'Would you like to call our support team at +1 (555) 123-HELP?',
//         ),
//         actions: [
//           TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
//           TextButton(
//             onPressed: () {
//               Get.back();
//               Get.snackbar(
//                 'Calling Support',
//                 'Connecting you to our support team...',
//                 snackPosition: SnackPosition.BOTTOM,
//               );
//             },
//             child: const Text('Call'),
//           ),
//         ],
//       ),
//     );
//   }
// }
