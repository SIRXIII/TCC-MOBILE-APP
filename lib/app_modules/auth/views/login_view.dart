import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
// AccountTypeScreen import karo

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.find<AuthController>();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // _emailController.text = 'name@mail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              const SizedBox(height: 40),

              // Logo - Add your logo image here
              Center(
                child: Image.asset(
                  AppImages.appLogo2,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                'Log in to your account',
                style: GoogleFonts.robotoSerif(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  letterSpacing: -0.03,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              // Description
              const Text(
                'Welcome back! Please enter your details.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 32),

              // Email Field - Using CustomTextField
              CustomTextField(
                label: 'Email',
                hintText: 'name@mail.com',
                controller: authController.emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Field - Using CustomTextField with suffixIcon
              CustomTextField(
                label: 'Password',
                hintText: 'Enter your password',
                controller: authController.passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Remember me & Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember me
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: AppColors.PRIMARY_COLOR,
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  // Forgot password
                  Obx(() {
                    return authController
                            .travelerForgotPasswordApiRequestLoading
                            .value
                        ? Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: () {
                              authController.travelerForgotPasswordApiRequest();
                              // Handle forgot password
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.PRIMARY_COLOR,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                  }),
                ],
              ),

              const SizedBox(height: 15),

              // Sign In Button
              Obx(() {
                return authController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Sign in',
                        onPressed: () {
                          authController.travelerLoginApiRequest();
                        },
                        isEnabled: true,
                      );
              }),

              /*    // OR Divider

               const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.textFieldBorder.withOpacity(0.5),
                      thickness: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.textFieldBorder.withOpacity(0.5),
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),
              Obx(() {
                final controller = AppleAuthController.instance;

                return controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : SignInWithAppleButton(
                        onPressed: controller.signInWithApple,
                      );
              }),
              const SizedBox(height: 16),

              // Google Sign In Button Only - Original Design
              Obx(() {
                return authController.loginWithGoogleApiRequestLoader.isTrue
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: GoogleSignInButton(
                          onPressed: () {
                            GoogleAuthController.instance.loginWithGoogle();
                          },
                          isLogin: true, // Sign up mode
                        ),
                      );
              }),

          */
              const SizedBox(height: 32),

              UserPreferences.instance.selectedUserType ==
                      AccountTypeEnum.traveler
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          _handleSignUp(); // Navigate to AccountTypeScreen
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  color: AppColors.PRIMARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleGoogleSignIn() {
    // Implement Google sign in
  }

  void _handleSignUp() {
    // AccountTypeScreen par navigate karo
    Get.offAllNamed(AppRoutes.accountType);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const AccountTypeScreen()),
    // );
  }

  @override
  void dispose() {
    // _emailController.dispose();
    // _passwordController.dispose();
    super.dispose();
  }
}
