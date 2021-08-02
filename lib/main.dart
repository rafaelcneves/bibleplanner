import 'package:bibleplanner/models/planner.dart';
import 'package:bibleplanner/pages/home_page/home_page.dart';
import 'package:bibleplanner/stores/bible_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Planner>(PlannerAdapter());
  var box = await Hive.openBox('planners');

  if (!box.containsKey(0)) {
    Planner planner = Planner(
      name: 'Primeiro',
      bookChapters: {},
    );

    box.add(planner);
  }

  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<BibleStore>(BibleStore());
  runApp(MyApp());
}

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
