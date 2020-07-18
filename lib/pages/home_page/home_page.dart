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

    if (_bibleStore.books == null) {
      _bibleStore.loadBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: ThemeData.light().iconTheme,
        textTheme: ThemeData.light().textTheme,
        title: Text(
          'Planner de leitura da Bíblia',
          style: TextStyle(color: Colors.black87, fontFamily: 'Google'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      backgroundColor: Colors.white,
      body: Observer(
        name: 'BooksList',
        builder: (context) {
          List<Book> _books = _bibleStore.books;

          return (_books != null)
              ? AnimationLimiter(
                  child: ListView.builder(
                    itemCount: _bibleStore.books.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: ListTile(
                          title: Text(_books[index].name),
                          subtitle: Text(_books[index].author),
                          trailing: Text(_books[index].chapters.toString()),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChaptersPage(),
                                  fullscreenDialog: true,
                                ));
                          },
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