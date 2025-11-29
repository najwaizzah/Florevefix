import 'package:hive/hive.dart';
part 'cart_item.g.dart';


@HiveType(typeId: 0)
class CartItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final int quantity;

  CartItem({required this.id, required this.name, required this.price, required this.imageUrl, this.quantity = 1});
}