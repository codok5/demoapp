import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';

part 'date_progress_state.dart';

class DateProgressProvider extends StateNotifier<DateProgressState>
    with LocatorMixin {
  DateProgressProvider() : super(DateProgressState.initial());

  
}
