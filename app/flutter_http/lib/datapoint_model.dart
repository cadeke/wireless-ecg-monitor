import 'dart:ffi';
import 'package:flutter/cupertino.dart';

class DataPoint {
  final String measurement;
  final String field1;
  final String field2;
  final double voltage;
  final int timestamp;

  DataPoint({
    @required this.measurement,
    @required this.field1,
    @required this.field2,
    @required this.voltage,
    @required this.timestamp,
  });

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      measurement: json['_measurement_timestamp'] as String,
      field1: json['_field_timestamp'] as String,
      field2: json['_field_voltage'] as String,
      voltage: json['_value_voltage'] as double,
      timestamp: json['_value_timestamp'] as int,
    );
  }
}
