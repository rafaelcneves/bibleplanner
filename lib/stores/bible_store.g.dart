// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BibleStore on _BibleStoreBase, Store {
  final _$booksAtom = Atom(name: '_BibleStoreBase.books');

  @override
  List<Book>? get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(List<Book>? value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  final _$currentPlannerAtom = Atom(name: '_BibleStoreBase.currentPlanner');

  @override
  Planner? get currentPlanner {
    _$currentPlannerAtom.reportRead();
    return super.currentPlanner;
  }

  @override
  set currentPlanner(Planner? value) {
    _$currentPlannerAtom.reportWrite(value, super.currentPlanner, () {
      super.currentPlanner = value;
    });
  }

  final _$currentPlannerBookChaptersAtom =
      Atom(name: '_BibleStoreBase.currentPlannerBookChapters');

  @override
  Map<String, List<int>>? get currentPlannerBookChapters {
    _$currentPlannerBookChaptersAtom.reportRead();
    return super.currentPlannerBookChapters;
  }

  @override
  set currentPlannerBookChapters(Map<String, List<int>>? value) {
    _$currentPlannerBookChaptersAtom
        .reportWrite(value, super.currentPlannerBookChapters, () {
      super.currentPlannerBookChapters = value;
    });
  }

  final _$_BibleStoreBaseActionController =
      ActionController(name: '_BibleStoreBase');

  @override
  void setCurrentPlanner() {
    final _$actionInfo = _$_BibleStoreBaseActionController.startAction(
        name: '_BibleStoreBase.setCurrentPlanner');
    try {
      return super.setCurrentPlanner();
    } finally {
      _$_BibleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCurrentPlannerBookChapters() {
    final _$actionInfo = _$_BibleStoreBaseActionController.startAction(
        name: '_BibleStoreBase.updateCurrentPlannerBookChapters');
    try {
      return super.updateCurrentPlannerBookChapters();
    } finally {
      _$_BibleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearChecked({String? bookAbbrev}) {
    final _$actionInfo = _$_BibleStoreBaseActionController.startAction(
        name: '_BibleStoreBase.clearChecked');
    try {
      return super.clearChecked(bookAbbrev: bookAbbrev);
    } finally {
      _$_BibleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleChecked({required String bookAbbrev, required int chapter}) {
    final _$actionInfo = _$_BibleStoreBaseActionController.startAction(
        name: '_BibleStoreBase.toggleChecked');
    try {
      return super.toggleChecked(bookAbbrev: bookAbbrev, chapter: chapter);
    } finally {
      _$_BibleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadBooks() {
    final _$actionInfo = _$_BibleStoreBaseActionController.startAction(
        name: '_BibleStoreBase.loadBooks');
    try {
      return super.loadBooks();
    } finally {
      _$_BibleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
books: ${books},
currentPlanner: ${currentPlanner},
currentPlannerBookChapters: ${currentPlannerBookChapters}
    ''';
  }
}
