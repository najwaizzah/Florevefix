// lib/bindings/catalog_binding.dart

import 'package:get/get.dart';
import '../controllers/catalog_controller.dart';
import '../services/supabase_service.dart';

class CatalogBinding extends Bindings {
  @override
  void dependencies() {
    // SupabaseService harus ada karena catalog fetch dari Supabase
    Get.lazyPut<SupabaseService>(() => SupabaseService());

    // Controller untuk produk bunga
    Get.lazyPut<CatalogController>(() => CatalogController());
  }
}
