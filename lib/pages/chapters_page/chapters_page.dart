import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/models/planner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChaptersPage extends StatefulWidget {
  final Book book;

  const ChaptersPage({Key key, this.book}) : super(key: key);

  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  Planner _planner;
  List<int> _checked;

  @override
  void initState() {
    var _box = Hive.box('planners');
    _planner = _box.getAt(0);

    if (_planner.bookChapters[widget.book.abbrev.pt] == null) {
      _planner.bookChapters[widget.book.abbrev.pt] = [];
    }

    _checked = _planner.bookChapters[widget.book.abbrev.pt].cast<int>();

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
      ),
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 5,
          children: List.generate(
            widget.book.chapters,
            (int index) {
              int _chapter = index + 1;
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 5,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            gradient: _checked.indexOf(_chapter) >= 0
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                        Colors.green[200],
                                        Colors.green[300]
                                      ])
                                : LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                        Colors.grey[200],
                                        Colors.grey[300]
                                      ]),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.black12),
                          ),
                          child: Center(
                              child: Column(
                            children: [
                              Checkbox(
                                activeColor: Colors.transparent,
                                checkColor: Colors.black87,
                                value: _checked.indexOf(_chapter) >= 0,
                                onChanged: (value) {
                                  setState(() {
                                    if (_checked.indexOf(_chapter) >= 0) {
                                      _checked.remove(_chapter);
                                    } else {
                                      _checked.add(_chapter);
                                    }
                                  });
                                },
                              ),
                              Text((_chapter).toString()),
                            ],
                          )),
                        ),
                        onTap: () {
                          setState(() {
                            if (_checked.indexOf(_chapter) >= 0) {
                              _checked.remove(_chapter);
                            } else {
                              _checked.add(_chapter);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
