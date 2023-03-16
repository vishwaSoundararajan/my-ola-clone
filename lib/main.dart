import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:myolaapp/listingpage.dart';
import 'package:myolaapp/phonefield.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:myolaapp/sdkMethodsTesting.dart';
import 'package:myolaapp/splash_screen.dart';
import 'package:myolaapp/testRidepage.dart';
import 'package:myolaapp/phonefield.dart';
import 'package:myolaapp/welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'confirmationpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dragScreen.dart';
import 'loginPage.dart';
import 'package:ink_widget/ink_widget.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

// @pragma('vm:entry-point')
//Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
 late BuildContext appContext;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Ola', // used by the OS task switcher
        home: SafeArea(child: MyApp()),


    ),
  );
}

// eventTriggered(){
//   events.receiveBroadcastStream().listen((datta) {
//     if(datta is String){
//       if (kDebugMode) {
//         print(datta);
//       }
//     }
//   }, onError: (error) {
//     print("Error: $error");
//   });
// }


const events = EventChannel('example.com/channel');
final _olasdkPlugin=Fluttersdkplugin();

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return Container();
  }
}
bool splashTime=false;
bool splashTimer() {
  return true;
}
var logger = Logger();
class _MyAppState extends State<MyApp>{

  late Timer _timer;
  static const events = EventChannel('example.com/channell');
  int notificationCount=0;
  @override
  void initState() {
    Firebase.initializeApp();
    // FirebaseMessaging.instance.getToken().then((newToken) {
    //   print("FCM token: ");
    //   print(newToken);
    //   _olasdkPlugin.updatePushToken(newToken!);
   // val mytoken="cZW-_wFgRmmkc6F-dzfwlV:APA91bE2IqDUxmZcAyPhAzwoTCpYXuQbENcBqLqn3TOv_pof_Zmow7qtwZE64Avq_8KOWr5u18fVplrX-fAYfJmRjeIkCeWoYectt-kHL59T46h-8S723Lsqdk5DM9RzrOfyKZ-04AA3";
        // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //   print('Got a message whilst in the foreground!');
        //   print('Message data: ${message.notification?.body} ');
        //   _olasdkPlugin.onMessageReceived("Foreground Notification");
        //   Future<int?> readnotificationCount() async{
        //     var nCount=await _olasdkPlugin.readNotificationCount()!;
        //     setState(()  {
        //       notificationCount=nCount!;
        //     });
        //     if (kDebugMode) {
        //       print(notificationCount);
        //     }
        //     return null;
        //   }
        //   // Timer(const Duration(seconds: 2),(){
        //   //   eventTriggered();
        //   // });
        //   if (message.notification != null) {
        //
        //     print('Message also contained a notification: ${message.notification}');
        //   }
        // }
        // );

    // }
    // );

    super.initState();

    // //deeplink
    // // Set up a method channel to handle deep links
    // const deepLinkChannel = MethodChannel('myapp/deep_link');
    // deepLinkChannel.setMethodCallHandler((call) async {
    //   if (call.method == 'handleDeepLink') {
    //     final deepLink = call.arguments['link'];
    //
    //     Uri uri = Uri.parse(deepLink);
    //     String? id = uri.queryParameters['id'];
    //     // Navigate to the details screen with the given ID
    //     if(id=="phonefield")
    //       {
    //         Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPhone()));
    //       }
    //     else {
    //       logger.i("Page not available");
    //     }
    //
    //     // Navigate to the details screen with the given ID
    //     // (parse the ID from the deep link URL)
    //   }
    // });
    //
    // //deeplink


    Timer(const Duration(seconds: 2),(){
      setState(() {
        splashTime=splashTimer();
      }
      );
      if(splashTime==true){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstPage()));

      }
    });
    startTimer();
  }
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      listenForMsg();
    });
  }

  listenForMsg(){
    events.receiveBroadcastStream().listen((data) {
      if(data != ""){
        logger.i("EventChannel :: $data");
        Fluttertoast.showToast(
          msg:"Received:$data",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    }, onError: (error) {
      print("Error: $error");
    });

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myolaapp',
      home:SplashScreen(),
    );
  }


}

