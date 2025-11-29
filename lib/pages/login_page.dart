// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // LOGO / TITLE
                const Text(
                  "FloristFloreve",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEC7FA9),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Selamat datang! Silakan login untuk melanjutkan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFBE5985), fontSize: 14),
                ),

                const SizedBox(height: 40),

                // EMAIL
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
                  onSubmitted: (_) {
                    auth.login(emailC.text.trim(), passC.text.trim());
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // LOGIN BUTTON
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
                        : () {
                            if (emailC.text.isEmpty || passC.text.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Email dan password tidak boleh kosong",
                                backgroundColor: Colors.red.shade300,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            auth.login(emailC.text.trim(), passC.text.trim());
                          },
                    child: auth.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  );
                }),

                const SizedBox(height: 20),

                // ERROR MESSAGE
                Obx(() {
                  if (auth.errorMessage.isEmpty) return const SizedBox();
                  return Text(
                    auth.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }),

                const SizedBox(height: 20),

                // REGISTER LINK
                GestureDetector(
                  onTap: () => context.go('/register'),
                  child: const Text(
                    "Belum punya akun? Daftar sekarang",
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
