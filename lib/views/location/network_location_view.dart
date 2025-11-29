import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/location_controller.dart';

class NetworkLocationView extends StatelessWidget {
  const NetworkLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Network Location")),
      body: Center(
        child: Obx(() {
          final pos = controller.networkPosition.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.fetchNetworkLocation,
                child: const Text("Ambil Lokasi via Network"),
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
