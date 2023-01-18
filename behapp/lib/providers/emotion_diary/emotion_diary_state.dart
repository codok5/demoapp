part of 'emotion_diary_provider.dart';

Box<EmotionDiaryObject> diarydb = Hive.box('emotiondiary');
final key = diarydb.keys;
final diary = diarydb.values;

class EmotionDiaryState extends Equatable {
  final Map<dynamic, EmotionDiaryObject> diarydata;

  EmotionDiaryState({
    required this.diarydata,
  });

  factory EmotionDiaryState.initial() {
    return EmotionDiaryState(diarydata: Map.fromIterables(key, diary));
  }

  @override
  List<Object> get props => [diarydata];

  @override
  String toString() => 'EmotionDiaryState(diarydata: $diarydata)';

  

  EmotionDiaryState copyWith({
    Map<dynamic, EmotionDiaryObject>? diarydata,
  }) {
    return EmotionDiaryState(
      diarydata: diarydata ?? this.diarydata,
    );
  }
}
