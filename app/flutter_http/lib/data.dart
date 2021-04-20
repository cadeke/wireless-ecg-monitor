import 'package:flutter/material.dart';
import 'package:flutter_http/datapoint_model.dart';
import 'package:flutter_http/http_service.dart';

final HttpService httpService = HttpService();

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datapoints from webserver"),
      ),
      body: FutureBuilder(
        future: httpService.getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<DataPoint>> snapshot) {
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
    );
  }
}
