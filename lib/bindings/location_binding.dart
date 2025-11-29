import 'package:get/get.dart';
import '../controllers/location_controller.dart';
import '../services/location_service.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
