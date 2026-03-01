import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';

import '../../../utils/app_imports.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});
  final _formKey = GlobalKey<FormState>();

  var userPreferences = UserPreferences.instance.loggedInUserData;
  final AuthController authController = Get.put(AuthController());
  final RxBool _obscurePassword = true.obs;
  final RxBool _obscurePassword1 = true.obs;
  final RxBool _obscurePassword2 = true.obs;

  /// --> build
  @override
  Widget build(BuildContext context) {
    authController.resetChangePasswordFields();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'Change Password'),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Logo and Title
            // _buildHeader(),
            // Profile Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 24,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomTextField(
                          label: 'Email',
                          hintText: 'name@mail.com',
                          controller: TextEditingController(
                            text: userPreferences.getEmail(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                      ),

                      Obx(() {
                        return CustomTextField(
                          label: 'Current Password',
                          hintText: 'Enter Current Password',
                          controller: authController.changePasswordController,
                          obscureText: _obscurePassword.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              _obscurePassword.value = !_obscurePassword.value;
                              // setState(() {
                              //   _obscurePassword = !_obscurePassword;
                              // });
                            },
                          ),
                        );
                      }),

                      Obx(() {
                        return CustomTextField(
                          label: 'New Password',
                          hintText: 'Enter New Password',
                          controller:
                              authController.changeNewPasswordController,
                          obscureText: _obscurePassword1.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword1.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              _obscurePassword1.value =
                                  !_obscurePassword1.value;
                              // setState(() {
                              //   _obscurePassword = !_obscurePassword;
                              // });
                            },
                          ),
                        );
                      }),

                      Obx(() {
                        return CustomTextField(
                          label: 'Confirm New Password',
                          hintText: 'Enter Confirm New Password',
                          controller:
                              authController.changeConfirmPasswordController,
                          obscureText: _obscurePassword2.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword2.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              _obscurePassword2.value =
                                  !_obscurePassword2.value;
                              // setState(() {
                              //   _obscurePassword = !_obscurePassword;
                              // });
                            },
                          ),
                        );
                      }),

                      //
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Obx(
                            () => CustomButton(
                              text:
                                  authController
                                      .changePasswordApiRequestLoader
                                      .isFalse
                                  ? 'Change Password'
                                  : 'Changing Password...',
                              height: 40,
                              onPressed: () {
                                authController.changePasswordApiRequest();
                              },
                              isEnabled: authController
                                  .changePasswordApiRequestLoader
                                  .isFalse,
                            ),
                          ),
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
    );
  }
}
