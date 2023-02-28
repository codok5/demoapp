enum PlantStatus {
  q1,
  q2,
  q3,
  q4,
}

extension PlantStatusOrder on PlantStatus {
  int get order {
    switch (this) {
      case PlantStatus.q1:
        return 0;
      case PlantStatus.q2:
        return 1;
      case PlantStatus.q3:
        return 2;
      case PlantStatus.q4:
        return 3;
    }
  }
}

enum PlantKind {
  first,
  second,
  third,
  fourth,
  fifth,
  sixth,
}

extension PlantOrder on PlantKind {
  int get order {
    switch (this) {
      case PlantKind.first:
        return 1;
      case PlantKind.second:
        return 2;
      case PlantKind.third:
        return 3;
      case PlantKind.fourth:
        return 4;
      case PlantKind.fifth:
        return 5;
      case PlantKind.sixth:
        return 6;
    }
  }
}

class Plant {
  final PlantStatus plantStatus;
  final PlantKind plantKind;
  Plant({
    required this.plantStatus,
    required this.plantKind,
  });
}
