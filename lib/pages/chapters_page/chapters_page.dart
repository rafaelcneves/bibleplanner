import 'package:bibleplanner/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChaptersPage extends StatelessWidget {
  final Book book;

  const ChaptersPage({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: ThemeData.light().iconTheme,
        textTheme: ThemeData.light().textTheme,
        title: Text(
          book.name,
          style: TextStyle(color: Colors.black87, fontFamily: 'Google'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(
            book.chapters,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 4,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(width: 1, color: Colors.black12),
                              color: Colors.grey[100]),
                          child: Center(child: Text((index + 1).toString())),
                        ),
                        onTap: () {},
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
