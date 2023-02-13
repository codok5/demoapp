import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'background_event.dart';
part 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  BackgroundBloc() : super(BackgroundInitial()) {
    on<BackgroundEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
