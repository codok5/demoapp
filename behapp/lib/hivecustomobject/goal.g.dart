// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalObjectAdapter extends TypeAdapter<GoalObject> {
  @override
  final int typeId = 2;

  @override
  GoalObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalObject(
      content: fields[0] as String,
      startday: fields[1] as DateTime,
      endday: fields[2] as DateTime,
      completed: fields[3] as bool,
      goalType: fields[4] as GoalType,
    );
  }

  @override
  void write(BinaryWriter writer, GoalObject obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.startday)
      ..writeByte(2)
      ..write(obj.endday)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.goalType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final int typeId = 3;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 5:
        return GoalType.binary;
      case 6:
        return GoalType.time;
      default:
        return GoalType.binary;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.binary:
        writer.writeByte(5);
        break;
      case GoalType.time:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
