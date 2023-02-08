import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:myolaapp/scrollscreen.dart';
import 'package:myolaapp/userpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'finalPage.dart';
import 'main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
const LatLng currentLocation=LatLng(13.061140, 80.282480);

class RideConfirmationPage extends StatefulWidget {
  const RideConfirmationPage({super.key});
//    final String cartype;
//    final String price;
//   const  ConfirmationPage ({ Key? key,required this.cartype, required this.price }): super(key: key);
//   @override
  @override
  _RideConfirmationPageState createState() => _RideConfirmationPageState();
}

class _RideConfirmationPageState extends State<RideConfirmationPage> {
  late GoogleMapController mapController;
  Map<String,Marker>_markers={};

  late String myname;
  late String phone;
  late String carType;
  late String ridePrice;
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

                  initialChildSize:0.25,
                  maxChildSize:0.25,
                  builder:(BuildContext context,ScrollController scrollController){
                    return Container(color: Colors.white,
                        child: ListView(
                            physics:ClampingScrollPhysics(),
                            controller:scrollController,

                            children: [
                       //added
                        Container(
                       // padding: EdgeInsets.fromLTRB(10,0,10,0),
                      height: 400,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0,20,0,10),
                              padding: EdgeInsets.fromLTRB(20,0,20,0),
                              child: Row(

                                children: const [
                                  Text("Confirm your pickup",style:TextStyle(fontSize: 20,color: Colors.black)),
                                ],
                              ),
                            ),
                             Container(
                               margin: EdgeInsets.fromLTRB(10,20,10,10),
                              padding: EdgeInsets.fromLTRB(0,0,0,0),
                               height:50,
                               width:400,
                               decoration: const BoxDecoration(

                                 color: Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black12,
                                     blurRadius: 0.10,
                                     spreadRadius: 1.0,
                                     offset: Offset(0.0,0.0), // shadow direction: bottom right
                                   )
                                 ],
                               ),
                               child: (
                                   const TextField(
                                     onChanged: null,
                                     cursorColor: Colors.black,
                                     keyboardType: TextInputType.text,
                                     textInputAction: TextInputAction.go,
                                     decoration: InputDecoration(
                                         border: InputBorder.none,
                                         contentPadding:
                                         EdgeInsets.symmetric(horizontal: 15),
                                         hintText: "N0.6.Greams Road,Thoudand Light,Chennai....",suffixStyle: TextStyle(color: Colors.black)),

                                   )
                               ),

                             ),


                            //for text input

                              Container(

                                margin: EdgeInsets.fromLTRB(10,0,10,10),
                                padding: EdgeInsets.fromLTRB(40,0,40,0),
                                decoration: const BoxDecoration(

                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.10,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0,0.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                child: Row(
                                  children:[
                                    Column(
                                        children:[
                                          SizedBox(
                                            height:40,
                                            width:270,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black,),
                                              child: const Text('Confirm Pickup',style: TextStyle(color: Colors.white,fontSize: 20),),
                                              onPressed: () =>{
                                              Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>const DispalyRide()))
                                              },
                                            ),
                                          ),

                                        ]
                                    )
                                  ],
                                ),
                              ),


                              ///added

                            ],
                        )


                      ),),],), );

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