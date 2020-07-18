import 'package:bibleplanner/models/book.dart';
import 'package:mobx/mobx.dart';
part 'bible_store.g.dart';

class BibleStore = _BibleStoreBase with _$BibleStore;

abstract class _BibleStoreBase with Store {
  @observable
  List<Book> _books;

  @computed
  List<Book> get books => _books;

  @action
  loadBooks() {
    fetchBooks().then((data) => _books = data);
  }
}
