// lib/models/bouquet_model.dart
import 'package:hive/hive.dart';
part 'bouquet_model.g.dart';

@HiveType(typeId: 1)
class BouquetModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final int? price;

  @HiveField(4)
  final String? imageUrl;

  BouquetModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory BouquetModel.fromJson(Map<String, dynamic> json) {
    return BouquetModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),

      name: json['name']?.toString(),

      description: json['description']?.toString(),

      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price']?.toString() ?? ''),

      imageUrl: json['image_url']?.toString(),
    );
  }
}
