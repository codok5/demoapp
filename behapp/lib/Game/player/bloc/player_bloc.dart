import 'package:behapp/Game/model/Item.dart';
import 'package:behapp/Game/repository/repository.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerState.initial()) {
    on<CharacterSelected>(_CharacterSelected);
    on<ItemSelected>(_ItemSelected);
  }

  void _ItemSelected(ItemSelected event, emit) {
    final item = event.item;
    final slot = item.slots;
    if (state.isItemEquiped(item)) {
      emit(state.copyWith(gear: {...state.gear, slot: null}));
    } else {
      emit(state.copyWith(gear: {...state.gear, slot: item}));
    }
  }

  void _CharacterSelected(CharacterSelected event, emit) {
    print('character change to ${event.character}');
    emit(state.copyWith(character: event.character));
  }
}
