import 'package:flutter/material.dart';
import 'package:flutter_app/Rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PumaKatari',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String ruta;
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(color: Colors.brown),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Rutas",style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.yellow,
                ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    child: Text(
                      "Inca Llojeta",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      ruta="Inca Llojeta";
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ruta(ruta: ruta)),
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    child: Text(
                      "Villa Salome",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      ruta="Villa Salome";
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ruta(ruta: ruta)),
                      );
                    }
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    color: Colors.orange,
                    child: Text(
                      "Chasquipampa",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      ruta="Chasquipampa";
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Ruta(ruta: ruta)),
                      );
                   }
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    child: Text(
                      "Caja Ferroviaria",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      ruta="Caja Ferroviaria";
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ruta(ruta: ruta)),
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                    child: Text(
                      "Integradora",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      ruta="Integradora";
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ruta(ruta: ruta)),
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                    color: Colors.lightBlueAccent,
                    child: Text(
                      "Irpavi II",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      ruta="Irpavi II";
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ruta(ruta: ruta)),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Image.asset("assets/LaPazBusLogo.png", height: 50.0),
        actions: <Widget>[
          InkWell(
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseUser()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0
              ),
              child: Icon(Icons.map),
            ),
          ),
        ],
      ),
    );
  }
}
class ChooseUser extends StatefulWidget {
  @override
  _ChooseUserState createState() => _ChooseUserState();
}
class _ChooseUserState extends State<ChooseUser> {
  GoogleMapController mapController;

  void onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("La Paz"),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(-16.5149723, -68.1257616),
                  zoom: 10
              ),
              onMapCreated: onMapCreated,
              myLocationEnabled: true,
              mapType: MapType.normal,
              compassEnabled: true,
              trackCameraPosition: true,
            ),
          ],
        )
    );
  }
}