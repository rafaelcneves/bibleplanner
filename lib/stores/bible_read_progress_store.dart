import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/models/planner.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BibleReadProgressStore extends ChangeNotifier {
  late Planner currentPlanner;

  BibleReadProgressStore() {
    var _box = Hive.box<Planner>('planners');
    currentPlanner = _box.getAt(0) ?? new Planner(name: '', bookChapters: {});
  }

  Map<String, List<int>> get readProgressChapters {
    return currentPlanner.bookChapters;
  }

  void clearChecked({String? bookAbbrev}) {
    currentPlanner.clearChecked(bookAbbrev: bookAbbrev);
    notifyListeners();
  }

  void toggleChecked({required String bookAbbrev, required int chapter}) {
    currentPlanner.toggleChecked(bookAbbrev: bookAbbrev, chapter: chapter);
    notifyListeners();
  }

  double getBookReadProgress(Book book) {
    num progress = readProgressChapters[book.abbrev.pt]?.length ?? 0;
    return progress / book.chapters;
  }
}
