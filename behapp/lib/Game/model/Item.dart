import 'package:behapp/hivecustomobject/item.dart';

enum Slot {
  head,
  righthand,
  lefthand,
  top,
  pants,
  shoe,
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
