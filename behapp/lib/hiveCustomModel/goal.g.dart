// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalObjectAdapter extends TypeAdapter<GoalObject> {
  @override
  final int typeId = 3;

  @override
  GoalObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalObject(
      id_goal: fields[0] as String,
      name: fields[1] as String,
      content: fields[2] as String,
      startday: fields[3] as DateTime,
      endday: fields[4] as DateTime,
      presentprogress: fields[5] as int,
      completed: fields[6] as bool,
      id_todo_list: (fields[7] as List).cast<dynamic>(),
      goalType: fields[8] as GoalType,
      rewardcoin: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GoalObject obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id_goal)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.startday)
      ..writeByte(4)
      ..write(obj.endday)
      ..writeByte(5)
      ..write(obj.presentprogress)
      ..writeByte(6)
      ..write(obj.completed)
      ..writeByte(7)
      ..write(obj.id_todo_list)
      ..writeByte(8)
      ..write(obj.goalType)
      ..writeByte(9)
      ..write(obj.rewardcoin);
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
  final int typeId = 2;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 13:
        return GoalType.education;
      case 14:
        return GoalType.health;
      case 15:
        return GoalType.hobby;
      case 16:
        return GoalType.etc;
      default:
        return GoalType.education;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.education:
        writer.writeByte(13);
        break;
      case GoalType.health:
        writer.writeByte(14);
        break;
      case GoalType.hobby:
        writer.writeByte(15);
        break;
      case GoalType.etc:
        writer.writeByte(16);
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
