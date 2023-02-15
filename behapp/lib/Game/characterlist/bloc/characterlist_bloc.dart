import 'package:behapp/Game/repository/repository.dart';
import 'package:behapp/hiveCustomModel/gamesetting.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'characterlist_event.dart';
part 'characterlist_state.dart';

class CharacterlistBloc extends Bloc<CharacterlistEvent, CharacterlistState> {
  CharacterlistBloc() : super(CharacterlistState.initial()) {
    on<CharacterlistEvent>((event, emit) {
    
    });
  }
}
