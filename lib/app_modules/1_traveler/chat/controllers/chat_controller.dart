// controllers/chat_controller.dart (Updated)
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/app_global.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';
import 'package:travel_clothing_club_flutter/utils/constants/firebase_constants.dart';
import '../models/chat_message_model.dart';
import '../models/chat_conversation_model.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker imagePicker = ImagePicker();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxList<ChatConversation> conversations = <ChatConversation>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final RxString currentConversationId = ''.obs;

  final AppGlobal _appGlobal = AppGlobal.instance;

  // User get currentUser => _auth.currentUser!;

  String currentUserId =
      UserPreferences.instance.loggedInUserData.traveler?.getId() ?? '';

  String orderId = '';

  /// onInit
  @override
  void onInit() {
    super.onInit();

    currentUserId =
        UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
        ? 'TRAV-${UserPreferences.instance.loggedInUserData.traveler!.getId()}'
        : 'RID-${UserPreferences.instance.loggedInUserData.rider!.getId()}';

    orderId =
        UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
        ? _appGlobal.getSelectedOrder.getOrderIdName()
        : _appGlobal.getSelectedDelivery.getOrderId();
    _loadConversations();
  }

  // Generate conversation ID between two users
  String _generateConversationId(String user1, String user2) {
    List<String> participants = [user1, user2];
    participants.sort();
    return participants.join('_');
  }

  // Load user conversations
  Future<void> _loadConversations() async {
    debugPrint('_loadConversations --> $currentUserId');
    try {
      isLoading.value = true;

      final querySnapshot = await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .where(FirebaseConstants.participants, arrayContains: currentUserId)
          .orderBy(FirebaseConstants.lastMessageTime, descending: true)
          .limit(FirebaseConstants.conversationsLimit)
          .get();

      conversations.assignAll(
        querySnapshot.docs
            .map((doc) => ChatConversation.fromMap(doc.data()))
            .toList(),
      );
    } catch (error) {
      print('Error loading conversations: $error');
      Get.snackbar('Error', 'Failed to load conversations');
    } finally {
      isLoading.value = false;
    }
  }

  // Load messages for a specific conversation
  Future<void> loadMessages(String receiverId) async {
    if (AppGlobal.instance.chatWith == 'Partner') {
      receiverId = 'PAR-$receiverId';
    }
    debugPrint('loadMessages --> $currentUserId');
    debugPrint('loadMessages --> $receiverId');
    try {
      isLoading.value = true;
      final conversationId = _generateConversationId(currentUserId, receiverId);
      currentConversationId.value = conversationId;

      final messagesSnapshot = await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .collection(FirebaseConstants.messagesCollection)
          .orderBy(FirebaseConstants.timestamp, descending: false)
          .limit(FirebaseConstants.messagesLimit)
          .get();

      messages.assignAll(
        messagesSnapshot.docs
            .map((doc) => ChatMessage.fromMap(doc.data()))
            .toList(),
      );

      // Mark messages as read
      await _markMessagesAsRead(conversationId);

      // Set up real-time listener
      _setupMessagesListener(conversationId);
    } catch (error) {
      print('Error loading messages: $error');
      Get.snackbar('Error', 'Failed to load messages');
    } finally {
      isLoading.value = false;
    }
  }

  // Real-time messages listener
  void _setupMessagesListener(String conversationId) {
    _firestore
        .collection(FirebaseConstants.conversationsCollection)
        .doc(conversationId)
        .collection(FirebaseConstants.messagesCollection)
        .orderBy(FirebaseConstants.timestamp, descending: false)
        .limit(FirebaseConstants.messagesLimit)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            messages.assignAll(
              snapshot.docs
                  .map((doc) => ChatMessage.fromMap(doc.data()))
                  .toList(),
            );
            _markMessagesAsRead(conversationId);
          }
        });
  }

  // Send text message
  Future<void> sendTextMessage(String receiverId, String message) async {
    if (message.trim().isEmpty) return;

    debugPrint('sendTextMessage --> ');

    if (AppGlobal.instance.chatWith == 'Partner') {
      receiverId = 'PAR-$receiverId';
    }
    AppLogger.debugPrintLogs('receiverId', receiverId);
    AppLogger.debugPrintLogs('senderId', currentUserId);
    AppLogger.debugPrintLogs('orderID', orderId);

    // return;
    // return;
    try {
      isSending.value = true;

      final conversationId = _generateConversationId(currentUserId, receiverId);
      final messageId = DateTime.now().millisecondsSinceEpoch.toString();

      final chatMessage = ChatMessage(
        id: messageId,
        senderId: currentUserId,
        receiverId: receiverId,
        message: message.trim(),
        type: MessageType.text,
        timestamp: DateTime.now(),
        orderID: orderId,
      );

      // Save message to Firestore
      await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .collection(FirebaseConstants.messagesCollection)
          .doc(messageId)
          .set(chatMessage.toMap());

      // Update conversation document
      await _updateConversation(conversationId, receiverId, message.trim());

      isSending.value = false;
    } catch (error) {
      isSending.value = false;
      print('Error sending message: $error');
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  // Send image message
  Future<void> sendImageMessage(String receiverId, String imageUrl) async {
    try {
      isSending.value = true;

      final conversationId = _generateConversationId(currentUserId, receiverId);
      final messageId = DateTime.now().millisecondsSinceEpoch.toString();

      final chatMessage = ChatMessage(
        id: messageId,
        senderId: currentUserId,
        receiverId: receiverId,
        message: 'Sent an image',
        type: MessageType.image,
        timestamp: DateTime.now(),
        imageUrl: imageUrl,
      );

      await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .collection(FirebaseConstants.messagesCollection)
          .doc(messageId)
          .set(chatMessage.toMap());

      await _updateConversation(conversationId, receiverId, '📷 Image');

      isSending.value = false;
    } catch (error) {
      isSending.value = false;
      print('Error sending image: $error');
      Get.snackbar('Error', 'Failed to send image');
    }
  }

  // Update conversation document
  Future<void> _updateConversation(
    String conversationId,
    String receiverId,
    String lastMessage,
  ) async {
    final conversation = ChatConversation(
      id: conversationId,
      participants: [currentUserId, receiverId],
      lastMessage: lastMessage,
      lastMessageTime: DateTime.now(),
      unreadCount: 1, // Increment for receiver
      orderID: orderId,
    );

    await _firestore
        .collection(FirebaseConstants.conversationsCollection)
        .doc(conversationId)
        .set(conversation.toMap(), SetOptions(merge: true));
  }

  // Mark messages as read
  Future<void> _markMessagesAsRead(String conversationId) async {
    try {
      final unreadMessages = await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .collection(FirebaseConstants.messagesCollection)
          .where(FirebaseConstants.receiverId, isEqualTo: currentUserId)
          .where(FirebaseConstants.isRead, isEqualTo: false)
          .get();

      final batch = _firestore.batch();

      for (final doc in unreadMessages.docs) {
        batch.update(doc.reference, {FirebaseConstants.isRead: true});
      }

      await batch.commit();

      // Reset unread count for this conversation
      await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .update({
            FirebaseConstants.unreadCount: 0,
            FirebaseConstants.updatedAt: FieldValue.serverTimestamp(),
          });
    } catch (error) {
      print('Error marking messages as read: $error');
    }
  }

  // Get unread messages count
  Stream<int> getUnreadCount() {
    return _firestore
        .collection(FirebaseConstants.conversationsCollection)
        .where(FirebaseConstants.participants, arrayContains: currentUserId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.fold(0, (sum, doc) {
            final data = doc.data();
            return sum + (int.parse(data[FirebaseConstants.unreadCount]) ?? 0);
          });
        });
  }

  // Clear conversation
  Future<void> clearConversation(String conversationId) async {
    try {
      // Get all messages in the conversation
      final messagesSnapshot = await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .collection(FirebaseConstants.messagesCollection)
          .get();

      // Delete all messages
      final batch = _firestore.batch();
      for (final doc in messagesSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Update conversation
      await _firestore
          .collection(FirebaseConstants.conversationsCollection)
          .doc(conversationId)
          .update({
            'lastMessage': 'Conversation cleared',
            'lastMessageTime': FieldValue.serverTimestamp(),
            'unreadCount': 0,
          });

      messages.clear();
      Get.snackbar('Success', 'Conversation cleared');
    } catch (error) {
      print('Error clearing conversation: $error');
      Get.snackbar('Error', 'Failed to clear conversation');
    }
  }
}
