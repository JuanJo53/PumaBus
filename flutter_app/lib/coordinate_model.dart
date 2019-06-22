import 'package:firebase_database/firebase_database.dart';

class CoordinatesModel {
  double latitude;
  double longitude;

  CoordinatesModel(this.latitude, this.longitude);

  CoordinatesModel.map(dynamic obj) {
    this.latitude = obj['latitude'];
    this.longitude = obj['longitude'];
  }

  double get currentLatitude => latitude;
  double get currentLongitude => longitude;

  CoordinatesModel.fromSnapshot(DataSnapshot snapshot) {
    latitude = snapshot.value['latitude'];
    longitude = snapshot.value['longitude'];
  }
}