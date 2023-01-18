import 'package:hive/hive.dart';

part 'emotion_diary.g.dart';

@HiveType(typeId: 0)
class EmotionDiaryObject extends HiveObject {
  @HiveField(0)
  final String docfirst;

  @HiveField(1)
  final String docsecond;

  @HiveField(2)
  final String docthird;

  @HiveField(3)
  final Emotion emotion;

  EmotionDiaryObject({
    required this.docfirst,
    required this.docsecond,
    required this.docthird,
    required this.emotion,
  });
}

@HiveType(typeId: 1)
enum Emotion {
  @HiveField(4)
  initial,
  @HiveField(5)
  happy,
  @HiveField(6)
  good,
  @HiveField(7)
  tired,
  @HiveField(8)
  sad,
  @HiveField(9)
  angry,
}
