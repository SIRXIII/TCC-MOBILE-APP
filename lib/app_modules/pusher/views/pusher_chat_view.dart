import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/controllers/pusher_chat_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/model/support_messages_api_response.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import '../../1_traveler/chat/models/chat_message_model.dart';

class PusherChatView extends StatefulWidget {
  const PusherChatView({super.key});

  @override
  State<PusherChatView> createState() => _PusherChatViewState();
}

class _PusherChatViewState extends State<PusherChatView> {
  /// PROPERTIES
  // final ChatController chatController = Get.put(ChatController());
  final PusherChaController pusherChatController =
      Get.find<PusherChaController>();
  // final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // final RefundController refundController = Get.find<RefundController>();

  /// initState
  @override
  void initState() {
    super.initState();
    // chatController.loadMessages(AppGlobal.instance.chatWithId);
  }

  /// dispose
  @override
  void dispose() {
    pusherChatController.messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarView(
        title: AppGlobal.instance.chatWithName,
        subTitle: AppGlobal.instance.chatWith,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () =>
                  pusherChatController.getSupportMessagesApiRequestLoader.isTrue
                  ? appChatShimmerView()
                  : pusherChatController.messagesList.isEmpty
                  ? Center(
                      child: Text('No messages yet. Start a conversation!'),
                    )
                  : _buildMessagesList(),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  /// _buildMessagesList
  Widget _buildMessagesList() {
    // if (pusherChatController.messagesList.isEmpty) {
    //   return const Center(
    //     child: Text('No messages yet. Start a conversation!'),
    //   );
    // }

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
      itemCount: pusherChatController.messagesList.length,
      itemBuilder: (context, index) {
        // final message = pusherChatController.messagesList[index];
        return _buildMessageBubble(pusherChatController.messagesList[index]);
      },
    );
  }

  /// _buildMessageBubble
  Widget _buildMessageBubble(Message message) {
    final isMe = message.senderId == pusherChatController.currentUserId;

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
                  child: message.senderType == MessageType.image.name
                      ? _buildImageMessage(message)
                      : Text(
                          message.getMessage(),
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

  Widget _buildImageMessage(Message message) {
    return Column(
      children: [
        Image.network(
          'message.imageUrl!',
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
        Text(message.getMessage(), style: const TextStyle(color: Colors.white)),
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
                controller: pusherChatController.messageController,
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
                onTap: pusherChatController.isSending.value
                    ? () {}
                    : () {
                        if (pusherChatController.messageController.text
                            .trim()
                            .isNotEmpty) {
                          pusherChatController.addMessageApiRequest();
                          pusherChatController.messageController.clear();
                        }
                      },
              );
            }),
          ],
        ),
      ),
    );
  }

  // void _pickImage() async {
  //   try {
  //     final image = await chatController.imagePicker.pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //     );
  //
  //     if (image != null) {
  //       // Upload image to storage and get URL
  //       // Then call: chatController.sendImageMessage(widget.receiverId, imageUrl);
  //       Get.snackbar('Info', 'Image upload feature to be implemented');
  //     }
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to pick image');
  //   }
  // }

  void _blockUser() {
    Get.snackbar('Info', 'Block user feature to be implemented');
  }
}
