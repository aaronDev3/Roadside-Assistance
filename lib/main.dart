import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'menu_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'Tabang byahero'),
    );
  }
}

class Home extends StatefulWidget {
  @override
  Home({Key key, this.title}) : super(key: key);
  final String title;

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng initialPosition = LatLng(8.5380, 124.7889); //(latitude,longitude)
  GoogleMapController controller;
  Location location = Location();

  void _onMapCreated(GoogleMapController myController) {
    controller = myController;
    location.onLocationChanged().listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 18.5),
        ),
      );
    });
  }

  final String img = "";
  final String autoshopName = "";
  final String contactNo = "";

  void showInfo(img, autoshopName, contactNo) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DefaultTabController(
          length: 1,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: [
                    Image(
                      image: AssetImage(img),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.8,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      width: 152,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.blue,
                            ),
                            Text(
                              contactNo,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5, top: 5),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: Text(
                                "X",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8, left: 20, right: 15, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        autoshopName,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '4.3 ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  //height: 350,
                  child: TabBarView(children: <Widget>[
                    Container(
                      child: ListView(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text('Change tire'),
                              trailing: Text('P200'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Battery Boosting"),
                              trailing: Text('P300'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Vulcanizing"),
                              trailing: Text('P100'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Repainting"),
                              trailing: Text('P1000'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Engine Repair"),
                              trailing: Text('P500'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Underchassis repair"),
                              trailing: Text('P600'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Body Repair"),
                              trailing: Text('P500'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Clutch lining"),
                              trailing: Text('P1500'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("Overhaul"),
                              trailing: Text('P3000'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print(user.email);
    });
  }

  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Marker autoshopMarker1 = Marker(
      markerId: MarkerId('Marker1'),
      position: LatLng(8.535276, 124.803741),
      infoWindow: InfoWindow(title: 'ATS automotive'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      onTap: () => showInfo(
          "assets/autoshop_pic/autoshop1.jpg", "ATS automotive", "09363945671"),
    );

    Marker autoshopMarker2 = Marker(
      markerId: MarkerId('Marker2'),
      position: LatLng(8.535770, 124.802350),
      infoWindow: InfoWindow(title: 'Blade shop'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      onTap: () => showInfo(
          "assets/autoshop_pic/autoshop2.jpg", "Blade autoshop", "09363945316"),
    );

    Marker autoshopMarker3 = Marker(
      markerId: MarkerId('Marker3'),
      position: LatLng(8.535544, 124.802972),
      infoWindow: InfoWindow(title: 'Rapide'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      onTap: () => showInfo(
          "assets/autoshop_pic/autoshop3.jpg", "Rapide", "09263581715"),
    );

    Marker autoshopMarker4 = Marker(
      markerId: MarkerId('Marker4'),
      position: LatLng(8.537291, 124.796880),
      infoWindow: InfoWindow(title: 'KarrJackson'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      onTap: () => showInfo(
          "assets/autoshop_pic/autoshop4.jpg", "KarrJackson", "09363581215"),
    );

    Marker autoshopMarker5 = Marker(
      markerId: MarkerId('Marker5'),
      position: LatLng(8.536936, 124.799004),
      infoWindow: InfoWindow(title: 'Shanicus Autoshop'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      onTap: () => showInfo(
          "assets/autoshop_pic/autoshop5.jpg", "Shanicus", "09362481318"),
    );
    return Scaffold(
      drawer: MenuDrawer(user.email),
      appBar: AppBar(
        title: Text("Tabang Byahero"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 18.5,
          ),
          mapType: MapType.hybrid,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          markers: {
            autoshopMarker1,
            autoshopMarker2,
            autoshopMarker3,
            autoshopMarker4,
            autoshopMarker5
          },
        ),
      ),
    );
  }
}
