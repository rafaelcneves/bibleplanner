import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
