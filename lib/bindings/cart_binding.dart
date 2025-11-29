// lib/bindings/cart_binding.dart

import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // Cart tidak perlu Supabase, hanya Hive
    Get.lazyPut<CartController>(() => CartController());
  }
}
