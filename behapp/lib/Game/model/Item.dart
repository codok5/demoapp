import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';




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
