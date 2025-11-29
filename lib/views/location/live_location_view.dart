import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/location_controller.dart';

class LiveLocationView extends StatelessWidget {
  const LiveLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Live GPS Tracker")),
      body: Center(
        child: Obx(() {
          final pos = controller.livePosition.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.startLiveTracking,
                child: const Text("Mulai Live Tracking"),
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
