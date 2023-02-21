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

  static Future<void> AddItem(Item item) async {
    try {
      List<Item> newiteminventory = [
        ...gamesettingdb.get('iteminventory') ?? [],
        item
      ];
      newiteminventory = newiteminventory.toSet().toList();
      gamesettingdb.put('iteminventory', newiteminventory);
    } catch (e) {
      throw Error();
    }
  }

  static Map<Slot, Item?> GetEquipedGear() {
    Map<String, dynamic>? latestsetting = {
      ...gamesettingdb.get('latestsetting') ?? {}
    };
    if (latestsetting != {}) {
      return {
        Slot.head: latestsetting['head'],
        Slot.lefthand: latestsetting['lefthand'],
        Slot.righthand: latestsetting['righthand'],
        Slot.top: latestsetting['top'],
        Slot.pants: latestsetting['pants'],
        Slot.shoe: latestsetting['shoe'],
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
    Character? latestCharacter =
        gamesettingdb.get('latestsetting')?['character'];
    return latestCharacter;
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
