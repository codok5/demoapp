part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class ItemSelected extends PlayerEvent {
  final Item item;

  ItemSelected({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class CharacterSelected extends PlayerEvent {
  final Character character;
  CharacterSelected({
    required this.character,
  });

  @override
  List<Object> get props => [character];
}


