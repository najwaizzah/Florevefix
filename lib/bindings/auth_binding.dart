// lib/bindings/auth_binding.dart

import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/supabase_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan Supabase service selalu hidup terlebih dahulu
    Get.lazyPut<SupabaseService>(() => SupabaseService());

    // Auth Controller
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
