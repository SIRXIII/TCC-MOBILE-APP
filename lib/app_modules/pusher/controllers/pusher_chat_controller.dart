import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/model/add_support_messages_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/model/support_messages_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/app_global.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/repositories/support_repository.dart';
import 'package:travel_clothing_club_flutter/service/pusher/constants/pusher_config.dart';
import 'package:travel_clothing_club_flutter/service/pusher/pusher_service.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class PusherChaController extends GetxController {
  /// PROPERTIES
  // final messages = <String>[].obs;
  final PusherService _pusherService = PusherService();
  final messageController = TextEditingController();
  final RxBool isSending = false.obs;

  int currentUserId =
      UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
      ? UserPreferences.instance.loggedInUserData.traveler!.getUserId()
      : UserPreferences.instance.loggedInUserData.rider!.getUserId();
  final AppGlobal _appGlobal = AppGlobal.instance;

  // int ticketId = 0;

  /// onInit
  @override
  void onInit() {
    debugPrint('onInit --> PusherChaController');

    super.onInit();
    _initPusher();
  }

  /// _initPusher
  Future<void> _initPusher() async {
    debugPrint('_initPusher --> ');

    // ticketId =
    //     UserPreferences.instance.selectedUserType == AccountTypeEnum.traveler
    //     ? _appGlobal.getSelectedOrder.getTicketId()
    //     : _appGlobal.getSelectedDelivery.getTicketId();

    getSupportMessagesApiRequestLoader(true);
    await _pusherService.init(onEvent: _handleEvent);
    await _pusherService.connect();
    await _pusherService.subscribe(
      PusherConfig.supportTicketChannel(_appGlobal.ticketId),
    );
  }

  /// _handleEvent
  void _handleEvent(String event, dynamic data) {
    debugPrint('_handleEvent --> $event - $data');

    // debugPrint('addMessage --> $decoded');
    getSupportMessagesApiRequest(_appGlobal.ticketId);

    if (event == "SupportMessageSent") {
      // final decoded = jsonDecode(data);
      // messages.add(decoded['message']);
    }
  }

  // -----------------------------------
  // Send Messages
  // -----------------------------------

  Future<void> addMessageApiRequest() async {
    debugPrint('addMessageApiRequest --> ');

    isSending(true);

    Map<String, dynamic> requestBody = {
      "ticket_id": _appGlobal.ticketId, // 'shipping', 'billing'
      "senderable_id": currentUserId,
      "senderable_type": UserPreferences.instance.selectedUserType?.name,
      "message": messageController.text.toString(),
    };

    try {
      var response = await SupportRepository.instance.addSupportTicketsMessage(
        requestBody,
      );

      final apiResponse = addSupportMessagesApiResponseFromJson(response);

      if (response != null) {
        if (apiResponse.success != null) {
          isSending(false);

          // Get.back();
        } else {
          appToastView(title: apiResponse.message.toString());
        }
        // appToastView(title: apiResponse.message.toString());
        isSending(false);
      }
    } catch (e) {
      AppLogger.debugPrintLogs('addMessageApiRequest - error', e.toString());
    }

    isSending(false);
  }

  /// Get Support Messages Requests API
  // -----------------------------------
  var getSupportMessagesApiRequestLoader = false.obs;
  final _messages = <Message>[].obs;

  RxList<Message> get messagesList => _messages;

  set setMessagesList(List<Message> messageList) {
    _messages.value = List.from(messageList);
  }

  void addMessages(List<Message> messages) {
    _messages.addAll(messages);
  }

  // void addMessage(Message message) {
  //   debugPrint('addMessage --> $message');
  //   Future.delayed(const Duration(milliseconds: 100), () {
  //     _messages.add(message);
  //     update();
  //   });
  // }

  Future<void> getSupportMessagesApiRequest(int ticketId) async {
    debugPrint('getSupportMessagesApiRequest --> ');

    getSupportMessagesApiRequestLoader(messagesList.isEmpty);

    Map<String, dynamic> requestBody = {"": ""};

    var response = await SupportRepository.instance.getSupportTicketsMessages(
      requestBody,
      ticketId,
    );

    final apiResponse = supportMessagesApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.data != null) {
        setMessagesList = apiResponse.data?.messages ?? [];

        getSupportMessagesApiRequestLoader(false);
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      getSupportMessagesApiRequestLoader(false);
    }
    getSupportMessagesApiRequestLoader(false);
  }

  /// onClose
  @override
  void onClose() {
    debugPrint('onClose --> ');
    _pusherService.disconnect();
    super.onClose();
  }
}
