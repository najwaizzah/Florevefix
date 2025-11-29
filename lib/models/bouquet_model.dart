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


  BouquetModel({this.id, this.name, this.description, this.price, this.imageUrl});


  factory BouquetModel.fromJson(Map<String, dynamic> json) {
    return BouquetModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: json['price'] as int?,
      imageUrl: json['image_url'] as String?,  // sesuaikan dengan nama field di database
    );
  }
}
