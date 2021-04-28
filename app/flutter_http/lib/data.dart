import 'package:flutter/material.dart';
import 'package:flutter_http/datapoint_model.dart';
import 'package:flutter_http/http_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'data_chart.dart';

final HttpService httpService = HttpService();

final ThemeData themeData = ThemeData(
  canvasColor: Colors.red[100],
);

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

class DataPage extends StatefulWidget {
  DataPage({Key key}) : super(key: key);

  @override
  DataPageState createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  String currentPage;
  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    DataPage(),
    MySearchPage(),
    MyMenuPage(),
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
      body: Column(
        children: [
          _children[_currentIndex],
          FutureBuilder(
            future: httpService.getData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DataPoint>> snapshot) {
              if (snapshot.hasData) {
                List<DataPoint> posts = snapshot.data;
                return ListView(
                  children: posts
                      .map(
                        (DataPoint dp) => ListTile(
                          title: Text("DataPoint"),
                          subtitle: Text("TS:" +
                              dp.timestamp.toString() +
                              " V: " +
                              dp.voltage.toString()),
                        ),
                      )
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
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

class MySearchPage extends StatefulWidget {
  MySearchPage({Key key}) : super(key: key);
  @override
  _MySearchPageState createState() => new _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  String currentPage;
  int _currentIndex = 1;
  final List<Widget> _children = <Widget>[
    DataPage(),
    MySearchPage(),
    MyMenuPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name'),
      ),
      body: Column(
        children: [
          _children[_currentIndex],
          FutureBuilder(
            future: httpService.getData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DataPoint>> snapshot) {
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
        ],
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

class MyMenuPage extends StatefulWidget {
  MyMenuPage({Key key}) : super(key: key);
  @override
  _MyMenuPageState createState() => new _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  String currentPage;
  int _currentIndex = 2;
  final List<Widget> _children = <Widget>[
    DataPage(),
    MySearchPage(),
    MyMenuPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {}); //Re-Render the page
  }

  Widget Record() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Name'),
      ),
      body: Column(
        children: [
          _children[_currentIndex],
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(formatTime(_stopwatch.elapsedMilliseconds),
                          style: TextStyle(fontSize: 48.0)),
                      ElevatedButton(
                          onPressed: handleStartStop,
                          child: Text(_stopwatch.isRunning ? 'Stop' : 'Start')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