void initDynamicLinks() async{
  print("initDynamic links called!!!");
  final PendingDynamicLinkData? dynamicLink =
  await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deeplink = dynamicLink?.link;
  logger.i('Deeplinks uri:$deeplink');
  if (deeplink != null) {
    logger.i('Deeplinks uri:${deeplink}');
    Get.toNamed(deeplink.queryParameters.values.first);

  }
  else{
    if (kDebugMode) {
      print("Page not available!!!");
    }
  }
}
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
checklogin();

    // initDynamicLinks();
  }

  void checklogin() async {
    var logindata = await SharedPreferences.getInstance();
    var newuser = (logindata.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyDashboard()));
    }
    else
    {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       height: 0,
       width: 0,
     ),
   );
  }

}


class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
  }
  _launchURLBrowser() async {
    var url = Uri.parse("http://www.olacabs.com/info/faqs#termsAndConditions");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        '/phonefield' :(BuildContext contxt)=> MyPhone(),
        '/Scrollpage' :(BuildContext contxt)=> SearchPage()
      },

    home:SafeArea(

      child: Scaffold(
        body: Stack(
          children: [

            Container(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [

                  Image.asset('assets/frontlogo.jpeg', height: 450,
                    width: 450,
                    fit: BoxFit.fitWidth,),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding:EdgeInsets.fromLTRB(16,0,0,0),
                    child:(
                    Column(
                      children: const [
                  Text('Explore new ways to\ntravel with Ola', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
                                ],
                    )
                    ),
                  ),
                  const SizedBox(
                    height: 20, //<-- SEE HERE
                  ),
               Container(
                   padding: const EdgeInsets.all(12),

                   child:(
                     Column(
                       children: [

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextButton(onPressed:(){

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const MyPhone())
                        );

                          }, style: TextButton.styleFrom(backgroundColor: Colors.black,padding: const EdgeInsets.fromLTRB(90, 0, 90, 0)), child: const Text("Continue with Phone Number", style:TextStyle(color:Colors.white)),),
                    ],
                  ),
                  const SizedBox(
                    height: 20, //<-- SEE HERE
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed:(){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(),
                        );
                      },style: TextButton.styleFrom(backgroundColor: Colors.white,padding: const EdgeInsets.fromLTRB(50, 0, 50, 0)), child: Row(
                        children:  [
                          Image.asset(
                            'assets/img_1.png',
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width:10, //<-- SEE HERE
                          ),
                          const Text('Google',style: TextStyle(color: Colors. black))
                        ],
                      ),),
                      TextButton(onPressed:(){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context)=>const CabListing()),);
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) => _buildPopupDialog(),
                        // );

                      },style: TextButton.styleFrom(backgroundColor: Colors.white,padding: const EdgeInsets.fromLTRB(50, 0, 50, 0)), child: Row(
                        children: [
                          Image.asset(
                            'assets/img_2.png',
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width:10, //<-- SEE HERE
                          ),
                          const Text('Facebook',style: TextStyle(color: Colors. black),)
                        ],
                      ),)
                    ],
                  ),
                  const SizedBox(
                    height: 20, //<-- SEE HERE
                  ),
                  Row(
                    children: [
                      const Text('By continue, you agree that you have read and accept our ',style: TextStyle(fontSize: 12,color: Colors.black45),),
                      GestureDetector(
                        onTap: (){_launchURLBrowser();},
                      child: Text('T&Cs',style: TextStyle(fontSize: 12,color: Colors.black45,decoration: TextDecoration.underline),),
                        )
                    ],
                  ),
                         Row(
                           children: [
                             const Text('and ',style: TextStyle(fontSize: 12,color: Colors.black45),),
                             InkWell(
                               child: new Text('Privacy Policy',style: TextStyle(fontSize: 12,color: Colors.black45,decoration: TextDecoration.underline)),
                               onTap: () {_launchURLBrowser();},
                             ),
                           ],
                         ),

                 ],
                 )
               )
            ),
                  Container(
                     margin: EdgeInsets.fromLTRB(180,0,0,0),
                    height: 10,
                    width:40,
                    color: Colors.black12,
                    child:TextButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>const  SdkMethodTesting()),);//CabListing()
                      },
                      child: Text(''),

                    )
                  )


                ]

              ),
            ),
          ],
        ),
      ),

      ),);

  }
}

