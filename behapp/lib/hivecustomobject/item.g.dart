// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 7;

  @override
  Item read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Item.sword1;
      case 1:
        return Item.sword2;
      case 2:
        return Item.hat;
      default:
        return Item.sword1;
    }
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    switch (obj) {
      case Item.sword1:
        writer.writeByte(0);
        break;
      case Item.sword2:
        writer.writeByte(1);
        break;
      case Item.hat:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
