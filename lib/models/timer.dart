import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TimerData {
  final String id;
  String name;
  Duration duration;
  Color color;
  int orderIndex;

  TimerData({
    required this.id,
    required this.name,
    required this.duration,
    required this.color,
    required this.orderIndex,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'durationInSeconds': duration.inSeconds,
    'colorValue': color.toARGB32(),
    'orderIndex': orderIndex,
  };

  factory TimerData.fromJson(Map<String, dynamic> json) => TimerData(
    id: json['id'],
    name: json['name'],
    duration: Duration(seconds: json['durationInSeconds']),
    color: Color(json['colorValue']),
    orderIndex: json['orderIndex'],
  );

  factory TimerData.create({
    required String name,
    required Duration duration,
    required Color color,
  }) => TimerData(
    id: const Uuid().v4(),
    name: name,
    duration: duration,
    color: color,
    orderIndex: 0,
  );
}
