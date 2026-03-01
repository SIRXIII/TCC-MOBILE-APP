// views/traveler_edit_profile_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/profile/views/widgets/gender_selection_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/profile/views/widgets/size_selection_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_images.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/svg_icon_widget.dart';

class TravelerEditProfileView extends StatefulWidget {
  const TravelerEditProfileView({super.key});

  @override
  State<TravelerEditProfileView> createState() =>
      _TravelerEditProfileViewState();
}

class _TravelerEditProfileViewState extends State<TravelerEditProfileView> {
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

  // // --> dispose
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: appTextView(
          text: 'Edit Profile',
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
                      const SizedBox(height: 32),

                      Obx(() {
                        return CustomTextField(
                          label: 'Name',
                          hintText: 'John',
                          controller: profileController.nameController.value,
                          keyboardType: TextInputType.text,
                        );
                      }),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Email',
                        hintText: 'name@mail.com',
                        controller: profileController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Phone Number',
                        hintText: '+XX XXXX',
                        controller: profileController.phoneNumberController,
                        keyboardType: TextInputType.phone,
                      ),

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

                      // Size Selection
                      const SizedBox(height: 20),
                      // Date of Birth
                      _buildDateOfBirthSection(),
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

                //     Image.network(
                //   profileController.imageUrl.value,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) => _placeholder(),
                // );
              } else {
                imageWidget = _placeholder();
              }
              return Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(child: imageWidget),
              );
              return // Avatar Selection - Center mein
              Stack(
                children: [
                  // Avatar Container
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        AppImages.icProfileUser,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.PRIMARY_COLOR,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Edit Icon - Avatar ke andar bottom right mein
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      // onTap: _showAvatarSelection,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.background,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
              /* return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 3),
                ),
                child: ClipOval(
                  child:
                      profileImage.startsWith('http') ||
                          profileImage.startsWith('assets/')
                      ? Image.asset(
                          profileImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Image.network(
                          profileImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                ),
              );*/
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
          'Tap to change photo',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: 'Date of Birth',
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.TEXT_1,
          fontWeight: FontWeight.w600,
        ),

        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                const SizedBox(width: 12),
                Text(
                  profileController.selectedDOB,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),

                profileController.selectedDate == null
                    ? SizedBox.shrink()
                    : Text(
                        'Age: ${_calculateAge(profileController.selectedDate!)}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
              ],
            ),
          ),
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
                'Updating Profile...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }

      return SizedBox(
        width: double.infinity,
        child: CustomButton(
          text: 'Update Profile',
          onPressed: () {
            profileController.updateProfileApiRequest();
          },
          isEnabled: true,
        ),
      );
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: profileController.selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.PRIMARY_COLOR,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != profileController.selectedDate) {
      profileController.setSelectedDOB(
        '${picked.year}-${picked.month}-${picked.day}',
      );

      setState(() {
        profileController.selectedDate = picked;
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
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
      // child: const Icon(Icons.person, size: 50, color: Colors.grey),
      child: Image.asset(
        AppImages.icProfileUser,
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
    );
  }
}
