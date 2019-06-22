import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';

class MapsHost extends StatefulWidget {
  @override
  State createState() => MapsHostState();
}

class MapsHostState extends State<MapsHost> {

  final databaseReference = FirebaseDatabase.instance.reference();

  GoogleMapController mapController;

  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubcription;

  Location location = new Location();
  String error;

  void UpdateDatabase(){
    databaseReference.set({
      'latitud': currentLocation['latitud'],
      'longitud': currentLocation['longitud'],
    });
  }

  @override
  void initState(){
    super.initState();
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    locationSubcription = location.onLocationChanged().listen((Map<String, double> result){
      setState(() {
        currentLocation = result;
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(currentLocation['latitude'], currentLocation['longitude']), zoom: 17),
          ),
        );
        mapController.addMarker(
          MarkerOptions(
            position: LatLng(currentLocation['latitude'], currentLocation['longitude']),
          ),
        );
      });
      UpdateDatabase();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Host')),
        body: Builder(
            builder: (context) =>
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          height: 350.0,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(target: LatLng(currentLocation['latitude'], currentLocation['longitude']),
                                zoom: 17),
                            onMapCreated: _onMapCreated,
                          ),
                        ),
                      ),
                      Container(
                        child: Text('Lat/Lng: ${currentLocation['latitude']}/${currentLocation['longitude']}'),
                      ),
                    ],
                  ),
                )
        )
    );
  }
}