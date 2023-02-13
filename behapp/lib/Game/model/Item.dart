enum Slot {
  head,
  righthand,
  lefthand,
  top,
  pants,
  shoe,
}

enum Item {
  sword1,
  sword2,
  hat,
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
