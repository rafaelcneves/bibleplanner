import 'package:hive/hive.dart';

part 'planner.g.dart';

@HiveType(typeId: 0)
class Planner extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Map<String, List<int>> bookChapters;
}
