import 'package:bibleplanner/components/alert_component.dart';
import 'package:bibleplanner/models/book.dart';
import 'package:bibleplanner/pages/chapters_page/chapters_page.dart';
import 'package:bibleplanner/stores/bible_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_admob/firebase_admob.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BibleStore _bibleStore;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // nonPersonalizedAds: true,
    keywords: ['Bible', 'Checklist', 'Productivity'],
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-8689692734643401/2750324877',
      // adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();

    _bibleStore = GetIt.instance<BibleStore>();
    _bibleStore.setCurrentPlanner();

    if (_bibleStore.books == null) {
      _bibleStore.loadBooks();
    }
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner de leitura da Bíblia'),
        centerTitle: true,
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
                          'Deseja realmente remover todo seu progresso de leitura?'),
                      confirm: () {
                        _bibleStore.clearChecked();
                      },
                    );
                  });
            },
          )
        ],
      ),
      body: Observer(
        name: 'BooksList',
        builder: (context) {
          List<Book> _books = _bibleStore.books;
          Map<String, List<int>> _bookChapters =
              _bibleStore.currentPlannerBookChapters;
          double paddingBottom =
              _bannerAd != null ? _bannerAd.size.height.toDouble() : 0.0;

          return (_books != null)
              ? AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: paddingBottom),
                    itemCount: _bibleStore.books.length,
                    itemBuilder: (context, index) {
                      Book _book = _books[index];
                      List<int> _checked = _bookChapters[_book.abbrev.pt] ?? [];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.black12),
                              ),
                            ),
                            child: ListTile(
                              title: Text(_book.name),
                              subtitle: Text(_book.author),
                              trailing: Text(
                                  "${_checked.length}/${_book.chapters.toString()}"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChaptersPage(book: _book),
                                      fullscreenDialog: true,
                                    ));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
