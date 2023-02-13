part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  InventoryState({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  final List<dynamic> items; // hive 오류로 인함. List<Item>이 맞음

  InventoryState.initial() : this(items: Repository.getItemInventory());

  InventoryState copyWith({
    List<dynamic>? items,
  }) {
    return InventoryState(
      items: items ?? this.items,
    );
  }
}
