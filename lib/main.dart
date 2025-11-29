// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bindings/auth_binding.dart';
import 'routes/app_router.dart';
import 'services/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ================================
  // LOAD ENV
  // ================================
  await dotenv.load(fileName: ".env");

  // ================================
  // INIT SUPABASE
  // ================================
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
  );

  // ================================
  // INIT HIVE
  // ================================
  await Hive.initFlutter();
  HiveBoxes.registerAdapters();
  await Hive.openBox('cartBox');

  // RUN APP
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;

    return GetMaterialApp.router(
      title: "Florist Floreve",
      debugShowCheckedModeBanner: false,

      // ⭐ WAJIB ADA BINDING DI SINI ⭐
      initialBinding: AuthBinding(),

      theme: ThemeData(
        primaryColor: const Color(0xFFEC7FA9),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEC7FA9),
          primary: const Color(0xFFEC7FA9),
        ),
      ),

      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
