// lib/pages/bouquet_detail_page.dart

import 'package:flutter/material.dart';
import '../models/bouquet_model.dart';

class BouquetDetailPage extends StatelessWidget {
  final BouquetModel bouquet;

  const BouquetDetailPage({super.key, required this.bouquet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bouquet.name ?? "Detail"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GAMBAR BUKET
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(bouquet.imageUrl ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // NAMA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                bouquet.name ?? "",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // HARGA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Rp ${bouquet.price}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DESKRIPSI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                bouquet.description ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // TOMBOL TAMBAH KE KERANJANG
            Center(
              child: SizedBox(
                width: 280,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Integrasi CartController
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ditambahkan ke keranjang!"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Tambah ke Keranjang",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
