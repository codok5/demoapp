part of 'player_bloc.dart';

class PlayerState extends Equatable {
  PlayerState({required this.gear, required this.character});

  PlayerState.initial()
      : this(gear: {
          Slot.head: Repository.GetEquipedGear()[Slot.head],
          Slot.lefthand: Repository.GetEquipedGear()[Slot.lefthand],
          Slot.righthand: Repository.GetEquipedGear()[Slot.righthand],
          Slot.top: Repository.GetEquipedGear()[Slot.top],
          Slot.pants: Repository.GetEquipedGear()[Slot.pants],
          Slot.shoe: Repository.GetEquipedGear()[Slot.shoe],
        }, character: Repository.GetLatestCharacter() ?? Character.baby);

  final Map<Slot, Item?> gear;
  final Character character;

 

  bool isItemEquiped(Item item) {
    return gear.values.contains(item);
  }

  PlayerState copyWith({
    Map<Slot, Item?>? gear,
    Character? character,
  }) {
    return PlayerState(
      gear: gear ?? this.gear,
      character: character ?? this.character,
    );
  }

  @override
  List<Object> get props => [gear, character];
}
