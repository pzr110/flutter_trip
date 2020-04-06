import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> cityNames = [
    '北京',
    '上海',
    '广州',
    '深圳',
    '杭州',
    '苏州',
    '成都',
    '武汉',
    '郑州',
    '洛阳',
    '厦门',
    '青岛',
    '拉萨'
  ];
  final String title = "下拉刷新";

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView(
              controller: _scrollController,
              children: _buildList(),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }
}

//class MyApp extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    final title = '下拉刷新';
//    Future<Null> _handleRefresh() async {
//      await Future.delayed(Duration(seconds: 2));
//      setS
//    }
//
//    return MaterialApp(
//      title: title,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: Container(
//            child: RefreshIndicator(
//                child: ListView(
//                  children: _buildList(),
//                ),
//                onRefresh: _handleRefresh())),
//      ),
//    );
//  }
//
//  List<Widget> _buildList() {
//    return cityNames.map((city) => _item(city)).toList();
//  }
//
//  Widget _item(String city) {
//    return ExpansionTile(
//      title: Text(
//        city,
//        style: TextStyle(color: Colors.black54, fontSize: 20),
//      ),
//      children: subCities.map((subCity) => _buildSub(subCity)).toList(),
//    );
//  }
//
//  Widget _buildSub(String subCity) {
//    return FractionallySizedBox(
//        widthFactor: 1,
//        child: Container(
//          height: 50,
//          margin: EdgeInsets.only(bottom: 5),
//          decoration: BoxDecoration(color: Colors.lightBlueAccent),
//          child: Text(subCity),
//        ));
//  }
//}
