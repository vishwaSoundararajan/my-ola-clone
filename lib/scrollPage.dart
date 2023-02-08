import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myolaapp/bottomSheet.dart';
import 'package:myolaapp/listingpage.dart';
import 'package:myolaapp/scrollscreen.dart';
import 'package:myolaapp/sideMenu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myolaapp/testRidepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'main.dart';


// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
//   var msgId=message.messageId;
//   _olasdkPlugin.onMessageReceived(msgId!);
//   // Timer(const Duration(seconds: 2),(){
//   //   eventTriggered();
//   // });
// }

const LatLng currentLocation=LatLng(13.061140, 80.282480);



class SearchPage extends StatefulWidget {
const SearchPage({super.key});
  @override
  _SearchPage createState() => _SearchPage();
}
const events = EventChannel('example.com/channel');
final _olasdkPlugin=Fluttersdkplugin();
class _SearchPage extends State<SearchPage> {

  late Position position;
  late GoogleMapController mapController;
  var locHint="Your CurrentLocation";
  Map<String,Marker>_markers={};
  Set<Marker> markers={};
  static const CameraPosition initialCameraPosition =CameraPosition(target: LatLng(13.061140, 80.282480),zoom:10);
  _olaURLBrowser() async {
    var url = Uri.parse("https://olaelectric.com/offers");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

void bottom(){
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>MyAppp()));

}
  void showAlert(BuildContext context,RemoteMessage msg,String type) {

    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Notification firebase'),
            content: Text("${msg.notification?.body}\n Message state:${type} "),
          );
        });
  }

  void _handleMessage(RemoteMessage message) {
    print('App openned from terminated stated,by Background message clicked!!!!');
    Future.delayed(Duration.zero, () => showAlert(context,message,"Terminated"));
  }

  void initState()  {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("App opened through background message !!!");
      Future.delayed(Duration.zero, () => showAlert(context,message,"Background"));
    },);
    Firebase.initializeApp();
    // FirebaseMessaging.instance.getToken().then((newToken) {
    //   // print("FCM token: ");
    //   // print(newToken);
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     print('Got a message whilst in the foreground!');
    //     print('Message data: ${message.notification?.body} ');
    //    // _olasdkPlugin.onMessageReceived("Foreground Notification");
    //     // Timer(const Duration(seconds: 2),(){
    //     //   eventTriggered();
    //     // });
    //     if (message.notification != null) {
    //       print('Message also contained a notification: ${message.notification}');
    //
    //       Future.delayed(Duration.zero, () => showAlert(context,message,"Foreground"));
    //     }
    //   });
    // });

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

         // appBar: AppBar(
         //
         // ),
        //   title:Text("Ola",style: TextStyle(color: Colors.black),),
        //   backgroundColor: Colors.blue,
        //   elevation: 0,
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: CircleAvatar(
        //         backgroundColor: Colors.grey[100],
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.person,
        //             color: Colors.grey[500],
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body: Stack(
          children: [

            GoogleMap(
              initialCameraPosition:initialCameraPosition,
            onMapCreated:(GoogleMapController controller){
              mapController = controller;
            },
              markers: markers,
            ),
            ///////////////////////////

            Positioned(
              top: 5,
              right: 10,
              left: 10,
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),

                child: Row(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.grey,
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const SideMenu())
                        );
                        },
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                     Expanded(
                      child: TextField(
                        onTap:() async => {
                         position = await _determinePosition(),
                          mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 16))),
                           markers.clear(),
                          markers.add(Marker(markerId: MarkerId("current Location"),position: LatLng(position.latitude,position.longitude))),
                        _olasdkPlugin.pushLocation(position.latitude,position.longitude)
                          },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(

                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 15),
                            hintText: locHint
                        ),
                      ),
                    ),


                    IconButton(// padding: const EdgeInsets.only(right: 8.0),
                      splashColor: Colors.grey,
                      icon: const Icon(Icons.favorite_border_outlined),
                      onPressed: () {

                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(15,0,0,0),
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                                      child: Row(

                                        children: const [
                                        Text("Save as favourite",style:TextStyle(fontSize: 22,)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(3,10,0,0),
                                      child: Row(
                                        children: const [
                                        Text("Getting Address"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0,15,0,0),
                                      child: Row(
                                        children:[
                                          Column(
                                              children:[
                                                Row(
                                                  children: [
                                                    Radio(
                                                        value: "Home",
                                                        groupValue: "Hom",
                                                        onChanged: (value){
                                                          print(value); //selected value
                                                        }
                                                    ),
                                                    Text("Home"),
                                                  ],
                                                ),

                                              ]
                                          ),
                                          Column(
                                              children:[
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: "Work",
                                                      groupValue: "Wor",
                                                      onChanged: (value){
                                                        print(value); //selected value
                                                      }
                                              ),
                                                    Text("Work"),
                                                  ],
                                                ),
                                              ]
                                          ),
                                          Column(
                                              children:[
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: "Others",
                                                      groupValue: 'Other',
                                                      onChanged: (value){
                                                        print(value); //selected value
                                                      }
                                              ),     Text("Others"),
                                                  ],
                                                ),

                                              ]
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(8,0,10,0),
                                      child: Row(

                                        children:[
                                          Column(
                                              children:[
                                                SizedBox(
                                                 height:45,
                                                 width:165,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.white,),
                                                  child: const Text('Save',style: TextStyle(color: Colors.black)),
                                                  onPressed: () => Navigator.pop(context),
                                              ),
                                                ),

                                              ]
                                          ),
                                          SizedBox(
                                            width:20
                                          ),
                                          Column(
                                              children:[
                                                SizedBox(
                                                  height:45,
                                                  width:165,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.black,),
                                                  child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                                                  onPressed: () => Navigator.pop(context),
                                              ),
                                                ),

                                              ]
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      },
                    ),


                  ],
                ),
              ),
            ),

