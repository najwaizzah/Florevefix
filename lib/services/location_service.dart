import 'package:geolocator/geolocator.dart';

class LocationService {
  // ===== CEK & MINTA IZIN =====
  Future<bool> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }

  // ===== GPS LOCATION =====
  Future<Position> getGPSLocation() async {
    bool allowed = await checkPermission();
    if (!allowed) throw Exception("Izin Lokasi ditolak.");

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // ===== NETWORK LOCATION =====
  Future<Position> getNetworkLocation() async {
    bool allowed = await checkPermission();
    if (!allowed) throw Exception("Izin Lokasi ditolak.");

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }

  // ===== LIVE STREAM =====
  Stream<Position> getLiveLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    );
  }
}
