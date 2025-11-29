// lib/bindings/auth_binding.dart

import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/supabase_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // SUPABASE SERVICE (singleton)
    Get.put<SupabaseService>(
      SupabaseService(),
      permanent: true, // supaya tidak ke-dispose
    );

    // AUTH CONTROLLER
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