class SecondPage extends StatelessWidget{
        const SecondPage({super.key});
        @override
        Widget build(BuildContext context) {
          return SafeArea(
            child: Scaffold(
              body:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [
                    const SizedBox(
                    ),
                    Row(
                      children: const [
                        Text('Enter Phone number for \n verification', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                     //const Text('Enter Phone number for\n verification)', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
                    const Text('This number will be used for all ride-related communication. You shall receive an\n SMS with code for verification.)', style: TextStyle(fontSize: 18),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 29),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Your number',
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 300,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed:(){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>const ThirdPage())
                          );
                          }, style: TextButton.styleFrom(backgroundColor: Colors.black,), child: const Text("NEXT", style:TextStyle(color:Colors.white)),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed:(){
                          Navigator.of(context).pop(
                              MaterialPageRoute(builder: (context)=>const HomePage())
                          );
                        }, style: TextButton.styleFrom(backgroundColor: Colors.black,), child: const Text("prev", style:TextStyle(color:Colors.white)),),
                      ],
                    ),
                  ],
              ),
            ),
          );
        }
}


class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});
     @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/greetlogo.jpeg', height: 450,
            width: 500,
            fit: BoxFit.fitWidth,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Welcome to Ola', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),)
        ],
      ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Have a hassle-free booking experience\n by giving us the following permissions.', style: TextStyle(fontSize: 14),)
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Location(for finding available riders', style: TextStyle(fontSize: 18,fontWeight: FontWeight. bold,),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Phone(for account security verification', style: TextStyle(fontSize: 18,fontWeight: FontWeight. bold,),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed:(){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>const FourthPage())
                );
              }, style: TextButton.styleFrom(backgroundColor: Colors.black,), child: const Text("NEXT", style:TextStyle(color:Colors.white)),),

              TextButton(onPressed:(){
                Navigator.of(context).pop(
                    MaterialPageRoute(builder: (context)=>const SecondPage())
                );
              }, style: TextButton.styleFrom(backgroundColor: Colors.black,), child: const Text("prev", style:TextStyle(color:Colors.white)),),
            ],
          ),


        ],

      ),
    );
  }
}


