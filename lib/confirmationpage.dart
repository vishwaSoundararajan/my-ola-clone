import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:myolaapp/scrollscreen.dart';
import 'package:myolaapp/userpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
const LatLng currentLocation=LatLng(13.061140, 80.282480);

class ConfirmationPage extends StatefulWidget {
const ConfirmationPage({super.key});
//    final String cartype;
//    final String price;
//   const  ConfirmationPage ({ Key? key,required this.cartype, required this.price }): super(key: key);
//   @override
  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late GoogleMapController mapController;
  Map<String,Marker>_markers={};

  late String myname="vishwa";
  late String phone="8399282928";
  late String carType="Mini Car";
  late String ridePrice="410.RS";
  late SharedPreferences shared;

  @override
  void initState(){
    print("its from initState");
    super.initState();
    initialGetSaved();

  }


  void initialGetSaved() async{
    shared = await SharedPreferences.getInstance();
    // Read the data, decode it and store it in map structure
    Map<String, dynamic> userMap = jsonDecode(shared.getString('userdata1')!);
    var user = Userdata.fromJson(userMap);
    //For car Details
    // Read the data, decode it and store it in map structure
    Map<String, dynamic> booking = jsonDecode(shared.getString('bookingdata')!);
    var bookingVar = BookingDetails.fromJson(booking);
    setState(() {
      myname = user.name;
      phone=user.phone;
      carType=bookingVar.carType;
      ridePrice=bookingVar.ridePrice;

    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(

          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: currentLocation,
                  zoom: 10,
                ),
                onMapCreated:(controller){
                  mapController=controller;
                  addMarker('test',currentLocation);
                },
                markers:_markers.values.toSet() ,
              ),
              //navigation icon
              Positioned(
                top: 10,
                right: 15,
                left: 15,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children:  <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>const SearchPage()));
                        },
                        icon:const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 25.0,
                            color: Colors.black,
                          ),

                        ),

                      )
                    ],
                  ),
                ),
              ),
              //navigation icon

              DraggableScrollableSheet(

               initialChildSize:0.5,
               minChildSize:0.5,
               builder:(BuildContext context,ScrollController scrollController){
                return Container(color: Colors.white,
                 child: ListView(
                 physics:ClampingScrollPhysics(),
                  controller:scrollController,

    children: [
              Row(
                children: const [
                  Text("Confirm your pickup",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                ],
              ),
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0)
                    ),
                  ],

                ),
                child: Center(
                    child: Text("Name: $myname \nPhoneNo: $phone \nVehicle Type:$carType\nTotal price: $ridePrice",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),)
                ),
              ),
              // Row(
              //   children:  [Text("Vehicle Type: $cartype\nTotal price: $price", style: const TextStyle(fontSize: 25,fontWeight: FontWeight. bold),),],),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Confirmsg())
                    );
                  },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.fromLTRB(80, 0, 80, 0)),
                    child: const Text(
                        "Confirm", style: TextStyle(color: Colors.white,)),),

                  // TextButton(onPressed: () {
                  //   Navigator.of(context).pop(
                  //       MaterialPageRoute(
                  //           builder: (context) => const FourthPage())
                  //   );
                  // },
                  //   style: TextButton.styleFrom(backgroundColor: Colors.black,),
                  //   child: const Text(
                  //       "prev", style: TextStyle(color: Colors.white)),),
                ],
              ),
             ]
                 )

                 );

               }
           ),
            ],
          )

      ),
    );
  }
  void addMarker(String id,LatLng location) async {
    var markerIcon=await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/images/shop.png');
    const ImageConfiguration();
    'assets/images/shop.png';
    var marker=Marker(
      markerId:MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title:'Title of place',
        snippet:'Some description of the place',
      ),
      icon:markerIcon,
    );
    _markers[id]=marker;
    setState((){});
  }
}