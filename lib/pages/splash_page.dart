import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});


  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (auth.isLoggedIn()) Get.offAllNamed('/home');
      else Get.offAllNamed('/login');
    });


    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}