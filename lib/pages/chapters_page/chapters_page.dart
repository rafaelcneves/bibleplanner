import 'package:flutter/material.dart';

class ChaptersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: ThemeData.light().iconTheme,
        textTheme: ThemeData.light().textTheme,
        title: Text(
          'Capitulos',
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
    );
  }
}
