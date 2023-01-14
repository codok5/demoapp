import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

part 'emotion_diary_state.dart';

class EmotionDiaryProvider extends StateNotifier<EmotionDiaryState>
    with LocatorMixin {
  EmotionDiaryProvider() : super(EmotionDiaryState.initial());

  void writeDiary(String date, String doc) {
    Map<String, List<dynamic>> ndiarydata = state.diarydata;
    ndiarydata = {
      ...state.diarydata,
      date: [
        doc,
      ]
    };
    state = state.copyWith(diarydata: ndiarydata);
  }
}
