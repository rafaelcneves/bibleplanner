import 'package:bibleplanner/components/alert_component.dart';
import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/pages/chapters_page/chapters_page.dart';
import 'package:bibleplanner/stores/bible_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BibleStore _bibleStore;

  @override
  void initState() {
    super.initState();
    _bibleStore = GetIt.instance<BibleStore>();
    _bibleStore.setCurrentPlanner();

    if (_bibleStore.books == null) {
      _bibleStore.loadBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner de leitura da Bíblia'),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertComponent(
                      title: Text('Alerta'),
                      content: Text(
                          'Deseja realmente remover todo seu progresso de leitura?'),
                      confirm: () {
                        _bibleStore.currentPlanner.bookChapters.clear();
                        _bibleStore.currentPlanner.save();
                        _bibleStore.updateCurrentPlannerBookChapters();
                      },
                    );
                  });
            },
          )
        ],
      ),
      body: Observer(
        name: 'BooksList',
        builder: (context) {
          List<Book> _books = _bibleStore.books;
          Map<String, List<int>> _bookChapters =
              _bibleStore.currentPlannerBookChapters;

          return (_books != null)
              ? AnimationLimiter(
                  child: ListView.builder(
                    itemCount: _bibleStore.books.length,
                    itemBuilder: (context, index) {
                      Book _book = _books[index];
                      List<int> _checked = _bookChapters[_book.abbrev.pt] ?? [];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.black12),
                              ),
                            ),
                            child: ListTile(
                              title: Text(_book.name),
                              subtitle: Text(_book.author),
                              trailing: Text(
                                  "${_checked.length}/${_book.chapters.toString()}"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChaptersPage(book: _book),
                                      fullscreenDialog: true,
                                    ));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
