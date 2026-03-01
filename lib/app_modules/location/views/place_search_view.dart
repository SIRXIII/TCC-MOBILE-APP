import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/place_search_controller.dart';

class PlaceSearchView extends StatelessWidget {
  final PlaceSearchController controller = Get.put(PlaceSearchController());

  PlaceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Places")),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: controller.onSearchChanged,
              decoration: InputDecoration(
                labelText: "Search location",
                border: OutlineInputBorder(),
                suffixIcon: Obx(
                  () => controller.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(Icons.search),
                ),
              ),
            ),
          ),

          // Suggestions List
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.suggestions.length,
                itemBuilder: (context, index) {
                  final item = controller.suggestions[index];

                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(item['description']),
                    onTap: () => controller.selectPlace(
                      item["place_id"],
                      item["description"],
                    ),
                  );
                },
              ),
            ),
          ),

          // Selected Place Info
          Obx(
            () => controller.selectedPlace.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Selected: ${controller.selectedPlace}\nLat: ${controller.selectedLat}\nLng: ${controller.selectedLng}",
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
