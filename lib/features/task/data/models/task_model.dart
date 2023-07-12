import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:taks_3mc/core/constants/images.dart';
import 'package:taks_3mc/core/constants/localized.dart';

class TaskModel {
  final String id;
  final int type;
  final String location;
  final DateTime date;
  final String description;
  final double latitude;
  final double longitude;
  final int numberPlants;
  final int areacoverage;

  TaskModel({
    required this.id,
    required this.type,
    required this.location,
    required this.date,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.numberPlants,
    required this.areacoverage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'location': location,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'numberPlants': numberPlants,
      'areacoverage': areacoverage,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      type: map['type'] as int,
      location: map['location'] as String,
      date: (map['date'] as Timestamp).toDate(),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      description: map['description'] as String,
      numberPlants: map['numberPlants'] as int,
      areacoverage: map['areacoverage'] as int,
    );
  }

  TaskModel copyWith({
    String? id,
    int? type,
    String? location,
    DateTime? date,
    double? latitude,
    double? longitude,
    String? description,
    int? numberPlants,
    int? areacoverage,
  }) {
    return TaskModel(
      id: id ?? this.id,
      type: type ?? this.type,
      location: location ?? this.location,
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
      numberPlants: numberPlants ?? this.numberPlants,
      areacoverage: areacoverage ?? this.areacoverage,
    );
  }

  String getNameFromType(BuildContext context) {
    switch (type) {
      case 1:
        return localized(context).rackingLeaves;
      case 2:
        return localized(context).trimming;
      case 3:
        return localized(context).wateringPlants;
      default:
        return "";
    }
  }

  String getImageFromType() {
    switch (type) {
      case 1:
        return rackingImage;
      case 2:
        return trimmingImage;
      case 3:
        return wateringImage;
      default:
        return "";
    }
  }
}
