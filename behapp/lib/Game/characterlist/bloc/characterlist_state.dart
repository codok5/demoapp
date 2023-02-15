part of 'characterlist_bloc.dart';

class CharacterlistState extends Equatable {
  final List<Character> characterlist;
  CharacterlistState({
    required this.characterlist,
  });

  @override
  List<Object> get props => [characterlist];

  CharacterlistState.initial() : this(characterlist: Repository.GetCharacterList());
}
