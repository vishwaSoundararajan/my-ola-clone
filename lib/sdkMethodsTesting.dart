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
  unreadNotification() {
    setCidState();
    _olasdkPlugin.unReadNotification(cid);
  }
  readnotification(){
    setCidState();
    _olasdkPlugin.readNotification(cid);
  }
  customevent(){
    var data = {
      "name": "payment",
      "data": {"id": "2d43", "price": "477"}
    };
    String eventData = jsonEncode(data);
    _olasdkPlugin.customevent(eventData,"Custom Event");
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
              children: [
                Center(
                  child: Text('Running on: $_platformVersion\n'),
                ),
                // Center(
                //   child: Text('Data Passed from NativeCode: $data!'),
                // ),
                SizedBox(
                  width:double.infinity,
                  child:  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () { //
                    ondeviceRegister();
                    }, child: Text("On Device User Register"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    updatepushToken();
                  }, child: Text("update Push Token"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    passLocation();
                  }, child: Text("Update Location"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                      newNotification();
                    },child: Text("Add New Notification"),),
                ),
                TextField(
                  controller: controller1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter ID",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),),
                SizedBox(
                  width:double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    readnotification();
                  }, child: Text("Read Notification By Id"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    _olasdkPlugin.getNotification();
                  }, child: Text("Get Notifications"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    unreadNotification();
                  }, child: Text("Un Read Notification"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    readnotificationCount();
                  }, child: const Text("Read Notification Count"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    deleteNotificationByCampaignid();
                    setState(() {
                      controller1.clear();
                    });
                  }, child: Text("Delete Notification By CampaignId"),),
                ),

                SizedBox(
                  width:double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    formdataCapture();
                  }, child: Text("form Data Capture"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    ontrackEvent();
                  }, child: Text("On Track Event"),),
                ),
                SizedBox(
                  width:double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    appconversionTracking();
                  }, child: Text("app Conversion Tracking"),),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),);
                    getdeepLinkData();
                  }, child: Text("Get deepLinkData"),),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey // Background color
                    ),
                    onPressed: () {
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),);
                    customevent();
                  }, child: Text("CustomEvent"),),
                ),


              ],
            ),
          )
      ),
    ) ,
  )
);
  }

}
