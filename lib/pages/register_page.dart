import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();

    final emailC = TextEditingController();
    final passC = TextEditingController();
    final passConfirmC = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // TITLE / LOGO
                const Text(
                  "Daftar Akun",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEC7FA9),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Buat akun baru untuk mulai berbelanja.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFBE5985),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                // EMAIL FIELD
                TextField(
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // PASSWORD
                TextField(
                  controller: passC,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // CONFIRM PASSWORD
                TextField(
                  controller: passConfirmC,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Konfirmasi Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // REGISTER BUTTON
                Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC7FA9),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: auth.isLoading.value
                        ? null
                        : () async {
                            if (emailC.text.isEmpty ||
                                passC.text.isEmpty ||
                                passConfirmC.text.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Semua field harus diisi",
                                backgroundColor: Colors.red.shade300,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }

                            if (passC.text != passConfirmC.text) {
                              Get.snackbar(
                                "Error",
                                "Password dan konfirmasi tidak sama",
                                backgroundColor: Colors.red.shade300,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }

                            final success = await auth.register(
                              emailC.text.trim(),
                              passC.text.trim(),
                            );

                            if (success) {
                              Get.snackbar(
                                "Berhasil",
                                "Akun berhasil dibuat, silakan login!",
                                backgroundColor: Colors.green.shade400,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );

                              context.go('/login');
                            }
                          },
                    child: auth.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Daftar"),
                  );
                }),

                const SizedBox(height: 20),

                // ERROR MESSAGE
                Obx(() {
                  if (auth.errorMessage.isEmpty) {
                    return const SizedBox();
                  }
                  return Text(
                    auth.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }),

                const SizedBox(height: 20),

                // LOGIN LINK
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: const Text(
                    "Sudah punya akun? Login sekarang",
                    style: TextStyle(
                      color: Color(0xFFBE5985),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