/////////////////////////////////
            DraggableScrollableSheet(

                initialChildSize:0.5,
                minChildSize:0.5,
                builder:(BuildContext context,ScrollController scrollController){
                  return Container(color: Colors.white,
                      child: ListView(
                        physics:ClampingScrollPhysics(),
                        controller:scrollController,
//
                        children: [


                          const SizedBox(
                            height: 15,
                            width: double.infinity,
                          ),

                          Container(
                              child:SingleChildScrollView(
                                child:Column(
                                  children: [
                                    SizedBox(
                                      height:70,
                                      child: ListView(
                                        scrollDirection:Axis.horizontal,
                                        children: [

                                          Row(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                                width:35,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                  children: [
                                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                                      child:(Image.asset(
                                                        'assets/ola6.jpeg',

                                                        fit: BoxFit.cover,
                                                      ))
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [Text("Daily",style: TextStyle(fontSize: 14),)],
                                                )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:30,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        child:(Image.asset(
                                                          'assets/ola5.jpeg',
                                                          fit: BoxFit.cover,
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [Text("Electric",style: TextStyle(fontSize: 14),)],
                                                  )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:30,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        child: (
                                                            Image.asset(
                                                              'assets/ola8.jpeg',

                                                              fit: BoxFit.cover,
                                                            )
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [Text("Rental",style: TextStyle(fontSize: 14),)],
                                                  )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:35,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                     CircleAvatar(
                                              backgroundColor: Colors.white,
                                                       child: ( Image.asset(
                                                         'assets/ola7.jpeg',

                                                         fit: BoxFit.cover,
                                                       )),
                                                     )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [Text("Outstation",style: TextStyle(fontSize: 14),)],
                                                  )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:30,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                              backgroundColor: Colors.white,
                                                        child:Image.asset(
                                                          'assets/ola6.jpeg',

                                                          fit: BoxFit.cover,
                                                        )
                                                      )
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [Text("Daily",style: TextStyle(fontSize: 14),)],
                                                  )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:30,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                              backgroundColor: Colors.white,
                                                        child: Image.asset(
                                                          'assets/ola3.jpeg',

                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [Text("Preowned",style: TextStyle(fontSize: 14),)],
                                                  )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:35,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        child: Image.asset(
                                                          'assets/ola1.jpeg',

                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [Text("Money",style: TextStyle(fontSize: 14),)],
                                                  )],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:35,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor: Colors.white,
                                                        child:Image.asset(
                                                          'assets/ola2.jpeg',

                                                          fit: BoxFit.cover,
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [Text("Insure",style: TextStyle(fontSize: 14),)],
                                                  )],

                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width:35,
                                              ),
                                            ],

                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(15,0, 15,0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0,0.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Container(
                                height: 180,
                                child: (Column(
                                  children: [
                                    // Container(
                                    //
                                    //   child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                    //     children: [
                                    //       TextButton(onPressed:(){
                                    //       Navigator.of(context).push(
                                    //           MaterialPageRoute(builder: (context)=>const SearchHome())
                                    //       );},style: TextButton.styleFrom(padding: const EdgeInsets.fromLTRB(100,0,85,0),backgroundColor: Colors.grey), child: Row(
                                    //         children:  const [
                                    //           Text('Search Destination',style: TextStyle(color: Colors. black,fontSize: 18,),),
                                    //         ],
                                    //       ),)
                                    //
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(

                                        margin: EdgeInsets.fromLTRB(6,6,6,0),
                                        padding: EdgeInsets.fromLTRB(0,4,0,0),
                                        height:50,
                                        width:350,

                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.black12,
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
                                          children:  [
                                            ListTile(
                                              leading: IconButton(
                                                onPressed:() {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (context)=>const SearchHome()),);
                                                },
                                                icon: const Icon(

                                                  Icons.search_outlined,
                                                ),
                                              ),
                                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                              title: const Text("Search Destination",style:TextStyle(
                                                color:Colors.black,fontSize: 18,
                                              )),

                                            ),
                                          ],
                                        )
                                    ),
                                    ListTile(
                                      leading: IconButton(
                                        onPressed:() {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>const SearchHome()),);
                                        },
                                        icon: Icon(

                                          Icons.location_on_rounded,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                      title: InkWell(
                                        child: Text("Egmore Railway Station,Gandhi Irwing Rd,Eg...",style:TextStyle(
                                            color:Colors.black,fontSize: 12
                                        )),onTap:(){
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>const Destination()),);
                                      },
                                      ),
                                    ),
                                    ListTile(

                                      leading: IconButton(
                                        onPressed:() {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>const SearchHome()),);
                                        },
                                        icon: Icon(
                                          Icons.location_on_rounded,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                      title: Text("Chennai Mofussil Bus Terminus,CMBT Pass...",style:TextStyle(
                                          color:Colors.black,fontSize: 12
                                      )),
                                    ),
                                    ListTile(

                                      leading: IconButton(
                                        onPressed:() {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>const SearchHome()),);
                                        },
                                        icon: Icon(
                                          Icons.location_on_rounded,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                      title: Text("Chennai International Airport, GST Rd,Meen..",style:TextStyle(
                                          color:Colors.black,fontSize: 12
                                      )),
                                    ),
                                  ],
                                )

                                ),

                              ) // child widget, replace with your own
                          ),

                          Container(
                            padding: EdgeInsets.fromLTRB(15,15,15,15),
                            child:ClipRRect(

                              borderRadius:BorderRadius.circular(10),
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  'assets/b1.jpeg',
                                  fit: BoxFit.fitWidth,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    var content="On Track Event called!!!";
                                    _olasdkPlugin.onTrackEvent(content);
                                    _olaURLBrowser();
                                    },

                                child:
                                  TextButton(onPressed:(){
                                    var content="On Track Event called!!!";
                                    _olasdkPlugin.onTrackEvent(content);
                                  },
                                    style: TextButton.styleFrom(padding: const EdgeInsets.fromLTRB(20,160,20,0),backgroundColor: Colors.transparent), child: Row(
                                  children:  [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [

                                         const Text('Ride with epic features',style: TextStyle(color: Colors. white,fontSize: 24,decoration:TextDecoration.underline)),

                                           // const Text('Ride with epic features',style: TextStyle(color: Colors. white,fontSize: 24,)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('Experience Music,Navigation and \nmore on the Ola Scooter.',style: TextStyle(color: Colors.white,fontSize: 14)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                  )
                                    ),],


                            )
                  ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(15,0,15,20),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/pic2.jpeg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  TextButton(onPressed:(){
                                    var content="On Track Event called!!!";
                                    _olasdkPlugin.onTrackEvent(content);
                                  Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>const TestRide())
                                         );
                                  },style: TextButton.styleFrom(padding: const EdgeInsets.fromLTRB(20,90,20,0),backgroundColor: Colors.transparent,), child: Row(
                                    children:  [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Flat 10,000 off \non the Ola S1 Pro',style: TextStyle(color: Colors. white,fontSize: 24,)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Enjoy great festive finance offers \nand many other benefits',style: TextStyle(color: Colors.white,fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),)
                                ],

                          ),
                              ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(15,0,15,20),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(10),

                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/pic4.jpeg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  TextButton(onPressed: (){
                                    _olaURLBrowser();
                                    var content="On Track Event called!!!";
                                    _olasdkPlugin.onTrackEvent(content);
                                    },
                                    style: TextButton.styleFrom(padding: const EdgeInsets.fromLTRB(20,120,20,0),backgroundColor: Colors.transparent), child: Row(
                                    children:  [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Ride with epic features',style: TextStyle(color: Colors. white,fontSize: 24,decoration: TextDecoration.underline)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Experience Music,Navigation and \nmore on the Ola Scooter.',style: TextStyle(color: Colors.white,fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),)
                                ],

                              ),
                              )
                          ),
                        ],




                      )

                  );

                }
            ),
            ////for bottom widget

            //////for bottom widget
          ],),
      ),
    );}
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
  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Loction Service not enaled");
    }
    permission= await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location Permission denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location permission are permenantly denied");
    }
    Position position =await Geolocator.getCurrentPosition();
    return position;

  }

  }



