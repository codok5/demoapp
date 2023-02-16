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

  static Map<Slot, Item?> GetEquipedGear() {
    if (gamesettingdb.get('latestsetting') != null) {
      return {
        Slot.head: gamesettingdb.get('latestsetting')['head'],
        Slot.lefthand: gamesettingdb.get('latestsetting')['lefthand'],
        Slot.righthand: gamesettingdb.get('latestsetting')['righthand'],
        Slot.top: gamesettingdb.get('latestsetting')['top'],
        Slot.pants: gamesettingdb.get('latestsetting')['pants'],
        Slot.shoe: gamesettingdb.get('latestsetting')['shoe'],
      };
    } else {
      return {
        Slot.head: null,
        Slot.lefthand: null,
        Slot.righthand: null,
        Slot.top: null,
        Slot.pants: null,
        Slot.shoe: null,
      };
    }
  }

  static Character? GetLatestCharacter() {
    return gamesettingdb.get('latestsetting')?['character'];
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
    required Map<Slot, Item?> gear,
    Character? character,
  }) {
    gamesettingdb.put('latestsetting', {
      'character': character,
      'head': gear[Slot.head],
      'righthand': gear[Slot.righthand],
      'lefthand': gear[Slot.lefthand],
      'top': gear[Slot.top],
      'pants': gear[Slot.pants],
      'shoe': gear[Slot.shoe],
    });
  }
}
