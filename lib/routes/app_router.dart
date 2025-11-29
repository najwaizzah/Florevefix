// lib/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../bindings/catalog_binding.dart';
import '../bindings/cart_binding.dart';

import '../controllers/auth_controller.dart';

import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/bouquet_detail_page.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/settings_page.dart';

import '../models/bouquet_model.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',

    // ===========================
    // AUTH MIDDLEWARE / REDIRECT
    // ===========================
    redirect: (context, state) {
      final auth = Get.find<AuthController>();

      final loggedIn = auth.isLoggedIn();
      final goingToLogin =
          state.uri.toString() == '/login'; //subloc == '/login';
      final goingToRegister =
          state.uri.toString() == '/register'; //subloc == '/register';

      // Jika belum login → hanya boleh masuk login/register
      if (!loggedIn && !goingToLogin && !goingToRegister) {
        return '/login';
      }

      // Jika sudah login → tidak boleh masuk login/register
      if (loggedIn && (goingToLogin || goingToRegister)) {
        return '/home';
      }

      return null;
    },

    // ===========================
    // ROUTES
    // ===========================
    routes: [
      // SPLASH SCREEN
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
        redirect: (context, state) {
          final auth = Get.find<AuthController>();
          return auth.isLoggedIn() ? '/home' : '/login';
        },
      ),

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

      // HOME
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
    ],
  );
}
