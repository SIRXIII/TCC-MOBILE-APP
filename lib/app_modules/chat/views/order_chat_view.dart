import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/chat/controllers/order_chat_controller.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/extensions/date_time+ext.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/lined_text_view.dart';

class OrderChatView extends StatelessWidget {
  String orderId = '';
  final String receiverId;
  final String currentUserId;

  OrderChatView({
    super.key,
    this.orderId = '',
    required this.receiverId,
    required this.currentUserId,
  });

  final TextEditingController _messageController = TextEditingController();

  final OrderChatController controller = Get.find<OrderChatController>();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(OrderChatController());
    // SET USER IDs
    controller.currentUserId = currentUserId;
    controller.receiverId = receiverId;
    orderId = AppGlobal.instance.orderId;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(
        title: AppGlobal.instance.chatWithName,
        subTitle: AppGlobal.instance.chatWith,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: LinedText(text: AppGlobal.instance.orderId),
          ),
          // MESSAGES LIST
          Expanded(
            child: StreamBuilder(
              stream: controller.messagesForOrder(orderId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!;

                if (messages.isEmpty) {
                  return const Center(
                    child: Text("No messages yet. Start conversation!"),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  reverse: false,
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == controller.currentUserId;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
                        decoration: BoxDecoration(
                          color: isMe
                              ? AppColors.PRIMARY_COLOR
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: isMe
                                ? const Radius.circular(12)
                                : const Radius.circular(0),
                            bottomRight: isMe
                                ? const Radius.circular(0)
                                : const Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.message,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Text("${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                            Text(
                              msg.timestamp.timeAgo(),
                              style: TextStyle(
                                fontSize: 10,
                                color: isMe
                                    ? Colors.white70
                                    : Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const Divider(height: 1),

          // MESSAGE INPUT BAR
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28.0),
        child: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.photo_library),
            //   onPressed: _pickImage,
            // ),
            Expanded(
              child: TextField(
                controller: _messageController,
                // onChanged: (value) => controller.newMessage.value = value,
                decoration: InputDecoration(
                  hintText: 'Type something here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(width: 8),
            Obx(() {
              // final hasText = _messageController.text.value.trim().isNotEmpty;

              return appButtonView(
                buttonHeight: 40,
                buttonWidth: 60,
                textSize: 14,
                buttonName: 'Send',
                buttonColor: AppColors.PRIMARY_COLOR,
                textColor: AppColors.WHITE,
                onTap: controller.isSending.value
                    ? () {}
                    : () {
                        if (_messageController.text.trim().isNotEmpty) {
                          controller.sendMessage(
                            orderId,
                            _messageController.text,
                          );
                          _messageController.clear();
                        }
                      },

                // onTap: () {
                //   if (chatController.isSending.value) {
                //     if (_messageController.text.trim().isNotEmpty) {
                //       chatController.sendTextMessage(
                //         widget.receiverId,
                //         _messageController.text,
                //       );
                //       _messageController.clear();
                //     }
                //   }
                // },
              );
            }),
          ],
        ),
      ),
    );
  }

  /*Widget _buildMessageInput(OrderChatController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            // INPUT FIELD
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  onChanged: (v) => controller.messageText.value = v,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // SEND BUTTON
            Obx(
              () => controller.isSending.value
                  ? const CircularProgressIndicator(strokeWidth: 2)
                  : GestureDetector(
                      onTap: () => controller.sendMessage(orderId),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }*/
}
