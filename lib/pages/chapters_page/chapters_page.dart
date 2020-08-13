import 'package:bibleplanner/components/alert_component.dart';
import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/models/planner.dart';
import 'package:bibleplanner/stores/bible_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';

class ChaptersPage extends StatefulWidget {
  final Book book;

  const ChaptersPage({Key key, this.book}) : super(key: key);

  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  BibleStore _bibleStore;
  String _bookAbbrev;

  @override
  void initState() {
    _bibleStore = GetIt.instance<BibleStore>();
    _bookAbbrev = widget.book.abbrev.pt;

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
                          'Deseja realmente remover seu progresso de leitura neste livro?'),
                      confirm: () {
                        _bibleStore.clearChecked(bookAbbrev: _bookAbbrev);
                      },
                    );
                  });
            },
          )
        ],
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Observer(
          name: 'CheckList',
          builder: (context) {
            List<int> _checked =
                _bibleStore.currentPlannerBookChapters[_bookAbbrev] ?? [];

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
                                              Colors.green[200],
                                              Colors.green[300]
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
          },
        );
      }),
    );
  }
}
