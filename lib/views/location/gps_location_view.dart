import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/location_controller.dart';

class GPSLocationView extends StatelessWidget {
  const GPSLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(title: const Text("GPS Location")),
      body: Center(
        child: Obx(() {
          final pos = controller.gpsPosition.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.fetchGPSLocation,
                child: const Text("Ambil Lokasi GPS"),
              ),
              const SizedBox(height: 20),
              pos == null
                  ? const Text("Belum ada data")
                  : Text(
                      "Lat: ${pos.latitude}\nLng: ${pos.longitude}",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
