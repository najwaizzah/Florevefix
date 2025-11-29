// lib/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

// ===== BINDINGS =====
import '../bindings/auth_binding.dart';
import '../bindings/catalog_binding.dart';
import '../bindings/cart_binding.dart';
import '../bindings/location_binding.dart';

// ===== CONTROLLERS =====
import '../controllers/auth_controller.dart';

// ===== PAGES =====
import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/bouquet_detail_page.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/settings_page.dart';

// ===== MODELS =====
import '../models/bouquet_model.dart';

// ===== LOCATION VIEWS =====
import '../views/location/network_location_view.dart';
import '../views/location/gps_location_view.dart';
import '../views/location/live_location_view.dart';
import '../views/location/map_view.dart'; // ini MapLocationView

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',

    // ====================================================
    // AUTH MIDDLEWARE / REDIRECT
    // ====================================================
    redirect: (context, state) {
      final auth = Get.find<AuthController>();

      final loggedIn = auth.isLoggedIn();
      final goingToLogin = state.uri.toString() == '/login';
      final goingToRegister = state.uri.toString() == '/register';

      if (!loggedIn && !goingToLogin && !goingToRegister) return '/login';
      if (loggedIn && (goingToLogin || goingToRegister)) return '/home';

      return null;
    },

    // ====================================================
    // ROUTES
    // ====================================================
    routes: [
      // SPLASH SCREEN
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),

      // LOGIN
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          AuthBinding().dependencies();
          return const MaterialPage(child: LoginPage());
        },
      ),

      // REGISTER
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          AuthBinding().dependencies();
          return const MaterialPage(child: RegisterPage());
        },
      ),

      // HOME PAGE
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) {
          CatalogBinding().dependencies();
          return MaterialPage(child: HomePage());
        },
      ),

      // DETAIL PAGE
      GoRoute(
        path: '/detail',
        pageBuilder: (context, state) {
          CatalogBinding().dependencies();
          final bouquet = state.extra as BouquetModel;
          return MaterialPage(child: BouquetDetailPage(bouquet: bouquet));
        },
      ),

      // CART PAGE
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) {
          CartBinding().dependencies();
          return const MaterialPage(child: CartPage());
        },
      ),

      // CHECKOUT PAGE
      GoRoute(
        path: '/checkout',
        pageBuilder: (context, state) {
          CartBinding().dependencies();
          return MaterialPage(child: CheckoutPage());
        },
      ),

      // SETTINGS
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) {
          AuthBinding().dependencies();
          return const MaterialPage(child: SettingsPage());
        },
      ),

      // ====================================================
      // LOCATION FEATURE ROUTES
      // ====================================================

      // LIVE LOCATION
      GoRoute(
        path: '/location',
        pageBuilder: (context, state) {
          LocationBinding().dependencies();
          return const MaterialPage(child: LiveLocationView());
        },
      ),

      // GPS LOCATION
      GoRoute(
        path: '/gps-location',
        pageBuilder: (context, state) {
          LocationBinding().dependencies();
          return const MaterialPage(child: GPSLocationView());
        },
      ),

      // NETWORK LOCATION
      GoRoute(
        path: '/network-location',
        pageBuilder: (context, state) {
          LocationBinding().dependencies();
          return const MaterialPage(child: NetworkLocationView());
        },
      ),

      // MAP VIEW
      GoRoute(
        path: '/map',
        pageBuilder: (context, state) {
          LocationBinding().dependencies();
          return const MaterialPage(child: MapLocationView());
        },
      ),
    ],
  );
}
