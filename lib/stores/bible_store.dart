import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/models/planner.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
part 'bible_store.g.dart';

class BibleStore = _BibleStoreBase with _$BibleStore;

abstract class _BibleStoreBase with Store {
  @observable
  List<Book>? books;

  @observable
  Planner? currentPlanner;

  @observable
  Map<String, List<int>>? currentPlannerBookChapters;

  @action
  void setCurrentPlanner() {
    var _box = Hive.box('planners');
    currentPlanner = _box.getAt(0);
    updateCurrentPlannerBookChapters();
  }

  @action
  void updateCurrentPlannerBookChapters() {
    currentPlannerBookChapters = currentPlanner!.bookChapters;
  }

  @action
  void clearChecked({String? bookAbbrev}) {
    currentPlanner?.clearChecked(bookAbbrev: bookAbbrev);
    this.updateCurrentPlannerBookChapters();
  }

  @action
  void toggleChecked({required String bookAbbrev, required int chapter}) {
    currentPlanner?.toggleChecked(bookAbbrev: bookAbbrev, chapter: chapter);
    this.updateCurrentPlannerBookChapters();
  }

  @action
  loadBooks() {
    fetchBooks().then((data) => books = data);
  }
}
