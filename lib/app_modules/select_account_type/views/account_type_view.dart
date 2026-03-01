// views/account_type_view.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import '../controllers/account_type_controller.dart';

class AccountTypeView extends StatefulWidget {
  const AccountTypeView({super.key});

  @override
  State<AccountTypeView> createState() => _AccountTypeViewState();
}

class _AccountTypeViewState extends State<AccountTypeView> {
  String? _selectedAccountType;
  final AccountTypeController controller = Get.find<AccountTypeController>();

  final AuthController authController = Get.put(AuthController());

  // --> Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo/Title
              Center(
                child: Image.asset(
                  AppImages.appLogo2,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

              appTextView(
                text: 'Select account type',
                color: AppColors.BLACK,
                size: AppDimensions.FONT_SIZE_24,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                // isStroke: false,
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                'Select your account type to create an account',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Account Type Cards - EXACT SAME AS SCREENSHOT
              Row(
                children: [
                  Expanded(
                    child: _buildAccountTypeCard(
                      title: 'Traveler',
                      icon: Icons.public,
                      isSelected: _selectedAccountType == 'Traveler',
                      onTap: () {
                        controller.selectAccountType(AccountTypeEnum.traveler);

                        setState(() {
                          _selectedAccountType = 'Traveler';
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _buildAccountTypeCard(
                      title: 'Rider',
                      icon: Icons.pedal_bike_outlined,
                      isSelected: _selectedAccountType == 'Rider',
                      onTap: () {
                        controller.selectAccountType(AccountTypeEnum.rider);
                        setState(() {
                          _selectedAccountType = 'Rider';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Sign Up Button
              Obx(() {
                return CustomButton(
                  text:
                      controller.selectedAccountType.value ==
                          AccountTypeEnum.rider
                      ? 'Sign in'
                      : 'Sign up',
                  onPressed: _selectedAccountType == null
                      ? null
                      : () {
                          _handleSignUp();
                        },
                  isEnabled: _selectedAccountType != null,
                );
              }),
              const SizedBox(height: 12),

              Obx(() {
                return authController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
                          authController.skipRegisterApiRequest();
                        },
                        child: appTextView(
                          text: 'Skip for now',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Roboto',
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w600,
                          underLine: TextDecoration.underline,
                        ),
                      );
              }),

              const SizedBox(height: 25),

              // Sign In Text
              Center(
                child: GestureDetector(
                  onTap: () {
                    _handleSignIn(); // Changed to navigate to LoginScreen
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: AppColors.PRIMARY_COLOR,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTypeCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.PRIMARY_COLOR.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.PRIMARY_COLOR
                : AppColors.textFieldBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.PRIMARY_COLOR.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? AppColors.PRIMARY_COLOR
                  : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.textPrimary,
              ),
            ),

            // Agar aapko custom tick chahiye toh yeh add karein
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleSignUp() {
    print('Selected account type: $_selectedAccountType');

    if (_selectedAccountType == 'Traveler') {
      Get.toNamed(AppRoutes.signup);
    } else {
      Get.toNamed(AppRoutes.login);
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SignUpScreen(accountType: ''),
    //   ),
    // );
  }

  void _handleSignIn() {
    if (UserPreferences.instance.selectedUserType == null) {
      appToastView(title: 'Select Account Type');
      return;
    }
    Get.toNamed(AppRoutes.login);
  }
}

// Old
/*
class AccountTypeView extends StatelessWidget {
  AccountTypeView({super.key});

  final AccountTypeController controller = Get.find<AccountTypeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppImages.appLogo2,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: appTextView(
                text: 'Select account type',
                color: AppColors.BLACK,
                size: AppDimensions.FONT_SIZE_20,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                // isStroke: false,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: appTextView(
                text: 'Select your account type to create an account',
                color: AppColors.TEXT_1,
                size: AppDimensions.FONT_SIZE_14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,

                // isStroke: false,
              ),
            ),
            const SizedBox(height: 32),

            // Account Type Cards
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of columns as needed
                  childAspectRatio:
                      1.0, // Adjust the aspect ratio for your cards
                  mainAxisSpacing: 10.0, // Space between rows
                  crossAxisSpacing: 10.0, // Space between columns
                ),
                itemCount: controller.accountTypes.length,
                itemBuilder: (context, index) {
                  final accountType = controller.accountTypes[index];
                  return Obx(
                    () => AccountTypeCard(
                      accountType: accountType,
                      isSelected:
                          controller.selectedAccountType.value ==
                          accountType.type,
                      onTap: () =>
                          controller.selectAccountType(accountType.type),
                    ),
                  );
                },
              ),
            ),

            // Continue Button
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: controller.isAccountTypeSelected
                      ? controller.continueWithSelection
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PRIMARY_COLOR,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTypeCard extends StatelessWidget {
  final AccountType accountType;
  final bool isSelected;
  final VoidCallback onTap;

  const AccountTypeCard({
    super.key,
    required this.accountType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected
          ? AppColors.PRIMARY_COLOR.withOpacity(0.1)
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected
              ? AppColors.PRIMARY_COLOR
              : Colors.grey.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),

                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountType.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppColors.PRIMARY_COLOR
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Selection Indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.PRIMARY_COLOR
                            : Colors.grey,
                        width: 2,
                      ),
                      color: isSelected
                          ? AppColors.PRIMARY_COLOR
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
