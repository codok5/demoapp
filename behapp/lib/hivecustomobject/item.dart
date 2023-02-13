import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 7)
enum Item {
  @HiveField(0)
  sword1,
  @HiveField(1)
  sword2,
  @HiveField(2)
  hat,
}