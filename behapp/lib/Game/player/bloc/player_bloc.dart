import 'package:behapp/Game/model/Item.dart';
import 'package:behapp/hivecustomobject/item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerState.initial()) {
    on<ItemSelected>(_ItemSelected);
  }

  void _ItemSelected(ItemSelected event, emit) {
    final item = event.item;
    final slot = item.slots;
    if (state.isItemEquiped(item)) {
      emit(state.copyWithGear(slot: slot, item: null));
    } else {
      emit(state.copyWithGear(slot: slot, item: item));
    }
  }
}
