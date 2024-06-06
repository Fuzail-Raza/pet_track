

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pet_track/colorsScheme.dart';

class locationTrack extends StatefulWidget {
  final String email,petEmail;
  locationTrack({super.key,required this.email,required this.petEmail});

  @override
  State<locationTrack> createState() => _locationTrackState();
}

class _locationTrackState extends State<locationTrack> {

  // String email="fuzailraza161@gmail.com",petEmail="fr9g6smvt642";

  bool showSpinner=false;

  Location _locationController = Location();
  LatLng? _current;

  @override
  void initState() {
    // TODO: implement initState

    getLocationUpdates();
    super.initState();
  }
  // Todo Solve Network Exception

    Future<dynamic> saveLocation(email,petEmail,userData) async {
      try {
        var db = FirebaseFirestore.instance;

        await db
            .collection(email)
            .doc(petEmail)
            .set(userData, SetOptions(merge: true))
            .then((value) => print("Written Successfully"))
            .onError((error, stackTrace) {
                  print("Error writing document: $error");
                  setState(() {
                    showSpinner=false;
                  });
            });

        return true;
      } on FirebaseException catch (ex) {
        print("Error : ${ex.code.toString()}");
        return ex.code.toString();
      }
    }



  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGuranted;

    _serviceEnabled = await _locationController.serviceEnabled();

    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGuranted = await _locationController.hasPermission();

    if (_permissionGuranted == PermissionStatus.denied) {

      _permissionGuranted = await _locationController.requestPermission();
      if (_permissionGuranted != PermissionStatus.granted) {
        return;
      }
      else {
        _locationController.onLocationChanged
            .listen((LocationData currentLocation) {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null) {
            setState(() {
              _current = LatLng(currentLocation.latitude!, currentLocation.longitude!);
              showSpinner=true;
              dynamic response= saveLocation(widget.email,widget.petEmail,{
                "LAT":_current!.latitude,
                "LONG":_current!.longitude

              });
              showSpinner=true;
              print("Location : $_current");
            });
          }
        });
      }
    }
    else {
      _locationController.onLocationChanged
          .listen((LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            _current = LatLng(currentLocation.latitude!, currentLocation.longitude!);
            if(saveLocation(widget.email,widget.petEmail,{
              "LAT":_current!.latitude,
              "LONG":_current!.longitude

            })==true){
              print("Location Saved");
            }
            else{
              print("Location Not Saved");
            }
            // pos=LatLng(pos.latitude  +  0.0000052, pos.longitude +  0.000058) ;
            showSpinner=true;
            print("Location : $_current");
          });
        }
      });
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Location Tracker"),
        centerTitle: true,
        // backgroundColor: appBackgroundColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: appBackgroundColor
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: BackgroundColor,
          gradient: BackgroundColor
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height/7,
              width: MediaQuery.of(context).size.height/2,
              // margin: EdgeInsets.all(100),
                decoration: BoxDecoration(
                    color: listBackgroundColor,
                    // gradient: appBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: showSpinner == true ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Location :-",style:TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w500,
                        color: LocationTextColor
                      ) ,),
                      Text("      ${_current!.latitude} , ${_current!.longitude}",style:TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w500,
                        color: LocationTextColor
                      ) ,),
                    ],
                  ) : InkWell(
                    onTap: () => getLocationUpdates(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Location Not Accessible",style: TextStyle(
                          fontSize: 18
                        ),),
                        Text("Click to get Location",style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline
                        ),),
                      ],
                    ),
                  ),
                )),

            ),
          ),
        ),
      ),
    );
  }
}
