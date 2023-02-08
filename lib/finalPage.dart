import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:myolaapp/scrollscreen.dart';
import 'package:myolaapp/userpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'confirmationpage.dart';
import 'main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
const LatLng currentLocation=LatLng(13.061140, 80.282480);

class DispalyRide extends StatefulWidget {
  const DispalyRide({super.key});
//    final String cartype;
//    final String price;
//   const  ConfirmationPage ({ Key? key,required this.cartype, required this.price }): super(key: key);
//   @override
  @override
  _DispalyRide createState() => _DispalyRide();
}

class _DispalyRide extends State<DispalyRide> {
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
                  margin: EdgeInsets.fromLTRB(0,0,0,0),
                  padding: EdgeInsets.fromLTRB(10,0,10,0),
                  height:100 ,
                  width:double.infinity,

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

                  child:Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0,20,0,0),
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),

                          Container(
                              margin: const EdgeInsets.fromLTRB(0,8,0,6),
                              color: Colors.black26,
                              child:const SizedBox(
                                height:30 ,
                                width: 2,
                              )
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.fromLTRB(0,0,0,0),
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [

                          Container(
                            width: 280,
                            height: 40,
                            margin:  EdgeInsets.fromLTRB(14,4,0,0),
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              onTap:() => {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>  const Destination())
                                ),

                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                                  hintText: "Search for an address or landmark",suffixStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                          Container(
                            margin:  EdgeInsets.fromLTRB(28,7,0,0),
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            color: Colors.black12,
                            child: const SizedBox(
                              width:280,
                              height:0.50,
                            ),
                          ),
                          Container(
                            width: 280,
                            height: 40,
                            margin:  EdgeInsets.fromLTRB(14,4,0,0),
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              onChanged:(value) => {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>  const Destination())
                                ),

                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                                  hintText: "Enter Destination",suffixStyle: TextStyle(color: Colors.black)),
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
              //navigation icon

              DraggableScrollableSheet(

                  initialChildSize:0.35,
                  maxChildSize:0.35,
                  builder:(BuildContext context,ScrollController scrollController){
                    return Container(color: Colors.white,
                      child: ListView(
                        physics:ClampingScrollPhysics(),
                        controller:scrollController,

                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0,0,0,0),
                              padding: EdgeInsets.fromLTRB(0,0,0,0),
                              height:10,
                              width:80,

                              decoration: const BoxDecoration(

                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 0.10,
                                    spreadRadius: 1.0,
                                    offset: Offset(0.0,0.0), // shadow direction: bottom right
                                  )
                                ],
                              ),

                            child:Row(
                              children: [
                                Container(

                                  margin: EdgeInsets.fromLTRB(170,0,0,0),
                                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                                  height:5,
                                  width:40,

                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.grey,
                                    boxShadow: [
                                      BoxShadow(

                                        color: Colors.black,
                                        blurRadius: 0.10,
                                        spreadRadius: 1.0,
                                        offset: Offset(0.0,0.0), // shadow direction: bottom right
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0,0,0,0),
                            padding: EdgeInsets.fromLTRB(10,10,10,0),
                            height:40,
                            width:double.infinity,

                            decoration: const BoxDecoration(

                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 0.10,
                                  spreadRadius: 1.0,
                                  offset: Offset(0.0,0.0), // shadow direction: bottom right
                                )
                              ],
                            ),child: Text("Your ride is confirmed",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                          ),
                   Divider(
                     thickness: 1,
                   ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0,5,0,0),
                            padding: EdgeInsets.fromLTRB(10,0,10,0),
                            height:140,
                            width:double.infinity,

                            decoration: const BoxDecoration(

                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 0.10,
                                  spreadRadius: 1.0,
                                  offset: Offset(0.0,0.0), // shadow direction: bottom right
                                )
                              ],
                            ),

                            child:(

                           Row (
                             children: [
                           Column(
                             children: [
                               Container(
                                 margin: EdgeInsets.fromLTRB(0,10,0,0),
                                 padding: EdgeInsets.fromLTRB(10,0,10,0),
                                 height:20 ,
                                 width:135,

                                 decoration: const BoxDecoration(

                                   color: Colors.amber,
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.white,
                                       blurRadius: 0.0,
                                       spreadRadius: 1.0,
                                       offset: Offset(0.0,0.0), // shadow direction: bottom right
                                     )
                                   ],
                                 ),

                                 child: Row(
                                   children: [
                                     Text("White Swift Dzire",style:TextStyle(color: Colors.black)),
                                   ],
                                 ),
                               ),
                               Container(
                                 margin: EdgeInsets.fromLTRB(0,0,0,0),
                                 padding: EdgeInsets.fromLTRB(15,0,0,0),
                                 height:90 ,
                                 width:120,

                                 decoration: const BoxDecoration(

                                   color: Colors.white,
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.white,
                                       blurRadius: 0.0,
                                       spreadRadius: 0.0,
                                       offset: Offset(0.0,0.0), // shadow direction: bottom right
                                     )
                                   ],
                                 ),

                                 child: Row(
                                   children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 35.5,
                                          backgroundColor: Colors.white,
                                          child:(Image.asset(
                                            'assets/ola4.jpeg',
                                          )),
                                        ),
                                        const Text("TN 09 BK 111")

                                      ],
                                    )
                                   ],
                                 ),
                               ),



                             ],
                           ),
                               Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(110,10,22,0),
                                    padding: EdgeInsets.fromLTRB(20,0,20,0),
                                    height:18 ,
                                    width:105,

                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.amber,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 0.10,
                                          spreadRadius: 1.0,
                                          offset: Offset(0.0,0.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),

                                    child: Row(
                                      children: [
                                        Text("OTP:1845",style:TextStyle(color: Colors.black,)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(60,10,20,0),
                                    padding: EdgeInsets.fromLTRB(35,0,0,10),
                                    height:100 ,
                                    width:140,

                                    decoration: const BoxDecoration(

                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 0.10,
                                          spreadRadius: 1.0,
                                          offset: Offset(0.0,0.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),

                                    child: Row(
                                      children:  [
                                               Column(
                                                 children: [
                                                   CircleAvatar(
                                                     backgroundColor: Colors.black,
                                                     radius: 25,
                                                     child: Icon(
                                                       Icons.person,
                                                       size: 25.0,
                                                       color: Colors.white,
                                                        ),
                                                       ),

                                                   Text("Venkateshwaran"),
                                                   Row(
                                                     children: [
                                                       Icon(
                                                         Icons.star,
                                                         size: 15.0,
                                                         color: Colors.amber,
                                                       ),
                                                       Text("4.8")
                                                     ],
                                                   )
                                                 ],
                                               ),

                                      ]
                                    ),
                                  ),


                                ],
                               )


                             ],
                            )


                            ),
                          ),
                          Container(

                            margin: EdgeInsets.fromLTRB(0,0,0,0),
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            height:50,
                            width:200,

                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(

                                  color: Colors.white,
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0,0.0), // shadow direction: bottom right
                                ),
                              ],
                            ),
                            child:Row(
                              children: [

                                Column(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.fromLTRB(10,0,0,0),
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      height:50,
                                      width:60,

                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(

                                            color: Colors.black12,
                                            blurRadius: 0.10,
                                            spreadRadius: 1.0,
                                            offset: Offset(0.0,0.0), // shadow direction: bottom right
                                          ),
                                        ],
                                      ),
                                      child:
                                      // Icon(
                                      //
                                      //   Icons.phone,
                                      //   size: 25.0,
                                      //   color: Colors.black,
                                      //   ),
                                      IconButton(
                                        icon: new Icon(Icons.phone,size: 25.0,
                                             color: Colors.black,),
                                        onPressed: () {   Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                         return const ConfirmationPage();
                                         },
                                      )


                                    );}
                                      ),),],
                                ),
                                Column(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.fromLTRB(10,0,0,0),
                                      padding: EdgeInsets.fromLTRB(0,4,0,0),
                                      height:50,
                                      width:300,

                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(

                                            color: Colors.black12,
                                            blurRadius: 0.10,
                                            spreadRadius: 1.0,
                                            offset: Offset(0.0,0.0), // shadow direction: bottom right
                                          ),
                                        ],
                                      ),
                                      child:Column(
                                        children: const [
                                          ListTile(
                                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                            title: Text("Message your driver...",style:TextStyle(
                                                color:Colors.black,fontSize: 18,
                                            )),
                                            trailing: Icon(
                                              Icons.send,
                                              size: 25.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                ),

                              ],
                            )
                          )
                          //added
                        ],), );

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