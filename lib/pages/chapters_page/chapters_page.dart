import 'package:bibleplanner/components/alert_component.dart';
import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/stores/bible_read_progress_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ChaptersPage extends StatefulWidget {
  final Book book;

  const ChaptersPage({required this.book});

  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  late String _bookAbbrev;

  @override
  void initState() {
    _bookAbbrev = widget.book.abbrev.pt ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [_clearButton(context)],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Consumer<BibleReadProgressStore>(
              builder: (context, _bibleStore, child) {
            List<int> _checked =
                _bibleStore.readProgressChapters[_bookAbbrev] ?? [];

            return AnimationLimiter(
              child: GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 5 : 10,
                children: List.generate(
                  widget.book.chapters,
                  (int index) {
                    int _chapter = index + 1;

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 150),
                      columnCount: orientation == Orientation.portrait ? 5 : 10,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: _checked.indexOf(_chapter) >= 0
                                      ? LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                              Colors.greenAccent,
                                              Colors.lightGreenAccent,
                                            ])
                                      : null,
                                ),
                                child: Center(
                                  child: Text((_chapter).toString()),
                                ),
                              ),
                              onTap: () {
                                _bibleStore.toggleChecked(
                                    bookAbbrev: _bookAbbrev, chapter: _chapter);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          });
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
                      'Deseja realmente remover seu progresso de leitura neste livro?'),
                  confirm: () {
                    _bibleStore.clearChecked(bookAbbrev: _bookAbbrev);
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
