import 'package:flutter/material.dart';
import 'package:umbrella/DrawerScreens/News/NewsWidgets/widgets.dart';
import 'package:umbrella/DrawerScreens/News/NewsWidgets/news.dart';

///News uses the NewsAPI to give updates on weather: Source - "https://newsapi.org"
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool _loading;
  var newslist;

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Umbrella",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          Container(
            child: Icon(Icons.drag_handle),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        /// News Article
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: ListView.builder(
                              itemCount: newslist.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return NewsTile(
                                  imgUrl: newslist[index].urlToImage ?? "",
                                  title: newslist[index].title ?? "",
                                  desc: newslist[index].description ?? "",
                                  content: newslist[index].content ?? "",
                                  posturl: newslist[index].articleUrl ?? "",
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
