// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/catalog_controller.dart';
import 'bouquet_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Panggil controller
  final CatalogController controller = Get.find<CatalogController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flower Catalog"),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (controller.bouquets.isEmpty) {
          return const Center(child: Text("Belum ada data buket"));
        }

        // LIST PRODUK
        return ListView.builder(
          itemCount: controller.bouquets.length,
          itemBuilder: (context, index) {
            final b = controller.bouquets[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => BouquetDetailPage(bouquet: b));
              },
              child: Card(
                margin: const EdgeInsets.all(12),
                elevation: 3,
                child: Row(
                  children: [
                    // GAMBAR
                    Container(
                      width: 90,
                      height: 90,
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(b.imageUrl ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // DETAIL
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              b.name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              b.description ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "Rp ${b.price}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
