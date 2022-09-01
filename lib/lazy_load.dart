import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LazyLoad extends StatefulWidget {
  const LazyLoad({Key? key}) : super(key: key);

  @override
  State<LazyLoad> createState() => _LazyLoadState();
}

class _LazyLoadState extends State<LazyLoad> {
  late List dummyList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    dummyList = List.generate(10, (index) => "Item: ${index + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() {
    print("Get more list");
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      dummyList.add("Item:${i + 1}");
    }
    _currentMax = _currentMax + 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 80,
        itemBuilder: (context, index) {
          if (index == dummyList.length) {
            return CupertinoActivityIndicator();
          }
          return ListTile(
            title: Text(dummyList[index]),
          );
        },
        itemCount: dummyList.length + 1,
      ),
    );
  }
}
