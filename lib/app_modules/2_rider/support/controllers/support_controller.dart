import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/support/model/add_support_ticket_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/support/model/support_ticket_api_response.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/repositories/support_repository.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class RiderSupportController extends GetxController {
  // final SupportRepository _repository = Get.find<SupportRepository>();

  final UserPreferences userPreferences = UserPreferences.instance;
  final TextEditingController descriptionController = TextEditingController();

  final Rx<String> _selectedTicketType = ''.obs;
  String? get selectedTicketType => _selectedTicketType.value;

  void setSelectedTicketType(String ticketType) {
    _selectedTicketType.value = ticketType;
    update();
  }

  /// onInit
  @override
  void onInit() {
    super.onInit();
    getSupportTicketsApiRequest();
  }

  // -----------------------------------
  // Create Support Ticket API
  // -----------------------------------
  var addSupportTicketApiRequestLoader = false.obs;

  Future<void> addSupportTicketApiRequest() async {

    if (selectedTicketType == '') {
      appToastView(title: 'Support Ticket type is required');
      return;
    }
    if (descriptionController.text == '') {
      appToastView(title: 'Description is required');
      return;
    }

    addSupportTicketApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      "subject": selectedTicketType,
      "message": descriptionController.text.toString(), // 'shipping', 'billing'
    };

    var response = await SupportRepository.instance.submitSupportTicket(
      requestBody,
    );

    final apiResponse = addSupportTicketApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.data != null) {
        await getSupportTicketsApiRequest();

        addSupportTicketApiRequestLoader(false);

        Get.back();
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      appToastView(title: apiResponse.message.toString());
      addSupportTicketApiRequestLoader(false);
    }
    addSupportTicketApiRequestLoader(false);
  }

  // -----------------------------------
  // Get Support Ticket API
  // -----------------------------------
  var getSupportTicketsApiRequestLoader = false.obs;
  final _supportTicketsList = <SupportTicketModel>[].obs;

  RxList<SupportTicketModel> get supportTicketsList => _supportTicketsList;

  set setAddressList(List<SupportTicketModel> addressList) {
    _supportTicketsList.value = List.from(addressList);
  }

  Future<void> getSupportTicketsApiRequest() async {

    getSupportTicketsApiRequestLoader(true);

    Map<String, dynamic> requestBody = {};

    var response = await SupportRepository.instance.getSupportTickets(
      requestBody,
    );

    final apiResponse = supportTicketApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.data != null) {
        setAddressList = apiResponse.data ?? [];

        getSupportTicketsApiRequestLoader(false);
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      getSupportTicketsApiRequestLoader(false);
    }
    getSupportTicketsApiRequestLoader(false);
  }

  void resetData() {
    setSelectedTicketType('');
    descriptionController.text = '';
  }
}
