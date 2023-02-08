import 'package:behapp/hivecustomobject/today_todo_progress.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';

part 'date_progress_state.dart';

class DateProgressProvider extends StateNotifier<DateProgressState>
    with LocatorMixin {
  DateProgressProvider() : super(DateProgressState.initial());

  void makedateprogress(
      int id_date, TodayTodoProgressObject todayTodoProgressObject) {
    Map<dynamic, List<dynamic>> newdateprogressdata = {
      ...state.dateprogressdata
    };
    newdateprogressdata[id_date] = [
      ...newdateprogressdata[id_date] ?? [],
      todayTodoProgressObject
    ];

    state = state.copyWith(dateprogressdata: newdateprogressdata);
    dateprogressdb.put(id_date, [...newdateprogressdata[id_date]!]);
  }

  void deleteprogress(String id_todo) {
    Map<dynamic, List<dynamic>> newdateprogressdata = {
      ...state.dateprogressdata
    };
    for (var key in newdateprogressdata.keys) {
      List<dynamic> list = newdateprogressdata[key]!;
      for (int i = 0; i < list.length; i++) {
        if (list[i].id_todo == id_todo) {
          list.removeAt(i);
          break;
        }
      }
      newdateprogressdata[key] = list;
      dateprogressdb.put(key, list);
    }
    state = state.copyWith(dateprogressdata: newdateprogressdata);
  }

  void togglecompleted(int date, String id_todo) {
    Map<dynamic, List<dynamic>> newdateprogressdata = {
      ...state.dateprogressdata
    };

    for (var todaytodo in newdateprogressdata[date]!) {
      if (todaytodo.id_todo == id_todo) {
        todaytodo.completed = !todaytodo.completed;
        break;
      }
    }

    state = state.copyWith(dateprogressdata: newdateprogressdata);
    dateprogressdb.put(date, newdateprogressdata[date]!);
  }

  void changetodaydonetime(String id_todo, int done_time) {
    Map<dynamic, List<dynamic>> newdateprogressdata = {
      ...state.dateprogressdata
    };
    for (var todaytodo in newdateprogressdata[
        formatdatetoint(formatint.format(DateTime.now()))]!) {
      if (todaytodo.id_todo == id_todo) {
        todaytodo.done_time = done_time;
        break;
      }
    }
    state = state.copyWith(dateprogressdata: newdateprogressdata);
    dateprogressdb.put(
        formatdatetoint(formatint.format(DateTime.now())),
        newdateprogressdata[
            formatdatetoint(formatint.format(DateTime.now()))]!);
  }
}
