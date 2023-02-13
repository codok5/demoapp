import 'package:hive_flutter/hive_flutter.dart';

Box<List<dynamic>> iteminvetorydb = Hive.box('gamesetting');

class Repository {
  static List<dynamic> getItemInventory() {
    final List<dynamic> iteminventory =
        iteminvetorydb.get('iteminventory') ?? [];
    return iteminventory;
  }
}
