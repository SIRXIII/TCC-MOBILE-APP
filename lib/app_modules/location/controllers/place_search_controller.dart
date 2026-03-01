import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/location/google_places_service.dart';

class PlaceSearchController extends GetxController {
  final GooglePlacesService _service = GooglePlacesService();

  RxList<dynamic> suggestions = <dynamic>[].obs;
  RxBool isLoading = false.obs;

  RxString selectedPlace = ''.obs;
  RxDouble selectedLat = 0.0.obs;
  RxDouble selectedLng = 0.0.obs;

  /// Handle autocomplete
  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) {
      suggestions.clear();
      return;
    }

    isLoading.value = true;
    suggestions.value = await _service.fetchSuggestions(query);
    isLoading.value = false;
  }

  /// Handle selection
  Future<void> selectPlace(String placeId, String description) async {
    final details = await _service.fetchPlaceDetails(placeId);

    if (details.isNotEmpty) {
      final loc = details["geometry"]["location"];

      selectedPlace.value = description;
      selectedLat.value = loc["lat"];
      selectedLng.value = loc["lng"];
    }

    suggestions.clear();
  }
}
