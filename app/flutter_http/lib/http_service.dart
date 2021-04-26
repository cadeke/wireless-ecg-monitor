import 'dart:convert';
import 'package:http/http.dart';
import 'datapoint_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

class HttpService {
  final String serverURL = "http://10.0.2.2:3000/data/short";
  final String postsUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<DataPoint>> getData() async {
    Response res = await get(Uri.parse(serverURL));
    print(serverURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<DataPoint> data =
          body.map((dynamic item) => DataPoint.fromJson(item)).toList();

      data.toString();
      return data;
    } else {
      throw "Error: cannot get data!";
    }
  }
}

class Convert {
  final List<DataPoint> data;
  final double time;
  final double voltage;
  final charts.Color lineColor;

  Convert({this.data, this.time, this.voltage, this.lineColor});

  factory Convert.fromList(Map<DataPoint, VoltageSeries>){
    return Convert(); 
  }
}
