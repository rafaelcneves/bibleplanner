import 'package:bibleplanner/models/planner.dart';
import 'package:bibleplanner/stores/bible_read_progress_store.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Planner>(PlannerAdapter());
  var box = await Hive.openBox<Planner>('planners');

  if (!box.containsKey(0)) {
    Planner planner = Planner(
      name: 'Primeiro',
      bookChapters: {},
    );

    box.add(planner);
  }

  runApp(ChangeNotifierProvider(
      create: (_) => BibleReadProgressStore(), child: MyApp()));
}
