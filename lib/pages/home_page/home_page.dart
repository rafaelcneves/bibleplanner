import 'package:bibleplanner/components/alert_component.dart';
import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/pages/chapters_page/chapters_page.dart';
import 'package:bibleplanner/stores/bible_read_progress_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner de leitura da Bíblia'),
        centerTitle: true,
        actions: [_clearButton(context)],
      ),
      body: FutureBuilder(
        future: fetchBooks(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          List<Book>? _books = snapshot.data ?? List.empty();

          return Consumer<BibleReadProgressStore>(
            builder: (context, _bibleStore, child) {
              Map<String, List<int>> _bookChapters =
                  _bibleStore.readProgressChapters;

              return GridView.builder(
                itemCount: _books.length,
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  Book _book = _books[index];
                  List<int> _checked = _bookChapters[_book.abbrev.pt] ?? [];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ChaptersPage(book: _book),
                          fullscreenDialog: true,
                        )),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _book.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontSize: 18),
                            ),
                            Text(
                                "${_checked.length}/${_book.chapters.toString()}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  IconButton _clearButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.clear_all),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Consumer<BibleReadProgressStore>(
              builder: (context, _bibleStore, child) {
                return AlertComponent(
                  title: Text('Alerta'),
                  content: Text(
                      'Deseja realmente remover todo seu progresso de leitura?'),
                  confirm: () {
                    _bibleStore.clearChecked();
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
