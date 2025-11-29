import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/location_controller.dart';

class MapLocationView extends StatelessWidget {
  const MapLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Map Location")),
      body: Center(
        child: Obx(() {
          final pos = controller.gpsPosition.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.fetchGPSLocation,
                child: const Text("Ambil Lokasi untuk Map"),
              ),
              const SizedBox(height: 20),
              pos == null
                  ? const Text("Belum ada lokasi")
                  : Text(
                      "Lat: ${pos.latitude}\nLng: ${pos.longitude}",
                      style: const TextStyle(fontSize: 18),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
