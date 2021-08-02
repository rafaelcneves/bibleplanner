import 'package:hive/hive.dart';

part 'planner.g.dart';

@HiveType(typeId: 0)
class Planner extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Map<String, List<int>> bookChapters;

  Planner({required this.name, required this.bookChapters});

  void clearChecked({String? bookAbbrev}) {
    if (bookAbbrev == null)
      this.bookChapters.clear();
    else if (this.bookChapters[bookAbbrev] != null)
      this.bookChapters[bookAbbrev]?.clear();
    else
      return;

    this.save();
  }

  void toggleChecked({required String bookAbbrev, required int chapter}) {
    if (this.bookChapters[bookAbbrev] == null)
      this.bookChapters[bookAbbrev] = [];

    if ((this.bookChapters[bookAbbrev] ?? []).indexOf(chapter) >= 0) {
      this.bookChapters[bookAbbrev]?.remove(chapter);
    } else {
      this.bookChapters[bookAbbrev]?.add(chapter);
    }

    this.save();
  }
}
