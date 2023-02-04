// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_todo_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodayTodoProgressObjectAdapter
    extends TypeAdapter<TodayTodoProgressObject> {
  @override
  final int typeId = 6;

  @override
  TodayTodoProgressObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodayTodoProgressObject(
      id_todo: fields[0] as String,
      completed: fields[1] as bool,
      done_time: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodayTodoProgressObject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id_todo)
      ..writeByte(1)
      ..write(obj.completed)
      ..writeByte(2)
      ..write(obj.done_time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodayTodoProgressObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
