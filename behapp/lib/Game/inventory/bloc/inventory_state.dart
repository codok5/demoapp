part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  InventoryState({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  final List<Item> items;

  InventoryState.initial()
      : this(items: [
          Item.hat,
          Item.sword1,
          Item.sword2,
        ]);

  InventoryState copyWith({
    List<Item>? items,
  }) {
    return InventoryState(
      items: items ?? this.items,
    );
  }
}
