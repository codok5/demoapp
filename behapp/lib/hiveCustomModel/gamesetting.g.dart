// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamesetting.dart';

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

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 8;

  @override
  Character read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 3:
        return Character.rabbit;
      case 5:
        return Character.baby;
      case 6:
        return Character.boy;
      default:
        return Character.rabbit;
    }
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    switch (obj) {
      case Character.rabbit:
        writer.writeByte(3);
        break;
      case Character.baby:
        writer.writeByte(5);
        break;
      case Character.boy:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SlotAdapter extends TypeAdapter<Slot> {
  @override
  final int typeId = 9;

  @override
  Slot read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 7:
        return Slot.head;
      case 8:
        return Slot.righthand;
      case 9:
        return Slot.lefthand;
      case 10:
        return Slot.top;
      case 11:
        return Slot.pants;
      case 12:
        return Slot.shoe;
      default:
        return Slot.head;
    }
  }

  @override
  void write(BinaryWriter writer, Slot obj) {
    switch (obj) {
      case Slot.head:
        writer.writeByte(7);
        break;
      case Slot.righthand:
        writer.writeByte(8);
        break;
      case Slot.lefthand:
        writer.writeByte(9);
        break;
      case Slot.top:
        writer.writeByte(10);
        break;
      case Slot.pants:
        writer.writeByte(11);
        break;
      case Slot.shoe:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
