import 'package:flutter/material.dart';
import 'package:flutter_http/datapoint_model.dart';
import 'package:flutter_http/http_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'data_chart.dart';

final HttpService httpService = HttpService();

class DataPage extends StatefulWidget {
  DataPage({Key key}) : super(key: key);

  @override
  DataPageState createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  String currentPage;
  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    Home(),
    Search(),
    Menu(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: Text('Wireless ECG Monitor'),
      ),
      body: FutureBuilder(
        future: httpService.getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<DataPoint>> snapshot) {
          if (snapshot.hasData) {
            List<DataPoint> posts = snapshot.data;
            return ListView(
              children: <Widget>[
                Container(
                  child: DataChart(
                    data: posts,
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.menu),
            label: 'Menu',
            backgroundColor: Colors.red[900],
          )
        ],
      ),
    );
  }
}
