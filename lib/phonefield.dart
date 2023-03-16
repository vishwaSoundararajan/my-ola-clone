import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myolaapp/phonedetails.dart';
import 'package:myolaapp/welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyPhone extends StatefulWidget {
  const MyPhone ({super.key});

  @override
  _MyPhoneState createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final phone_controller=TextEditingController();
  final _olasdkPlugin=Fluttersdkplugin();

  late SharedPreferences shared;
  late bool newuser;
  GlobalKey<FormState> _formKey = GlobalKey();
  ondeviceRegister(){
    _olasdkPlugin.onDeviceUserRegister('123','vishwa','24','abc@gmail.com','9893839383','Male','fLv2jmc6QR2g_WPGgRZTku:APA91bGHE9e7g0q4FTovWwiJAl3OKuz2dedhx9sFBsYiYc-lLvm3fqo4CvCsOhtXAyeVhrtg8k1MRbkRSTexYM0U1','www.google.com','2/8/2005','BE',true,false,"t3kdiZureifn");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void intercall(){
    this.initState();
  }
  void check_if_already_login() async {
    shared = await SharedPreferences.getInstance();
    newuser = (shared.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyDashboard()));

    }
  }
  Future<void> storeUserData() async {

    //store the user entered data in user object
    PhoneDetails phonedetails= PhoneDetails(phone_controller.text);

    // encode / convert object into json string
    String user1 = jsonEncode(phonedetails);

    print(user1+"from store user data");

    //save the data into sharedPreferences using key-value pairs
    shared.setString('userNO', user1);

  }


  // void check_if_already_login() async {
  //   shared = await SharedPreferences.getInstance();
  //   newuser = (shared.getBool('login') ?? true);
  //
  //   print(newuser);
  //   if (newuser == false) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => MyDashboard()));
  //   }
  // }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    phone_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black, // <-- SEE HERE
          ),
          backgroundColor: Colors.white38,elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const [
                    Text('Enter Phone number for\nverification', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                //const Text('Enter Phone number for\n verification)', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
                const Text('This number will be used for all ride-related communication. You shall receive an SMS with code for verification', style: TextStyle(fontSize: 14,color: Colors.black45),),

                Container(
                  margin: EdgeInsets.fromLTRB(0,50,0,0),
                  child: IntlPhoneField(flagsButtonMargin: EdgeInsets.fromLTRB(0,3,0,0),
                    controller: phone_controller,
                    decoration: const InputDecoration(
                      enabled: false,
                      labelText: 'Phone Number',contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      border:UnderlineInputBorder(borderSide:BorderSide(color: Colors.blue) ) ,
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {

                    },
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0,375,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed:(){

                          String phone=phone_controller.text;
                          if(phone.length<10)
                            {
                              Fluttertoast.showToast(
                                gravity: ToastGravity.CENTER,
                                msg:"Enter valid Number",
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            }
                          else if (phone != '') {
                            print('Successfull');
                            //storeUserData();

                            //shared.setBool('login', false);

                            //shared.setString('userphone',phone);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const OtpVefication()));
                            ondeviceRegister();

                          }

                        },
                          style: TextButton.styleFrom(backgroundColor: Colors.black,padding: const EdgeInsets.fromLTRB(153, 0, 153, 0),),
                          child: const Text("Next", style:TextStyle(color:Colors.white,fontSize: 22)),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}

class OtpVefication extends StatefulWidget {
  const OtpVefication ({super.key});

  @override
  _MyOtpVefication createState() => _MyOtpVefication();
}

class _MyOtpVefication extends State<OtpVefication> {
  String verificationCode="";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(

          leading: const BackButton(
            color: Colors.black, // <-- SEE HERE
          ),
          backgroundColor: Colors.white38, elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const [
                    Text('Please Wait.\nWe will auto verify the OTP.',
                      style: TextStyle(
                        fontSize: 25,),),
                  ],
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: OtpTextField(
                    numberOfFields: 4,decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                    borderColor: Color(0xFF512DA8),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: false,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationcode){
                      setState(() {
                        verificationCode=verificationcode;
                      });
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Verification Code"),
                              content: Text('Code entered is $verificationcode'),

                            );
                          }
                      );
                    }, // end onSubmit
                  ),


                ),


                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 300, 0, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            if(verificationCode=="")
                            {
                              Fluttertoast.showToast(
                                gravity: ToastGravity.CENTER,
                                msg:"Enter valid OTP",
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            }
                           else if(verificationCode.length==4)
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const MainPage()));
                          },
                          style: TextButton.styleFrom(backgroundColor: Colors
                              .black,
                            padding: const EdgeInsets.fromLTRB(
                                153, 0, 140, 0),),
                          child: const Text("Verify", style: TextStyle(
                              color: Colors.white, fontSize: 22)),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
