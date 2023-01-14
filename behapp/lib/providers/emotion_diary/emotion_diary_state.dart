part of 'emotion_diary_provider.dart';

enum Emotion { happpy, good, sad, tired, angry }

class EmotionDiaryState extends Equatable {
  final Map<String, List<dynamic>> diarydata;

  EmotionDiaryState({
    required this.diarydata,
  });

  factory EmotionDiaryState.initial() {
    return EmotionDiaryState(diarydata: const {});
  }

  @override
  List<Object> get props => [diarydata];

  @override
  String toString() => 'EmotionDiaryState(diarydata: $diarydata)';

  EmotionDiaryState copyWith({
    Map<String, List<dynamic>>? diarydata,
  }) {
    return EmotionDiaryState(
      diarydata: diarydata ?? this.diarydata,
    );
  }
}
