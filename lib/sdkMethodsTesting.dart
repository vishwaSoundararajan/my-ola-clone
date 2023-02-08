import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';

class SdkMethodTesting extends StatefulWidget{
  const SdkMethodTesting({super.key});

  @override
  _SdkMethodTesting createState() => _SdkMethodTesting();
}



class _SdkMethodTesting extends State<SdkMethodTesting> {
  TextEditingController controller1=TextEditingController();
  int notificationCount=0;
  var token="fWvOFlnQQYKPTw-fnWfyfX:APA91bHJBIk7Q-z9gRwbHCUPdnCj5lcqOGoI6XS3QJ0zpKJj_892MyHYSd4Hb7efz";
  final _olasdkPlugin=Fluttersdkplugin();
  String _platformVersion = 'Unknown';
  late String cid;

  @override
 void initState(){
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await _olasdkPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }
  passLocation(){
    double lat=13.0827;
    double lang=  80.2707;
    _olasdkPlugin.pushLocation(lat, lang);
  }
  newNotification(){
    var notificationTitle="sample Title";
    var notificationBody="sample BOdy";
    _olasdkPlugin.addNewNotification(notificationTitle,notificationBody);
  }
  formdataCapture(){
    Map param = {
      "Name": "vishwa",
      "EmailID": "abc@gmail.com",
      "MobileNo": 9329222922,
      "Gender": "Male",
      "formid": 101, // required
      "apikey": "e37315c0-8578-4bd2-a38a-cbba5dba8110",
      "City":"Chennai"// required
    };
    String formData = jsonEncode(param);
    _olasdkPlugin.formDataCapture(formData);
  }
  ondeviceRegister(){
    _olasdkPlugin.onDeviceUserRegister('123','vishwa','24','abc@gmail.com','9893839383','Male',token,'www.google.com','2/8/2005','BE',true,false,
    "t3kdiZureifn");
  }
  ontrackEvent(){
    var content="On Track Event called!!!";
    _olasdkPlugin.onTrackEvent(content);
  }
  updatepushToken(){
    _olasdkPlugin.updatePushToken(token);
  }
  getdeepLinkData() {
    _olasdkPlugin.deepLinkData();
  }
  deleteNotificationByCampaignid(){
    setCidState();
    _olasdkPlugin.deleteNotificationByCampaignId(cid);
  }
  setCidState(){
    setState(() {
      cid=controller1.text;

    });}
  readnotification(){
    setCidState();
    _olasdkPlugin.readNotification(cid);
  }
  appconversionTracking(){
    _olasdkPlugin.appConversionTracking();
  }
  Future<int?> readnotificationCount() async{
    var nCount=await _olasdkPlugin.readNotificationCount()!;
    setState(()  {
      notificationCount=nCount!;
    });
    if (kDebugMode) {
      print(notificationCount);
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
  home:Scaffold(
    resizeToAvoidBottomInset: true,
    body:SingleChildScrollView(
      child: ConstrainedBox(
        constraints:const BoxConstraints(),
        child:
          Container(
            child:Column(
              children:[
                SizedBox(
                  height: 50,
                ),
                ElevatedButton( onPressed: (){
                  passLocation();
                }, child: Text("Push Location"),),
                ElevatedButton( onPressed: (){//
                  newNotification();
                }, child: Text("Add New Notification"),),
                ElevatedButton( onPressed: (){//
                  formdataCapture();
                }, child: Text("form Data Capture"),),
                ElevatedButton( onPressed: (){//
                  ondeviceRegister();
                }, child: Text("On Device User Register"),),
                ElevatedButton( onPressed: (){
                  ontrackEvent();
                }, child: Text("On Track Event"),),
                TextField(
                  controller: controller1,
                  onTap: (){
                    setState(() {
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter ID",

                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),),
                ElevatedButton( onPressed: (){
                  deleteNotificationByCampaignid();
                }, child: Text("delete Notification By Campaignid"),),
                ElevatedButton( onPressed: (){
                  readnotification();
                }, child: Text("read Notification"),),
                ElevatedButton( onPressed: (){
                  appconversionTracking();
                }, child: Text("app Conversion Tracking"),),
                ElevatedButton( onPressed: (){
                  readnotificationCount();
                }, child: Text("read Notification Count"),),
                ElevatedButton( onPressed: (){
                  updatepushToken();
                }, child: Text("update Push Token"),),
                ElevatedButton( onPressed: (){
                  getdeepLinkData();
                }, child: Text("Get deepLinkData"),),
              ]
            )
          )
      ),
    ) ,
  )
);
  }

}
