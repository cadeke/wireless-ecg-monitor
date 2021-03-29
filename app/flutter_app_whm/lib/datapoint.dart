class Datapoint {
  double time;
  double voltage;

  Datapoint(this.time, this.voltage);

  factory Datapoint.fromJson(dynamic json) {
    return Datapoint(json['time'] as double, json['voltage'] as double);
  }

  @override
  String toString() {
    return '{ ${this.time}, ${this.voltage} }';
  }

  toList() {}
}
