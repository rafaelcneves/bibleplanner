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
  List<bool> expanded = [true, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner de leitura da Bíblia'),
        centerTitle: true,
        actions: [_clearButton(context)],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchBooks(),
          builder: (context, AsyncSnapshot<List<Book>> snapshot) {
            List<Book> _books = snapshot.data ?? List.empty();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    expanded[index] = !expanded[index];
                  });
                },
                children: [
                  _inProgressPanel(_books),
                  _completedPanel(_books),
                  _allBooksPanel(_books),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ExpansionPanel _allBooksPanel(List<Book> _books) {
    return ExpansionPanel(
      backgroundColor: Colors.grey[50],
      isExpanded: expanded[2],
      canTapOnHeader: true,
      headerBuilder: (_, __) {
        return ListTile(title: Text("Todos os livros"));
      },
      body: Column(
        children: [
          Text("teste"),
          _allBooks(_books),
        ],
      ),
    );
  }

  ExpansionPanel _completedPanel(List<Book> _books) {
    return ExpansionPanel(
      backgroundColor: Colors.grey[50],
      isExpanded: expanded[1],
      canTapOnHeader: true,
      headerBuilder: (_, __) {
        return ListTile(title: Text("Finalizado"));
      },
      body: Consumer<BibleReadProgressStore>(
        builder: (context, _bibleStore, child) {
          List<Book> _completed = _books.where((book) {
            return _bibleStore.getBookReadProgress(book) == 1;
          }).toList();

          return (_completed.length == 0)
              ? _emptyPanel(
                  "Finalize uma leitura para mostrar \nseu progresso aqui.")
              : _allBooks(_completed);
        },
      ),
    );
  }

  ExpansionPanel _inProgressPanel(List<Book> _books) {
    return ExpansionPanel(
      backgroundColor: Colors.grey[50],
      isExpanded: expanded[0],
      canTapOnHeader: true,
      headerBuilder: (_, __) {
        return ListTile(title: Text("Em andamento"));
      },
      body: Consumer<BibleReadProgressStore>(
        builder: (context, _bibleStore, child) {
          List<Book> _inProgress = _books.where((book) {
            return _bibleStore.getBookReadProgress(book) > 0 &&
                _bibleStore.getBookReadProgress(book) < 1;
          }).toList();

          return (_inProgress.length == 0)
              ? _emptyPanel(
                  "Inicie uma leitura para mostrar \nseu progresso aqui.")
              : _allBooks(_inProgress);
        },
      ),
    );
  }

  Padding _emptyPanel(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Opacity(
        opacity: .7,
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  Widget _allBooks(List<Book> _books) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ChaptersPage(book: _book),
                  fullscreenDialog: true,
                ));
          },
          child: Card(
            margin: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<BibleReadProgressStore>(
                    builder: (context, _bibleStore, child) {
                      Map<String, List<int>> _bookChapters =
                          _bibleStore.readProgressChapters;
                      List<int> _checked = _bookChapters[_book.abbrev.pt] ?? [];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _book.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 18),
                          ),
                          Text("${_checked.length}/${_book.chapters}"),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<BibleReadProgressStore>(
                  builder: (context, _bibleStore, child) {
                    Map<String, List<int>> _bookChapters =
                        _bibleStore.readProgressChapters;
                    List<int> _checked = _bookChapters[_book.abbrev.pt] ?? [];
                    return Opacity(
                      opacity: 0.5,
                      child: LinearProgressIndicator(
                        value: _checked.length / _book.chapters,
                        backgroundColor: Colors.white,
                        color: Colors.green,
                        minHeight: 10,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
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
