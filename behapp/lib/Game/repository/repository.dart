import 'package:behapp/hivecustomobject/item.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box<dynamic> gamesettingdb = Hive.box('gamesetting');

class Repository {
  static Set<dynamic> getItemInventory() {
    final Set<dynamic> iteminventory = gamesettingdb.get('iteminventory') ?? {};
    return iteminventory;
  }

  static Map<String, Item> getEquipedGear() {
    final equipedGear = gamesettingdb.get('equipedGear') ?? {};
    return equipedGear;
  }
}
