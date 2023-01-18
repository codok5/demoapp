// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_diary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmotionDiaryObjectAdapter extends TypeAdapter<EmotionDiaryObject> {
  @override
  final int typeId = 0;

  @override
  EmotionDiaryObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmotionDiaryObject(
      docfirst: fields[0] as String,
      docsecond: fields[1] as String,
      docthird: fields[2] as String,
      emotion: fields[3] as Emotion,
    );
  }

  @override
  void write(BinaryWriter writer, EmotionDiaryObject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.docfirst)
      ..writeByte(1)
      ..write(obj.docsecond)
      ..writeByte(2)
      ..write(obj.docthird)
      ..writeByte(3)
      ..write(obj.emotion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmotionDiaryObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmotionAdapter extends TypeAdapter<Emotion> {
  @override
  final int typeId = 1;

  @override
  Emotion read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 4:
        return Emotion.initial;
      case 5:
        return Emotion.happy;
      case 6:
        return Emotion.good;
      case 7:
        return Emotion.tired;
      case 8:
        return Emotion.sad;
      case 9:
        return Emotion.angry;
      default:
        return Emotion.initial;
    }
  }

  @override
  void write(BinaryWriter writer, Emotion obj) {
    switch (obj) {
      case Emotion.initial:
        writer.writeByte(4);
        break;
      case Emotion.happy:
        writer.writeByte(5);
        break;
      case Emotion.good:
        writer.writeByte(6);
        break;
      case Emotion.tired:
        writer.writeByte(7);
        break;
      case Emotion.sad:
        writer.writeByte(8);
        break;
      case Emotion.angry:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmotionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
