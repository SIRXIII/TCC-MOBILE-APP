// controllers/account_type_controller.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import '../models/account_type_model.dart';

// controllers/account_type_controller.dart

class AccountTypeController extends GetxController {
  final Rx<AccountTypeEnum?> selectedAccountType = Rx<AccountTypeEnum?>(null);

  final List<AccountType> accountTypes = [
    AccountType(
      title: 'Traveler',
      description: 'Book rides and travel to your destinations comfortably',
      icon: '🚗',
      type: AccountTypeEnum.traveler,
    ),
    AccountType(
      title: 'Rider',
      description: 'Drive and earn money by providing ride services',
      icon: '🏍️',
      type: AccountTypeEnum.rider,
    ),
  ];

  void selectAccountType(AccountTypeEnum type) {
    selectedAccountType.value = type;
    UserPreferences.instance.saveUserType(type.name.capitalizeFirst.toString());
  }

  void continueWithSelection() {
    if (selectedAccountType.value == null) {
      Get.snackbar(
        'Selection Required',
        'Please select an account type to continue',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Navigate based on selection
    switch (selectedAccountType.value) {
      case AccountTypeEnum.traveler:
        Get.offAllNamed(AppRoutes.travelerDashboard);
        break;
      case AccountTypeEnum.rider:
        Get.offAllNamed(AppRoutes.riderDashboard);
        break;
      case null:
        break;
    }
  }

  bool get isAccountTypeSelected => selectedAccountType.value != null;
}
