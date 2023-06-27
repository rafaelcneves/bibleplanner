import 'package:flutter/material.dart';

import 'pages/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planner de leitura da Bíblia',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.grey[100],
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontFamily: 'Google',
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
