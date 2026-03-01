// views/chat_conversation_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/data/app_global.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_message_model.dart';

class ChatConversationView extends StatefulWidget {
  final String receiverId;
  final String titleName;

  const ChatConversationView({
    super.key,
    required this.receiverId,
    required this.titleName,
  });

  @override
  State<ChatConversationView> createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  final ChatController chatController = Get.put(ChatController());
  // final ChatController chatController = Get.find<ChatController>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // final RefundController refundController = Get.find<RefundController>();

  @override
  void initState() {
    super.initState();
    chatController.loadMessages(widget.receiverId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarView(
        title: widget.titleName,
        subTitle: AppGlobal.instance.chatWith,
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() => _buildMessagesList())),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    if (chatController.messages.isEmpty) {
      return const Center(
        child: Text('No messages yet. Start a conversation!'),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: chatController.messages.length,
      itemBuilder: (context, index) {
        final message = chatController.messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isMe = message.senderId == chatController.currentUserId;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // if (!isMe) ...[
          //   const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),
          //   const SizedBox(width: 8),
          // ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors.PRIMARY_COLOR
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isMe
                          ? const Radius.circular(16)
                          : const Radius.circular(4),
                      bottomRight: isMe
                          ? const Radius.circular(4)
                          : const Radius.circular(16),
                    ),
                  ),
                  child: message.type == MessageType.image
                      ? _buildImageMessage(message)
                      : Text(
                          message.message,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.formattedTime,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          // if (isMe) ...[
          //   const SizedBox(width: 8),
          //   const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),
          // ],
        ],
      ),
    );
  }

  Widget _buildImageMessage(ChatMessage message) {
    return Column(
      children: [
        Image.network(
          message.imageUrl!,
          width: 200,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 200,
              height: 150,
              color: Colors.grey.shade300,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(message.message, style: const TextStyle(color: Colors.white)),
      ],
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
                // textInputAction: TextInputAction.send,
                // onSubmitted: (value) {
                //   if (value.trim().isNotEmpty) {
                //     controller.sendMessage(value);
                //     _messageController.clear();
                //   }
                // },
              ),
              // child: TextField(
              //   controller: _messageController,
              //   decoration: const InputDecoration(
              //     hintText: 'Type a message...',
              //     border: OutlineInputBorder(),
              //     contentPadding: EdgeInsets.symmetric(horizontal: 16),
              //   ),
              //   maxLines: null,
              // ),
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
                onTap: chatController.isSending.value
                    ? () {}
                    : () {
                        if (_messageController.text.trim().isNotEmpty) {
                          chatController.sendTextMessage(
                            widget.receiverId,
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
              // return IconButton(
              //   icon: chatController.isSending.value
              //       ? const CircularProgressIndicator()
              //       : const Icon(Icons.send),
              //   onPressed: chatController.isSending.value
              //       ? null
              //       : () {
              //           if (_messageController.text.trim().isNotEmpty) {
              //             chatController.sendTextMessage(
              //               widget.receiverId,
              //               _messageController.text,
              //             );
              //             _messageController.clear();
              //           }
              //         },
              // );
            }),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    try {
      final image = await chatController.imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image != null) {
        // Upload image to storage and get URL
        // Then call: chatController.sendImageMessage(widget.receiverId, imageUrl);
        Get.snackbar('Info', 'Image upload feature to be implemented');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Clear Conversation'),
              onTap: () {
                Get.back();
                _clearConversation();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Block User'),
              onTap: () {
                Get.back();
                _blockUser();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearConversation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Conversation'),
        content: const Text('Are you sure you want to clear all messages?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              chatController.clearConversation(
                chatController.currentConversationId.value,
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _blockUser() {
    Get.snackbar('Info', 'Block user feature to be implemented');
  }
}
