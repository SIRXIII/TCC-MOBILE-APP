// views/add_address_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_model.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import '../controllers/address_controller.dart';

class AddAddressView extends StatefulWidget {
  final Address? address;

  const AddAddressView({super.key, this.address});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final AddressController addressController = Get.find<AddressController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedAddressType = '';
  bool _isDefault = false;

  // final List<String> _addressTypes = ['Home', 'Work', 'Other'];
  final List<String> _addressTypes = ['shipping', 'billing'];

  @override
  void initState() {
    super.initState();

    addressController.addAddressApiRequestLoader(false);
    if (widget.address != null) {
      _fillFormWithAddressData();
    }
  }

  void _fillFormWithAddressData() {
    final address = widget.address!;
    _fullNameController.text = address.getName();
    _phoneController.text = address.getPhone();
    addressController.addressLine1Controller.value.text = address.getAddress();
    // addressController.addressLine2Controller.text = address.getAddress() ?? '';
    // _cityController.text = address.city;
    // _stateController.text = address.state;
    // _zipCodeController.text = address.zipCode;
    addressController.countryController.value.text = address.getCountry();
    _selectedAddressType = address.getType();
    // _isDefault = address.isDefault;
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

    // _addressLine1Controller.dispose();
    // _addressLine2Controller.dispose();
    // _cityController.dispose();
    // _stateController.dispose();
    // _zipCodeController.dispose();
    // _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(
        title: widget.address == null ? 'Add Address' : 'Edit Address',
      ),
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

              // Full Name
              // _buildTextField(
              //   controller: _fullNameController,
              //   label: 'Full Name',
              //   hintText: 'Enter your full name',
              //   icon: Icons.person,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your full name';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone Number',
                hintText: 'Enter your phone number',
                controller: _phoneController,
                keyboardType: TextInputType.number,
              ),
              // Phone Number
              // _buildTextField(
              //   controller: _phoneController,
              //   label: 'Phone Number',
              //   hintText: 'Enter your phone number',
              //   icon: Icons.phone,
              //   keyboardType: TextInputType.phone,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your phone number';
              //     }
              //     if (value.length < 10) {
              //       return 'Please enter a valid phone number';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 16),

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

              /* Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _cityController,
                      label: 'City',
                      hintText: 'City',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _stateController,
                      label: 'State',
                      hintText: 'State',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter state';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _zipCodeController,
                      label: 'ZIP Code',
                      hintText: 'ZIP',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ZIP code';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),*/
              // const SizedBox(height: 16),

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

              // _buildTextField(
              //   controller: _countryController,
              //   label: 'Country',
              //   hintText: 'Country',
              //   icon: Icons.public,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter country';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 24),

              // Set as Default
              // _buildDefaultAddressToggle(),
              // const SizedBox(height: 32),

              // // Save Button
              // _buildSaveButton(),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDefaultAddressToggle() {
    return Row(
      children: [
        Checkbox(
          value: _isDefault,
          onChanged: (value) {
            setState(() {
              _isDefault = value ?? false;
            });
          },
        ),
        const SizedBox(width: 8),
        const Text('Set as default address', style: TextStyle(fontSize: 16)),
      ],
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

        // appButtonView(
        //   buttonHeight: 40,
        //   buttonName: widget.address == null
        //       ? 'Save Address'
        //       : 'Update Address',
        //   buttonColor: AppColors.PRIMARY_COLOR,
        //   textColor: AppColors.WHITE,
        //   onTap: () {
        //     debugPrint('Address saved');
        //   },
        // ),
        // ElevatedButton(
        //   onPressed: _saveAddress,
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.PRIMARY_COLOR,
        //     foregroundColor: Colors.white,
        //     padding: const EdgeInsets.symmetric(vertical: 16),
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //   ),
        //   child: Text(
        //     widget.address == null ? 'Save Address' : 'Update Address',
        //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        //   ),
        // ),
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

  // void _saveAddress() {
  //   if (_formKey.currentState!.validate()) {
  //     final newAddress = Address(
  //       id:
  //           widget.address?.id ??
  //           DateTime.now().millisecondsSinceEpoch.toString(),
  //       fullName: _fullNameController.text.trim(),
  //       phoneNumber: _phoneController.text.trim(),
  //       addressLine1: _addressLine1Controller.text.trim(),
  //       addressLine2: _addressLine2Controller.text.trim().isEmpty
  //           ? null
  //           : _addressLine2Controller.text.trim(),
  //       city: _cityController.text.trim(),
  //       state: _stateController.text.trim(),
  //       zipCode: _zipCodeController.text.trim(),
  //       country: _countryController.text.trim(),
  //       isDefault: _isDefault,
  //       addressType: _selectedAddressType,
  //       createdAt: widget.address?.createdAt ?? DateTime.now(),
  //     );
  //
  //     if (widget.address == null) {
  //       addressController.addAddress(newAddress);
  //     } else {
  //       addressController.updateAddress(widget.address!.id, newAddress);
  //     }
  //   }
  // }

  void _deleteAddress() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              // addressController.deleteAddress(widget.address!.id);
              Get.back(); // Go back to address list
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
