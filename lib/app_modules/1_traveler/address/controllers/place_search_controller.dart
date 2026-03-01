import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OSMPlaceController extends GetxController {
  RxList suggestions = [].obs;
  RxBool isLoading = false.obs;

  /// Debounce input
  Timer? _debounce;

  void searchPlaces(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      fetchPlaces(query);
    });
  }

  Future<void> fetchPlaces(String query) async {
    if (query.isEmpty) {
      suggestions.clear();
      return;
    }

    isLoading.value = true;

    try {
      final url =
          "https://nominatim.openstreetmap.org/search"
          "?q=$query"
          "&format=json"
          "&addressdetails=1"
          "&limit=10";

      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "FlutterApp"},
      );

      if (response.statusCode == 200) {
        suggestions.value = jsonDecode(response.body);
      } else {
        Get.snackbar("Error", "Failed to fetch data (OSM Limit Reached)");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    isLoading.value = false;
  }

  // Nearby places
  Future<List<dynamic>> fetchNearby(double lat, double lon) async {
    try {
      final url =
          "https://nominatim.openstreetmap.org/reverse"
          "?lat=$lat"
          "&lon=$lon"
          "&format=json"
          "&zoom=18"
          "&addressdetails=1";

      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "FlutterApp"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["address"] ?? [];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    return [];
  }
}

// class AddressPickerSheet extends StatelessWidget {
//   final PlaceSearchController controller = Get.put(PlaceSearchController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 16,
//         right: 16,
//         top: 20,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ---------- TITLE ----------
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Enter Address",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               IconButton(icon: Icon(Icons.close), onPressed: () => Get.back()),
//             ],
//           ),
//
//           const SizedBox(height: 16),
//
//           // ---------- SEARCH BAR ----------
//           TextField(
//             onChanged: controller.onSearchChanged,
//             decoration: InputDecoration(
//               hintText: "Search address",
//               prefixIcon: const Icon(Icons.search),
//               contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // ---------- LIST OF SUGGESTIONS ----------
//           Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (controller.errorMessage.isNotEmpty) {
//               return Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Text(
//                   controller.errorMessage.value,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//
//             if (controller.suggestions.isEmpty) {
//               return const Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Text("Start typing to search..."),
//               );
//             }
//
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.suggestions.length,
//               itemBuilder: (_, index) {
//                 final item = controller.suggestions[index];
//
//                 return ListTile(
//                   leading: const Icon(Icons.location_on_outlined),
//                   title: Text(item["description"]),
//                   onTap: () => controller.selectPlace(item),
//                 );
//               },
//             );
//           }),
//
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
