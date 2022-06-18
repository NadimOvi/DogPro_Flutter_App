import 'dart:async';
import 'dart:convert';

import 'package:dog_breed/Map/models/nearByLocationModel.dart';
import 'package:dog_breed/Map/models/place.dart';
import 'package:dog_breed/Map/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MapShows extends StatefulWidget {
  MapShows({Key? key}) : super(key: key);

  @override
  _MapShowsState createState() => _MapShowsState();
}


class _MapShowsState extends State<MapShows> {
  final List<Marker> _marker = <Marker>[];
  double? latitude,longitude;
  BitmapDescriptor? mapMarker;
  final placesService = PlacesService();
  final Completer<GoogleMapController> _controller = Completer();

   loadData(){

    getUserCurrentLocation().then((value) async{
      print("My Current Location");
      print(value.latitude.toString() + " "+ value.longitude.toString());
      latitude = value.latitude;
      longitude = value.longitude;
      setCustomMarker();
      getList();
      /*getPlaces();*/


      _marker.add(
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: InfoWindow(
              title: "My location",
            ),
            icon: mapMarker!,
          )
      );

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 18);

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(23.795803, 90.4099442),
      zoom: 8
  );

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print("Error" +error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      loadData();
    });

  }

  void setCustomMarker() async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/images/placeholder.png");
  }


  Future<NearByLocationModel> getList() async{
    final response = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&keyword=pet&sensor=true&key=AIzaSyBMHTFgIc-_X9A3EuFi7CJEiR8YUNJ08bo"),

      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'},);

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      var dataJson = NearByLocationModel.fromJson(data);
      print("Success");
     List<Results>? result = dataJson.results;



     for(int i = 0; i< result!.length; i++){
       _marker.add(
           Marker(
               markerId: MarkerId(i.toString()),

               position: LatLng(result[i].geometry!.location!.lat!.toDouble(), result[i].geometry!.location!.lng!.toDouble()),
               infoWindow: InfoWindow(
                   title: result[i].name,
                 snippet: result[i].vicinity
               )
           )
       );
     }

     print(result.length.toString());
      return dataJson;

    }else{
      throw Exception('Failed to load post');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
        title: Center(
          child: Container(
            child: Text(
              'DogPro',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          ),
        ),
        backgroundColor: Color(0xff233f4b),
      ),
      body: Stack(
        children:[
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_marker),
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
          /*buildListContainer(),*/
        ],
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

          getUserCurrentLocation().then((value) async{
            print(value.latitude.toString() + " "+ value.longitude.toString());
            setCustomMarker();
            getList();
            /*getPlaces();*/

            _marker.add(
              Marker(
                markerId: MarkerId("1"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: "My location"),
                icon: mapMarker!,

              )
            );

            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),zoom: 16);

            final GoogleMapController controller = await _controller.future;

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });

          });

        },
        icon: Icon(Icons.location_history),
        label: Text("Select your location"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }

  Widget buildListContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150,
       /* child: ListView,*/
      ),
    );
  }
}




