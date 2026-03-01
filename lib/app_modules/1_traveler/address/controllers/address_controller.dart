// controllers/address_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/controllers/place_search_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_list_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/repository/auth_repository.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/repositories/address_repository.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class AddressController extends GetxController {
  /// --> Properties

  final UserPreferences userPreferences = UserPreferences.instance;

  final addressLine1Controller = TextEditingController().obs;
  final addressLine2Controller = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final zipCodeController = TextEditingController().obs;
  final countryController = TextEditingController().obs;

  var lat = '';
  var lon = '';
  var city = '';
  var postalCode = '';

  // --> Methods
  // --> onInit
  @override
  void onInit() {
    super.onInit();
    // Add some sample addresses for demo
    getAddressApiRequest();
  }

  // -----------------------------------
  // Address Requests API
  // -----------------------------------
  var addAddressApiRequestLoader = false.obs;

  Future<void> addAddressApiRequest({required Address address}) async {
    debugPrint('addAddressApiRequest --> ${address.getType()}');

    if (address.getType().isEmpty) {
      appToastView(title: 'Address type is required');
      return;
    }

    if (address.getName().isEmpty) {
      appToastView(title: 'Name is required');
      return;
    }

    if (address.getName().isEmpty) {
      appToastView(title: 'Name is required');
      return;
    }

    if (address.getPhone().isEmpty) {
      appToastView(title: 'Phone number is required');
      return;
    }

    if (address.getAddress().isEmpty) {
      appToastView(title: 'Address is required');
      return;
    }

    addAddressApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      "traveler_id":
          userPreferences.loggedInUserData.traveler?.getTravelerId() ?? '',
      "type": address.getType(), // 'shipping', 'billing'
      "name": address.getName(),
      "address": address.getAddress(),
      "country": address.getCountry(),
      "latitude": lat,
      "longitude": lon,
      "phone": address.getPhone(),
    };

    var response = await AddressRepository.instance.addAddress(requestBody);

    final apiResponse = addressListApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.addresses != null) {
        // var updateLocationApiRequest = await AuthRepository.instance.updateLocation({
        //   'country': address.getCountry(),
        //   'city': address.getName(),
        //
        // });

        if (address.getType().toLowerCase() == 'shipping') {
          // final formData = dio.FormData.fromMap({
          //   'address': address.getAddress(),
          // });
          // final updateAddressApiResponse = await AuthRepository.instance
          //     .updateProfile(formData);

          var response = await AuthRepository.instance.updateLocation({
            'country': address.getCountry(),
            'city': city,
            'postal_code': postalCode == '' ? 'ABC' : postalCode,
            'address': address.getAddress(),
            // 'device_token': deviceToken ?? '',
          });
        }

        await getAddressApiRequest();
        // setAddressList = apiResponse.addresses ?? [];

        addAddressApiRequestLoader(false);

        Get.back();
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      appToastView(title: apiResponse.message.toString());
      addAddressApiRequestLoader(false);
    }
    addAddressApiRequestLoader(false);
  }

  // -----------------------------------
  // Get Address Requests API
  // -----------------------------------

  var selectedAddress = Address();

  var getAddressApiRequestLoader = false.obs;
  final _address = <Address>[].obs;

  RxList<Address> get addressList => _address;

  set setAddressList(List<Address> addressList) {
    _address.value = List.from(addressList);
  }

  Future<void> getAddressApiRequest() async {
    debugPrint('getAddressApiRequest --> ');

    getAddressApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      "traveler_id":
          userPreferences.loggedInUserData.traveler?.getTravelerId() ?? '',
    };

    var response = await AddressRepository.instance.getAddress(requestBody);

    final apiResponse = addressListApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.addresses != null) {
        setAddressList = apiResponse.addresses ?? [];

        getAddressApiRequestLoader(false);
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      getAddressApiRequestLoader(false);
    }
    getAddressApiRequestLoader(false);
  }

  /// Delete Address
  var deleteAddressApiRequestLoader = false.obs;
  Future<void> deleteAddressApiRequest(String addressId) async {
    debugPrint('deleteAddressApiRequest --> ');

    deleteAddressApiRequestLoader(true);

    Map<String, dynamic> requestBody = {};

    var response = await AddressRepository.instance.deleteAddress(
      requestBody,
      addressId,
    );

    final apiResponse = addressListApiResponseFromJson(response);

    if (response != null) {
      appToastView(title: apiResponse.message.toString());

      getAddressApiRequest();
      deleteAddressApiRequestLoader(false);
    }
    deleteAddressApiRequestLoader(false);
  }

  void openSearchBottomSheet() {
    final controller = Get.put(OSMPlaceController());

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: controller.searchPlaces,
              decoration: const InputDecoration(
                hintText: "Search address...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),

            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.suggestions.isEmpty) {
                return const SizedBox();
              }

              return SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: controller.suggestions.length,
                  itemBuilder: (_, index) {
                    final item = controller.suggestions[index];
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(item["display_name"]), Divider()],
                      ),
                      onTap: () {
                        addressLine1Controller.value = TextEditingController(
                          text: item["display_name"],
                        );
                        countryController.value = TextEditingController(
                          text: item["address"]["country"],
                        );
                        lat = item["lat"];
                        lon = item["lon"];
                        city = item["address"]["city"] != ''
                            ? item["address"]["city"]
                            : item["address"]["state"];
                        postalCode = item["address"]["postcode"];
                        print("Selected lat: ${item.toString()}");
                        print("Selected lat: ${item["lat"]}");
                        print("Selected lon: ${item["lon"]}");
                        print("display_name: ${item["display_name"]}");
                        print("name: ${item["name"]}");
                        print(
                          "country_code: ${item["address"]["country_code"]}",
                        );
                        print("country: ${item["address"]["country"]}");
                        print("state: ${item["address"]["state"]}");
                        print("city: ${item["address"]["city"]}");
                        print("postcode: ${item["address"]["postcode"]}");
                        Get.back();
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
