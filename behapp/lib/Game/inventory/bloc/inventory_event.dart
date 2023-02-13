part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class ItemAdd extends InventoryEvent {
  final Item item;
  ItemAdd({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}
