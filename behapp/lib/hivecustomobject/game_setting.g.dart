// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameSettingObjectAdapter extends TypeAdapter<GameSettingObject> {
  @override
  final int typeId = 7;

  @override
  GameSettingObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameSettingObject(
      character_list: (fields[0] as List).cast<String>(),
      map_list: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameSettingObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.character_list)
      ..writeByte(1)
      ..write(obj.map_list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameSettingObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
