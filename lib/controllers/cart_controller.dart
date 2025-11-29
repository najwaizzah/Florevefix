// lib/controllers/cart_controller.dart

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  late Box<CartItem> cartBox;

  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    cartBox = Hive.box<CartItem>('cart_items');
    // Load saved items from Hive
    cartItems.assignAll(cartBox.values.toList());
  }

  // ====================================
  // ADD TO CART
  // ====================================
  void addToCart(CartItem item) {
    cartBox.add(item);
    cartItems.add(item);
    update();
  }

  // ====================================
  // REMOVE FROM CART
  // ====================================
  void removeAt(int index) {
    cartBox.deleteAt(index);
    cartItems.removeAt(index);
  }

  // ====================================
  // CLEAR CART
  // ====================================
  void clearCart() {
    cartBox.clear();
    cartItems.clear();
  }

  // ====================================
  // TOTAL PRICE
  // ====================================
  int get totalPrice => cartItems.fold<int>(0, (s, i) => s + (i.price * i.quantity));
}
