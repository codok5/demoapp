import 'package:behapp/Game/model/Item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryState.initial()) {
    on<ItemAdd>(_ItemAdd);
  }

  void _ItemAdd(ItemAdd event, emit) {
    emit(
      state.copyWith(
        items: [...state.items, event.item],
      ),
    );
  }
}
