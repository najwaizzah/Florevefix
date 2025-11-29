// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bouquet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BouquetModelAdapter extends TypeAdapter<BouquetModel> {
  @override
  final int typeId = 1;

  @override
  BouquetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BouquetModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      price: fields[3] as int?,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BouquetModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
