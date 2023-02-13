import 'package:behapp/Game/repository/repository.dart';
import 'package:behapp/hivecustomobject/item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({required this.repository}) : super(InventoryState.initial()) {
    on<ItemAdd>(_ItemAdd);
  }
  final Repository repository;

  void _ItemAdd(ItemAdd event, emit) {
    emit(
      state.copyWith(
        items: [...state.items, event.item],
      ),
    );
  }


}
