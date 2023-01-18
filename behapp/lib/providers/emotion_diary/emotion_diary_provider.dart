import 'package:behapp/hivecustomobject/emotion_diary.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';

part 'emotion_diary_state.dart';

class EmotionDiaryProvider extends StateNotifier<EmotionDiaryState>
    with LocatorMixin {
  EmotionDiaryProvider() : super(EmotionDiaryState.initial());

  void writeDiary(
      String date, String doc1, String doc2, String doc3, Emotion emotion) {
    Map<String, EmotionDiaryObject> ndiarydata = {
      ...state.diarydata,
      date: EmotionDiaryObject(
        docfirst: doc1,
        docsecond: doc2,
        docthird: doc3,
        emotion: emotion,
      ),
    };
    state = state.copyWith(diarydata: ndiarydata);
    diarydb.put(
      date,
      EmotionDiaryObject(
        docfirst: doc1,
        docsecond: doc2,
        docthird: doc3,
        emotion: emotion,
      ),
    );
  }
}
