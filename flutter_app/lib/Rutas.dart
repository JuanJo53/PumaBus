import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class Ruta extends StatefulWidget {
  final String ruta;
  Ruta({Key key,this.ruta}):super(key: key);

  @override
  _RutaState createState() => _RutaState();
}

class _RutaState extends State<Ruta> {
  GoogleMapController mapController;
  String rutaSelec;
  bool mapToggle = false;
  bool sitiosToggle = false;
  bool resetToggle = false;
  double initLat, initLong;

  var sitios = [];

  var buses = [];

  var sitiosActual;

  var currentBearing;

  static double currentLatitude = 0.0;
  static double currentLongitude = 0.0;

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState(){
    super.initState();
    setState(() {
      mapToggle = true;
      poblarSitios();
    });
  }

  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      currentLatitude = snapshot.value["Latitud_GPS_1"];
      currentLongitude = snapshot.value["Longitud_GPS_1"];
    });
    print("Data: $currentLongitude $currentLatitude");
  }
  poblarSitios(){
    //getData();
    sitios = [];
    Firestore.instance.collection("${widget.ruta}").getDocuments().then((markers){
      if(markers.documents.isNotEmpty){
        setState(() {
          sitiosToggle = true;
        });
        for(int i=0;i<markers.documents.length;++i){
          sitios.add(markers.documents[i].data);
          initMarker(markers.documents[i].data);
        }
      }
    });
  }

  initMarker(sitio){
    mapController.clearMarkers().then((val){
      mapController.addMarker(MarkerOptions(
          position:
          LatLng(sitio['coord'].latitude, sitio['coord'].longitude),
          draggable: false,
          infoWindowText: InfoWindowText(sitio['nombreSitio'], 'Parada')
      ));
    });
  }

  Widget siteCard(sitio){
    return Padding(
      padding: EdgeInsets.only(left: 2.0, top: 10.0 ),
      child: InkWell(
        onTap: (){
          setState(() {
            sitiosActual = sitio;
            currentBearing = 50.0;
          });
          zoomInMarker(sitio);
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            height: 150.0,
            width: 125.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.blueGrey
            ),
            child: Center(child: Text(sitio['nombreSitio']),),
          ),
        ),
      ),
    );
  }

  zoomInMarker(sitio){
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(sitio['coord'].latitude, sitio['coord'].longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0))).then((val){
      setState(() {
        resetToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    rutaSelec=widget.ruta;
    if(rutaSelec=="Inca Llojeta"){
      initLat=-16.5149723;
      initLong=-68.1257616;
    }
    if(rutaSelec=="Villa Salome"){
        initLat=-16.4950627;
        initLong=-68.1117581;
    }
    if(rutaSelec=="Chasquipampa"){
      initLat=-16.5231954;
      initLong=-68.1015828;
    }
    if(rutaSelec=="Caja Ferroviaria"){
      initLat=-16.4676322;
      initLong=-68.1502004;
    }
    if(rutaSelec=="Integradora"){
      initLat=-16.4828866;
      initLong=-68.1229575;
    }
    if(rutaSelec=="Irpavi II"){
      initLat=-16.5125981;
      initLong=-68.1056616;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(rutaSelec),
        ),
        body: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height - 80.0,
                width: double.infinity,
                child: mapToggle
                    ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(initLat, initLong),
                      zoom: 14
                  ),
                  onMapCreated: onMapCreated,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  compassEnabled: true,
                  trackCameraPosition: true,
                )
                    : Center(
                    child: Text(
                      'Revisa Conexion a Internet y que el GPS este activado',
                      style: TextStyle(fontSize: 20.0),
                    )
                )
            ),
            Positioned(
                top: MediaQuery.of(context).size.height - 150.0,
                left: 10.0,
                child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: sitiosToggle
                        ? ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8.0),
                      children: sitios.map((element) {
                        return siteCard(element);
                      }).toList(),
                    )
                        : Container(height: 1.0, width: 1.0)
                )
            ),
          ],
        )
    );
  }
  void onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }
}
