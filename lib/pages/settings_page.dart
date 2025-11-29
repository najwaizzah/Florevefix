// lib/pages/settings_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ============================
          // PROFILE SECTION
          // ============================
          const Text(
            "Akun",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              title: Text(
                supabase.auth.currentUser?.email ?? "Pengguna",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("Email terdaftar"),
            ),
          ),

          const SizedBox(height: 25),

          // ============================
          // APP SETTINGS SECTION
          // ============================
          const Text(
            "Pengaturan Aplikasi",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text("Tema (Light / Dark)"),
                  onTap: () {
                    // TODO: Gunakan SharedPreferences untuk simpan tema
                    Get.snackbar(
                      "Info",
                      "Fitur tema masih dalam pengembangan",
                      backgroundColor: Colors.pinkAccent.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text("Notifikasi"),
                  onTap: () {
                    // TODO: Simpan status notifikasi (Hive atau SharedPrefs)
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ============================
          // LOGOUT BUTTON
          // ============================
          const Text(
            "Keamanan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () async {
                await supabase.auth.signOut();
                Get.offAllNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Keluar Akun",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
