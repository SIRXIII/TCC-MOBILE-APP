import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/controllers/address_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_model.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class AddManualLocationView extends StatefulWidget {
  const AddManualLocationView({super.key});

  @override
  State<AddManualLocationView> createState() => _AddManualLocationViewState();
}

class _AddManualLocationViewState extends State<AddManualLocationView> {
  final AddressController addressController = Get.find<AddressController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedAddressType = '';
  final bool _isDefault = false;

  // final List<String> _addressTypes = ['Home', 'Work', 'Other'];
  final List<String> _addressTypes = ['shipping', 'billing'];

  @override
  void initState() {
    super.initState();

    addressController.addAddressApiRequestLoader(false);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();

    addressController.addressLine1Controller.value.text = '';
    addressController.cityController.value.text = '';
    addressController.stateController.value.text = '';
    addressController.zipCodeController.value.text = '';
    addressController.countryController.value.text = '';

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'Add Location Manually'),
      bottomNavigationBar: _buildSaveButton(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 24,
            children: [
              // Address Type Selection
              _buildAddressTypeSection(),

              // const SizedBox(height: 20),
              CustomTextField(
                label: 'Name',
                hintText: 'Enter Name',
                controller: _fullNameController,
                keyboardType: TextInputType.text,
              ),

              CustomTextField(
                label: 'Phone Number',
                hintText: 'Enter your phone number',
                controller: _phoneController,
                keyboardType: TextInputType.number,
              ),

              // Address
              Obx(
                () => CustomTextField(
                  label: 'Address Line',
                  hintText: 'Street address, P.O. box, company namer',
                  controller: addressController.addressLine1Controller.value,
                  readOnly: true,
                  onTap: () async {
                    addressController.openSearchBottomSheet();
                  },
                  // keyboardType: TextInputType.number,
                ),
              ),

              // Country
              Obx(
                () => CustomTextField(
                  label: 'Country',
                  hintText: 'Country',
                  controller: addressController.countryController.value,
                  readOnly: false,
                  // keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressTypeSection() {
    return SizedBox(
      width: Get.width,
      // color: AppColors.PARROT,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          appTextView(
            text: 'Address Type',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
          ),
          // Text(
          //   'Address Type',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _addressTypes.map((type) {
              return ChoiceChip(
                label: Text(type.capitalizeFirst ?? ''),
                selected: _selectedAddressType == type,
                onSelected: (selected) {
                  setState(() {
                    _selectedAddressType = type;
                  });
                },
                selectedColor: _getAddressTypeColor(type),
                labelStyle: TextStyle(
                  color: _selectedAddressType == type
                      ? Colors.white
                      : Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 32),
      child: SizedBox(
        width: double.infinity,
        child: Obx(
          () => CustomButton(
            text: addressController.addAddressApiRequestLoader.isFalse
                ? 'Save Address'
                : 'Saving Address...',
            height: 40,
            onPressed: () {
              addressController.addAddressApiRequest(
                address: Address(
                  name: _fullNameController.text.toString(),
                  address: addressController.addressLine1Controller.value.text,
                  type: _selectedAddressType,
                  country: addressController.countryController.value.text,
                  phone: _phoneController.text.toString(),
                ),
              );
            },
            isEnabled: addressController.addAddressApiRequestLoader.isFalse,
          ),
        ),
      ),
    );
  }

  Color _getAddressTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return AppColors.PRIMARY_COLOR;
      case 'work':
        return AppColors.PRIMARY_COLOR;
      case 'other':
        return AppColors.PRIMARY_COLOR;
      default:
        return AppColors.PRIMARY_COLOR;
    }
  }
}
