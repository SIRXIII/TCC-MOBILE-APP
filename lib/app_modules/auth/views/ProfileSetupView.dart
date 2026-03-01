import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/profile/views/widgets/gender_selection_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/profile/views/widgets/size_selection_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';

import 'components/height_formatter.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  // --> PROPERTIES
  final AuthController profileController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  // UserPreferences userPreferences = UserPreferences.instance;

  // --> initState
  @override
  void initState() {
    super.initState();

    profileController.profileApiRequest();
  }

  // --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: appTextView(
          text: 'Setup Profile',
          color: AppColors.BLACK,
          size: AppDimensions.FONT_SIZE_18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          // isStroke: false,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgIconWidget(assetName: AppImages.icBack),
          ),
        ),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Logo and Title
            // _buildHeader(),
            // Profile Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Profile Picture Section
                      _buildProfilePictureSection(),

                      const SizedBox(height: 20),
                      Obx(() {
                        return _buildSelectionField(
                          label: 'Gender',
                          value: profileController.selectedGenderValue.obs,
                          icon: Icons.transgender,
                          onTap: _openGenderSelectionSheet,
                        );
                      }),

                      // Gender Selection
                      const SizedBox(height: 20),

                      Obx(() {
                        return _buildSelectionField(
                          label: 'Clothing Size',
                          value: profileController.selectedSizeValue.obs,
                          icon: Icons.straighten,
                          onTap: _openSizeSelectionSheet,
                        );
                      }),

                      //TODO: Heigh in CM
                      const SizedBox(height: 20),
                      // CustomTextField(
                      //   label: 'Height(in cm)',
                      //   hintText: '123 cm',
                      //   controller: profileController.heightInCmController,
                      //   keyboardType: const TextInputType.numberWithOptions(
                      //     decimal: true,
                      //   ),
                      // ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [HeightFormatter()],
                        controller: profileController.heightInCmController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Height',
                          hintText: "Height (e.g. 6'2)",
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 201, 201, 201),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          // suffixIcon: suffixIcon,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Chest(in cm)',
                        hintText: '123 cm',
                        controller: profileController.chestInCmController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      // Size Selection
                      const SizedBox(height: 40),

                      // Save Button
                      _buildSaveButton(),
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

  void _openGenderSelectionSheet() {
    Get.bottomSheet(
      GenderSelectionSheet(
        selectedGender: profileController.selectedGenderValue,
        onGenderSelected: (gender) {
          profileController.setSelectedGender(gender);
          // setState(() {
          //   _selectedGender = gender;
          // });
          Get.back();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _openSizeSelectionSheet() {
    Get.bottomSheet(
      SizeSelectionSheet(
        selectedSize: profileController.selectedSizeValue,
        onSizeSelected: (size) {
          profileController.setSelectedSize(size);
          // setState(() {
          //   _selectedSize = size;
          // });
          Get.back();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildProfilePictureSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Profile Picture
            Obx(() {
              Widget imageWidget;

              if (profileController.selectedImage.value != null) {
                imageWidget = Image.file(
                  profileController.selectedImage.value!,
                  fit: BoxFit.cover,
                );
              } else if (profileController.imageUrl.value.isNotEmpty) {
                imageWidget = AppCacheImageView(
                  imageUrl: profileController.imageUrl.value,
                  width: 100,
                  height: 100,
                  isProfile: true,
                  boxFit: BoxFit.cover,
                );
              } else {
                imageWidget = _placeholder();
              }
              return Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(child: imageWidget),
              );
            }),

            // Edit Icon
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    profileController.pickImage(ImageSource.gallery);
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Tap to update photo',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Obx(() {
      if (profileController.isLoading.value) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 12),
              Text(
                'Setting up profile...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }

      return SizedBox(
        width: double.infinity,
        child: CustomButton(
          text: 'Setup Profile',
          onPressed: () {
            profileController.setupProfileApiRequest();
          },
          isEnabled: true,
        ),
      );
    });
  }

  Widget _buildSelectionField({
    required String label,
    required RxString value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: label,
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.TEXT_1,
            fontWeight: FontWeight.w600,
          ),

          const SizedBox(height: 8),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.grey.shade600, size: 20),
                  const SizedBox(width: 12),
                  Text(value.value, style: const TextStyle(fontSize: 16)),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade600,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: const Icon(Icons.person, size: 50, color: Colors.grey),
    );
  }
}
