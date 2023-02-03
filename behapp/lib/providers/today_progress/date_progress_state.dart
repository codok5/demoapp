part of 'date_progress_provider.dart';

Box<List<dynamic>> dateprogressdb = Hive.box(
    'todoprogress'); // key = int Date , value = List<TodayTodoProgressObject>
final dateprogresskey = dateprogressdb.keys;
final dateprogressvalue = dateprogressdb.values;

class DateProgressState extends Equatable {
  final Map<dynamic, List<dynamic>> dateprogressdata;
  DateProgressState({
    required this.dateprogressdata,
  });

  factory DateProgressState.initial() {
    return DateProgressState(
        dateprogressdata:
            Map.fromIterables(dateprogresskey, dateprogressvalue));
  }

  @override
  List<Object> get props => [dateprogressdata];

  @override
  String toString() => 'DateProgressState(dateprogressdata: $dateprogressdata)';

  DateProgressState copyWith({
    Map<dynamic, List<dynamic>>? dateprogressdata,
  }) {
    return DateProgressState(
      dateprogressdata: dateprogressdata ?? this.dateprogressdata,
    );
  }
}
