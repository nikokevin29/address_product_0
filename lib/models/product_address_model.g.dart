// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAddressModelAdapter extends TypeAdapter<ProductAddressModel> {
  @override
  final int typeId = 0;

  @override
  ProductAddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductAddressModel()
      ..productName = fields[0] as String
      ..qty = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, ProductAddressModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
