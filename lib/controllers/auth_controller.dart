import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

class AuthController extends GetxController {
  final SupabaseService _supabase = Get.find<SupabaseService>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // ===================== LOGIN =====================
  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final res = await _supabase.login(email, password);

      isLoading.value = false;
      return res.session != null;
    } on AuthException catch (e) {
      isLoading.value = false;
      errorMessage.value = e.message;
      return false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = "Terjadi kesalahan";
      return false;
    }
  }

  // ===================== REGISTER =====================
  Future<bool> register(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final res = await _supabase.register(email, password);

      isLoading.value = false;
      return res.session != null;
    } on AuthException catch (e) {
      isLoading.value = false;
      errorMessage.value = e.message;
      return false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = "Terjadi kesalahan";
      return false;
    }
  }

  // ===================== LOGOUT =====================
  Future<void> logout() async {
    await _supabase.logout();
    Get.offAllNamed('/login'); // redirect aman
  }

  // ===================== STATUS USER =====================
  bool isLoggedIn() =>
      Supabase.instance.client.auth.currentSession != null;
}
