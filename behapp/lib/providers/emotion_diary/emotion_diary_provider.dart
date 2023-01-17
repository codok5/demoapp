import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

part 'emotion_diary_state.dart';

class EmotionDiaryProvider extends StateNotifier<EmotionDiaryState>
    with LocatorMixin {
  EmotionDiaryProvider() : super(EmotionDiaryState.initial());

  void writeDiary(String date, String doc1,String doc2, String doc3, Emotion emotion) {
    Map<String, List<dynamic>> ndiarydata = state.diarydata;
    ndiarydata = {
      ...state.diarydata,
      date: [
        doc1,doc2,doc3,emotion
      ]
    };
    state = state.copyWith(diarydata: ndiarydata);
  }
}
