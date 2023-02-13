part of 'player_bloc.dart';

class PlayerState extends Equatable {
  PlayerState({
    required this.gear,
  });

  @override
  List<Object> get props => [gear];

  PlayerState.initial()
      : this(gear: {
          Slot.head: null,
          Slot.lefthand: null,
          Slot.righthand: null,
          Slot.top: null,
          Slot.pants: null,
          Slot.shoe: null,
        });

  final Map<Slot, Item?> gear;

  bool isItemEquiped(Item item) {
    return gear.values.contains(item);
  }

  PlayerState copyWithGear({
    required Slot slot,
    required Item? item,
  }) {
    return PlayerState(gear: {...gear, slot: item});
  }
}
