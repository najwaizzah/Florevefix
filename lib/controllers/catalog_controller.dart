import 'package:get/get.dart';
import '../models/bouquet_model.dart';
import '../services/supabase_service.dart';


class CatalogController extends GetxController {
  final SupabaseService _supabase = Get.find<SupabaseService>();


  var bouquets = <BouquetModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
    super.onInit();
    fetchBouquets();
  }


  Future<void> fetchBouquets() async {
  try {
    isLoading.value = true;
    final listMap = await _supabase.getBouquets(); // List<Map<String, dynamic>>
    
    // Konversi Map ke BouquetModel
    final listBouquets = listMap.map((map) => BouquetModel.fromJson(map)).toList();
    
    bouquets.assignAll(listBouquets);
  } catch (e) {
    errorMessage.value = e.toString();
  } finally {
    isLoading.value = false;
  }
}

}