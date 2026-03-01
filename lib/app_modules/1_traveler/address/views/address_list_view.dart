// views/address_list_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/views/add_address_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import '../controllers/address_controller.dart';

class AddressListView extends StatefulWidget {
  const AddressListView({super.key});

  @override
  State<AddressListView> createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  // --> Properties
  final AddressController addressController = Get.find<AddressController>();

  // --> initState()
  @override
  void initState() {
    super.initState();
  }

  // --> build()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'Address'),

      body: Obx(
        () => addressController.getAddressApiRequestLoader.isTrue
            ? appShimmerView()
            : addressController.addressList.isEmpty
            ? _buildEmptyState()
            : _buildAddressList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddAddressView()),
        backgroundColor: AppColors.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 80,
            color: AppColors.PRIMARY_COLOR,
          ),
          const SizedBox(height: 20),

          appTextView(
            text: 'No Addresses Yet',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 10),

          appTextView(
            text: 'Add your first address to get started',
            size: AppDimensions.FONT_SIZE_14,
            fontFamily: 'Roboto',
            color: AppColors.TEXT_1,
            // fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Get.to(() => AddAddressView()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.PRIMARY_COLOR,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: const Text('Add Address'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Default Address Section
        // _buildDefaultAddressSection(),
        // const SizedBox(height: 24),

        // Other Addresses
        _buildOtherAddressesSection(),
      ],
    );
  }

  /*  Widget _buildDefaultAddressSection() {
    final defaultAddress = addressController.getDefaultAddress();

    if (defaultAddress == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: 'Default Address',
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.PRIMARY_COLOR,
          fontWeight: FontWeight.bold,
        ),

        // const SizedBox(height: 12),
        _buildAddressCard(defaultAddress, isDefault: true),
      ],
    );
  }*/

  Widget _buildOtherAddressesSection() {
    final otherAddresses = addressController.addressList;
    // .where((address) => !address.isDefault)
    // .toList();

    if (otherAddresses.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // appTextView(
        //   text: 'Other Addresses',
        //   size: AppDimensions.FONT_SIZE_16,
        //   fontFamily: 'Roboto',
        //   color: AppColors.PRIMARY_COLOR,
        //   fontWeight: FontWeight.bold,
        // ),
        // const SizedBox(height: 12),
        ...otherAddresses.map(
          (address) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildAddressCard(address, isDefault: false),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard(Address address, {required bool isDefault}) {
    return GestureDetector(
      onTap: () {
        // addressController.deleteAddressApiRequest(address.id.toString());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getAddressTypeColor(address.getType()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      address.getType(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isDefault) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.PRIMARY_COLOR),
                      ),
                      child: Text(
                        'DEFAULT',
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onSelected: (value) => _handleAddressAction(value, address),
                    itemBuilder: (context) => [
                      // const PopupMenuItem(
                      //   value: 'edit',
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.edit, size: 20),
                      //       SizedBox(width: 8),
                      //       Text('Edit'),
                      //     ],
                      //   ),
                      // ),
                      // if (!isDefault)
                      //   const PopupMenuItem(
                      //     value: 'set_default',
                      //     child: Row(
                      //       children: [
                      //         Icon(Icons.star, size: 20),
                      //         SizedBox(width: 8),
                      //         Text('Set as Default'),
                      //       ],
                      //     ),
                      //   ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Address Details
              Text(
                address.getName(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address.getPhone(),
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                address.getAddress(),
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getAddressTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return Colors.green;
      case 'work':
        return Colors.blue;
      case 'other':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _handleAddressAction(String action, Address address) {
    switch (action) {
      case 'edit':
        Get.to(() => AddAddressView(address: address));
        break;
      // case 'set_default':
      // addressController.setDefaultAddress(address.id);
      // break;
      case 'delete':
        _showDeleteDialog(address);
        break;
    }
  }

  void _showDeleteDialog(Address address) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Address'),
        content: Text(
          'Are you sure you want to delete this ${address.getType()} address?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              addressController.deleteAddressApiRequest(address.id.toString());
              // addressController.deleteAddress(address.id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
