// lib/pages/checkout_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final TextEditingController nameC = TextEditingController();
  final TextEditingController addressC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CartController cartC = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================
            // SECTION: ITEM ORDER SUMMARY
            // ============================
            const Text(
              "Ringkasan Pesanan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...cartC.cartItems.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.imageUrl ?? ""),
                  ),
                  title: Text(item.name ?? ""),
                  subtitle: Text("Rp ${item.price}"),
                ),
              );
            }).toList(),

            const SizedBox(height: 16),

            // ============================
            // TOTAL PRICE
            // ============================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Rp ${cartC.totalPrice}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ============================
            // FORM PEMBELIAN
            // ============================
            const Text(
              "Data Pembeli",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: nameC,
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: phoneC,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Nomor Telepon",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: addressC,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Alamat Pengiriman",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ============================
            // BUTTON CONFIRM CHECKOUT
            // ============================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (nameC.text.isEmpty ||
                      phoneC.text.isEmpty ||
                      addressC.text.isEmpty) {
                    Get.snackbar(
                      "Gagal",
                      "Semua form harus diisi!",
                      backgroundColor: Colors.redAccent.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                    return;
                  }

                  // TODO: Simpan ke Supabase (opsional)
                  // TODO: Simpan riwayat pesanan menggunakan Hive

                  cartC.clearCart();

                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: const Text("Pesanan Berhasil!"),
                      content: const Text(
                        "Terima kasih! Pesanan kamu sedang diproses.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed('/home');
                          },
                          child: const Text("Kembali ke Beranda"),
                        ),
                      ],
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
                  "Konfirmasi Pesanan",
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
