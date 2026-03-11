import 'dart:convert';
import 'package:http/http.dart' as http;

class GooglePlacesService {
  final String apiKey = const String.fromEnvironment('GOOGLE_MAPS_API_KEY', defaultValue: '');

  /// Get autocomplete suggestions
  Future<List<dynamic>> fetchSuggestions(String input) async {
    if (input.isEmpty) return [];

    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:pk";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["predictions"];
    }
    return [];
  }

  /// Fetch place details (lat/lng etc.)
  Future<Map<String, dynamic>> fetchPlaceDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body)["result"];
    }
    return {};
  }
}
