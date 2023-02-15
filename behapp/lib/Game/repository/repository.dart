import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box<dynamic> gamesettingdb = Hive.box('gamesetting');

class Repository {
  static List<Item> GetItemInventory() {
    final List<Item> iteminventory = [
      ...gamesettingdb.get('iteminventory') ?? []
    ];
    return iteminventory;
  }

  static void AddItem(Item item) {
    List<Item> newiteminventory = [
      ...gamesettingdb.get('iteminventory') ?? [],
      item
    ];
    newiteminventory = newiteminventory.toSet().toList();
    gamesettingdb.put('iteminventory', newiteminventory);
  }

  static Map<String, Item>? GetEquipedGear() {
    final Map<String, Item>? equipedGear =
        gamesettingdb.get('latestsetting')?['gear'];
    return equipedGear;
  }

  static Character? GetLatestCharacter() {
    return gamesettingdb.get('latestsetting')['character'];
  }

  static List<Character> GetCharacterList() {
    final List<Character> characterList = [
      ...gamesettingdb.get('characterlist') ?? []
    ];
    return characterList;
  }

  static void AddCharacter(Character character) {
    List<Character> newcharacterlist = [
      ...gamesettingdb.get('characterlist') ?? [],
      character
    ];
    newcharacterlist = newcharacterlist.toSet().toList();
    gamesettingdb.put('characterlist', newcharacterlist);
  }

  static void SaveSetting({
    Map<Slot, Item?>? gear,
    Character? character,
  }) {
    gamesettingdb.put('latestsetting', {
      'character': character,
      'head': gear![Slot.head],
      'lefthand': gear[Slot.lefthand],
      'righthand': gear[Slot.righthand],
      'top': gear[Slot.top],
      'pants': gear[Slot.pants],
      'shoe': gear[Slot.shoe],
    });
  }
}