class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        appBar: AppBar(
          title: const Text("Ola"),
        ),
        body: Column(
          children: [
            Image.asset('assets/map.jpeg', height: 300,
              width: 400,
              fit: BoxFit.fitWidth,),


            //First row
            Row(
              children: [
                TextButton(onPressed:  () {Navigator.push(context, MaterialPageRoute(
    builder: (context)
                {
                  return  const ConfirmationPage();
                },
              ));
                },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white54,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/subcar.png',
                          width: 15,
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                        const Text('2min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 89, 0),
                        child: Column(
                          children: const [
                            Text('Book Any', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Get nearest mini or Prime',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('719.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            //Second row
            Row(
              children: [
                TextButton(onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white54,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/auto.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                        const Text('1min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 86, 0),
                        child: Column(
                          children: const [
                            Text('Auto', style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Get Auto at your doorStep',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('470.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            //Third Row
            Row(
              children: [
                TextButton(onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white54,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/minicar.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                        const Text('2min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 101, 0),
                        child: Column(
                          children: const [
                            Text('Mini', style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Comfy economical cars',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('510.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            Row(
              children: [
                TextButton(onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white54,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/auto.png',
                          width: 15,
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                        Text('1min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 86, 0),
                        child: Column(
                          children: const [
                            Text('Auto', style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Get Auto at your doorStep',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('470.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            //Third Row
            Row(
              children: [
                TextButton(onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white54,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/minicar.png',
                          width: 15,
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                        Text('2min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 101, 0),
                        child: Column(
                          children: const [
                            Text('Mini', style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Comfy economical cars',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('510.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            Row(children: const [
              Text("More Available rides",
                style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
            Row(
              children: [
                TextButton(onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white60,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/olabike.png',
                          width: 15,
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                        const Text('2min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 105, 0),
                        child: Column(
                          children: const [
                            Text('Bike', style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Beat the traffic on bike',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('470.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            //Third Row
            Row(
              children: [
                TextButton(onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white54,),
                    child: Row(children: [Column(
                      children: [
                        Image.asset(
                          'assets/subcar.png',
                          width: 15,
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                        const Text('2min', style: TextStyle(color: Colors.black))
                      ],
                    ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 0, 77, 0),
                        child: Column(
                          children: const [
                            Text('Prime Sedans', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                            Text('Spacious Sedans top Driver',
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          Text('510.RS', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(
                //   builder: (context)
                //   {
                //     return  const ConfirmationPage(cartype: "Minicar", price: "750.RS");
                //   },
                // ));
                // },
                //   style: TextButton.styleFrom(backgroundColor: Colors.black,),
                //   child: const Text(
                //       "NEXT", style: TextStyle(color: Colors.white)),),

                TextButton(onPressed: () {
                  Navigator.of(context).pop(
                      MaterialPageRoute(builder: (context) => const ThirdPage())
                  );
                },
                  style: TextButton.styleFrom(backgroundColor: Colors.black,),
                  child: const Text(
                      "prev", style: TextStyle(color: Colors.white)),),
              ],
            ),

          ],

        ),
      )
      ),
    );
  }
}



class Confirmsg extends StatelessWidget
{
  const Confirmsg({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: const [Padding(padding: EdgeInsets.fromLTRB(0,600,0,0)),
              Text(
                  "Your Ride Confirmed!!!", style: TextStyle(color: Colors.black,fontSize: 30,))
            ],
          ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     TextButton(onPressed: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(
            //               builder: (context) => const SearchPage()),
            //       );
            //     },
            //       style: TextButton.styleFrom(
            //           backgroundColor: Colors.black,
            //           padding: const EdgeInsets.fromLTRB(80, 0, 80, 0)),
            //       child: const Text(
            //           "Back", style: TextStyle(color: Colors.white,)),),
            //   ],
            // ),

        ],

    ),
      ),
    );
  }
}
Widget _buildPopupDialog() {
  _googleTermsUrl() async {
    var url = Uri.parse("http://www.olacabs.com/info/faqs#termsAndConditions");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  return Dialog(backgroundColor: Colors.white,
     shape: RoundedRectangleBorder(
       borderRadius:
       BorderRadius.circular(5.0),), //this right here
          child: Container(
         height: 450,
            child: (
            Container(
              margin: EdgeInsets.fromLTRB(0,0,0,0),
              child:(
              Column(
                children: [
                  Image.asset(
                    'assets/olaLogo.png',
                    width: 100,
                    height: 100,
                  ),
                  Text("Choose an account",style:TextStyle(fontSize: 22),),
                  Text("to continue to Ola",),

                  Card(
                    shape: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black)),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ListTile(
                      leading:  CircleAvatar(backgroundColor: Colors.black12,
                        child: Icon(
                            Icons.account_circle_rounded,size: 40.0,
                            color: Colors.grey[500]),
                      ),
                      title: Text('Vishwa'),
                      visualDensity: VisualDensity(vertical: -4),
                      subtitle: Text('vishwa@gmail.com'),
                    ),
                  ),
                  Card(
                shape: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black)),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListTile(
              leading:  CircleAvatar(backgroundColor: Colors.black12,
                child: Icon(
                    Icons.account_circle_rounded,size: 40.0,
                    color: Colors.grey[500]),
              ),
              title: Text('Lokesh'),
                visualDensity: VisualDensity(vertical: -4),
                subtitle: Text('lokesh@gmail.com'),
                 ),
              ),
                  Card(
                    shape: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black)),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.white,
                        child:   Image.asset(
                          'assets/add-friend.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      title: Text('Add another account'),
                      visualDensity: VisualDensity(vertical: -4),

                    ),
                  ),
                  Container(
                   height: 80,

                    margin:EdgeInsets.fromLTRB(20,40,20,0),
                    child:(

                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child:
                                        Text("To Continue, Google will share your name, "
                                            "email address and profile picture with Ola. Before using this "
                                            "ola app, review its privacy policy and terms of service"),

                                    ),

                                  ],
                                ),

                              ],
                            ),

                            // InkWell(
                            //   child: new Text('\nPrivacy Policy ',style: TextStyle(fontSize: 12,color: Colors.black45,decoration: TextDecoration.underline)),
                            //   onTap: () {_googleTermsUrl();},
                            // ),



                          ],
                        )
                    )
                    ) ,




                ],
              )
              )
            )
            )
          ),



       );

  }

