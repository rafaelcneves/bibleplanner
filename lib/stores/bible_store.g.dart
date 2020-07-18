// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BibleStore on _BibleStoreBase, Store {
  Computed<List<Book>> _$booksComputed;

  @override
  List<Book> get books =>
      (_$booksComputed ??= Computed<List<Book>>(() => super.books,
              name: '_BibleStoreBase.books'))
          .value;

  final _$_booksAtom = Atom(name: '_BibleStoreBase._books');

  @override
  List<Book> get _books {
    _$_booksAtom.reportRead();
    return super._books;
  }

  @override
  set _books(List<Book> value) {
    _$_booksAtom.reportWrite(value, super._books, () {
      super._books = value;
    });
  }

  final _$_BibleStoreBaseActionController =
      ActionController(name: '_BibleStoreBase');

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
books: ${books}
    ''';
  }
}
