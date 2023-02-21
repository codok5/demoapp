import 'dart:math';

import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';

extension GetRandomItem on Item {
  static Item generateRandomItem() {
    List<Item> list = List.from(Item.values);
    return list[Random().nextInt(list.length)];
  }
}

extension ItemSlot on Item {
  Slot get slots {
    switch (this) {
      case Item.sword1:
      case Item.sword2:
        return Slot.righthand;
      case Item.hat:
        return Slot.head;
    }
  }
}
