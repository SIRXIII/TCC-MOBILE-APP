import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/rider_deliveries_api_response.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_imports.dart';

class AppGlobal extends GetxController {
  // -----------------------------------
  // INITIALIZE
  // -----------------------------------
  AppGlobal._privateConstructor();

  static AppGlobal get instance => _instance;

  static final AppGlobal _instance = AppGlobal._privateConstructor();

  factory AppGlobal() {
    return _instance;
  }

  String orderId = '';
  String chatWith = '';
  String chatWithName = '';
  String chatWithId = '';
  int ticketId = 0;

  // --> Selected Order
  final Rx<Order> _selectedOrder = Order().obs;
  Order get getSelectedOrder => _selectedOrder.value;

  set setSelectedOrder(Order data) {
    _selectedOrder.value = data;
  }

  // --> Selected Delivery
  final Rx<Deliveries> _selectedDelivery = Deliveries().obs;
  Deliveries get getSelectedDelivery => _selectedDelivery.value;

  set setSelectedDelivery(Deliveries data) {
    _selectedDelivery.value = data;
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.blue;
      case 'processing':
        return Colors.amber;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'returned':
        return Colors.green;
      case 'refunded':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  //
  // final Rx<AccountTypeEnum?> _selectedAccountType = Rx<AccountTypeEnum?>(null);
  //
  // // Getter for selectedAccountType
  // AccountTypeEnum? get selectedUserType => _selectedAccountType.value;
  //
  // void saveLoggedInUserType(AccountTypeEnum type) {
  //   storageBox.write(StorageConstants.loggedInUserType, type);
  //   _selectedAccountType.value = type;
  // }
  //
  // void loadLoggedInUserType() {
  //   final storedToken = storageBox.read(StorageConstants.loggedInUserType);
  //   if (storedToken != null) {
  //     _selectedAccountType.value = storedToken;
  //   }
  //
  //   debugPrint('loadLoggedInUserType --> ${_selectedAccountType.value}');
  // }

  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not open $url";
    }
  }
}
