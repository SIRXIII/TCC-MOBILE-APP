import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';

import 'package:travel_clothing_club_flutter/utils/app_imports.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final AuthController authController = Get.find<AuthController>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // _fullNameController.text = 'Shawn Obrain';
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
              const SizedBox(height: 30),

              // Logo
              Center(
                child: Image.asset(
                  AppImages.appLogo2,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                'Create your new account',
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoSerif(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  // Made slightly bolder
                  height: 1.3,
                  letterSpacing: -0.03,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              // Description
              const Text(
                'Welcome! Please enter your details.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 32),

              // Full Name Field - Pre-filled
              Obx(() {
                return CustomTextField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  controller: authController.nameController.value,
                  keyboardType: TextInputType.name,
                );
              }),

              const SizedBox(height: 20),

              // Email Field - Pre-filled
              CustomTextField(
                label: 'Email',
                hintText: 'name@mail.com',
                controller: authController.emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Field - Using CustomTextField
              CustomTextField(
                label: 'Password',
                hintText: 'Enter your password',
                controller: authController.signupPasswordController,
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

              const SizedBox(height: 20),

              // Confirm Password Field - Using CustomTextField
              CustomTextField(
                label: 'Confirm Password',
                hintText: 'Confirm your password',
                controller: authController.confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Sign Up Button
              Obx(() {
                return authController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Sign up',
                        onPressed: () {
                          _handleSignUp();
                        },
                        isEnabled: true,
                      );
              }),

              /*    const SizedBox(height: 12),

              // OR Divider
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

              const SizedBox(height: 12),

              // Google Sign In Button Only
              Obx(() {
                return authController.loginWithGoogleApiRequestLoader.isTrue
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: GoogleSignInButton(
                          onPressed: () {
                            GoogleAuthController.instance.loginWithGoogle();
                          },
                          isLogin: false, // Sign up mode
                        ),
                      );
              }),*/
              const SizedBox(height: 32),

              // Already have account
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to sign in screen
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: AppColors.PRIMARY_COLOR,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp() {
    // final fullName = _fullNameController.text;
    // final email = _emailController.text;
    // final password = _passwordController.text;
    // final confirmPassword = _confirmPasswordController.text;

    // print('Sign up: $fullName, $email, $password, $confirmPassword');

    authController.travelerRegisterApiRequest();

    // Get.toNamed(AppRoutes.locationPermission);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LocationPermissionScreen()),
    // );
  }

  void _handleGoogleSignUp() {

    // Implement Google sign up
  }

  @override
  void dispose() {
    // _fullNameController.dispose();
    // _emailController.dispose();
    // _passwordController.dispose();
    // _confirmPasswordController.dispose();
    super.dispose();
  }
}
