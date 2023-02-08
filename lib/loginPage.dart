import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myolaapp/main.dart';
import 'package:myolaapp/userpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcomePage.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final phone_controller=TextEditingController();
  final otp_controller = TextEditingController();

  late SharedPreferences shared;
  late bool newuser;

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
    Userdata userdata1= Userdata(username_controller.text,phone_controller.text,otp_controller.text);

    // encode / convert object into json string
    String user = jsonEncode(userdata1);

    print(user+"from store user data");

    //save the data into sharedPreferences using key-value pairs
    shared.setString('userdata1', user);

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    phone_controller.dispose();
    otp_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Ola"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
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
                const Text('This number will be used for all ride-related communication. You shall receive an SMS with code for verification.)', style: TextStyle(fontSize: 14,color: Colors.black45),),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: username_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',

                    ),
                    keyboardType: TextInputType.name,
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: phone_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.phone,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: otp_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'OTP',
                    ),
                  ),
                ),
                ElevatedButton(
                  // textColor: Colors.white,
                  // color: Colors.blue,
                  onPressed: () {
                    String username = username_controller.text;
                    String otp = otp_controller.text;
                    String phone=phone_controller.text;
                    if (username != '' && otp != '' && phone != '') {
                      print('Successfull');
                      storeUserData();
                      shared.setBool('login', false);

                      shared.setString('username', username);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const MyDashboard()));
                    }
                  },
                  child: const Text("Log-In"),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}