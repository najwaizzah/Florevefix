import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class LocationController extends GetxController {
  final LocationService locationService = Get.find<LocationService>();

  var gpsPosition = Rxn<Position>();
  var networkPosition = Rxn<Position>();
  var livePosition = Rxn<Position>();

  // Ambil posisi GPS
  Future<void> fetchGPSLocation() async {
    try {
      gpsPosition.value = await locationService.getGPSLocation();
    } catch (e) {
      print("Error GPS: $e");
    }
  }

  // Ambil posisi Network
  Future<void> fetchNetworkLocation() async {
    try {
      networkPosition.value = await locationService.getNetworkLocation();
    } catch (e) {
      print("Error Network: $e");
    }
  }

  // Live tracking
  void startLiveTracking() {
    locationService.getLiveLocation().listen(
      (position) {
        livePosition.value = position;
      },
      onError: (e) {
        print("Error Live Location: $e");
      },
    );
  }
}
