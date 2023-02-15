part of 'player_bloc.dart';

class PlayerState extends Equatable {
  PlayerState({required this.gear, required this.character});

  PlayerState.initial()
      : this(gear: {
          Slot.head: Repository.GetEquipedGear()?['head'] ?? null,
          Slot.lefthand: Repository.GetEquipedGear()?['lefthand'] ?? null,
          Slot.righthand: Repository.GetEquipedGear()?['righthand'] ?? null,
          Slot.top: Repository.GetEquipedGear()?['top'] ?? null,
          Slot.pants: Repository.GetEquipedGear()?['pants'] ?? null,
          Slot.shoe: Repository.GetEquipedGear()?['shoe'] ?? null,
        }, character: Repository.GetLatestCharacter() ?? Character.ailen);

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
