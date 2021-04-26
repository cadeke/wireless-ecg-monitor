import 'package:flutter/material.dart';
import 'package:flutter_http/datapoint_model.dart';
import 'package:flutter_http/http_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'data_chart.dart';

final HttpService httpService = HttpService();

class DataPage extends StatelessWidget {
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
                    data: data,
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('Home'),
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            // ignore: deprecated_member_use
            title: Text('Search'),
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            // ignore: deprecated_member_use
            title: Text('Menu'),
            backgroundColor: Colors.red[900],
          )
        ],
      ),
    );
  }
}
