import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:myolaapp/scrollscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myolaapp/main.dart';

import 'loginPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();


  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
      print('Your name: $username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/greetlogo.jpeg', height: 450,
            width: 500,
            fit: BoxFit.fitWidth,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text('Welcome to Ola', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children:  [
          //     Text('$username', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
          //   ],
          // ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Have a hassle-free booking experience by giving \nus the following permissions.', style: TextStyle(fontSize: 14,color: Colors.black45,),)
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          Container(

            child: (
            Column(
              children: [
                Row(
                  children:[
                    Padding(padding: EdgeInsets.fromLTRB(51,0,0,0)),
                    Column(
                    children:  [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                          width:30
                      ),

                    ],
                  ),
                    Column(

                      children: [Text('Location(for finding available riders)', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black87),)

                      ],
                    ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width:10
                    ),
                    Column(
                      children: const [Text('Phone for account security verification)', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black87),)

                      ],
                    ),
                  ],),

              ],
            )
            ),

          ),

          const SizedBox(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  logindata.setBool('login', true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const FirstPage()));
                },
                child: const Text('LogOut'),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed:(){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> SearchPage()));
              }, style: TextButton.styleFrom(backgroundColor: Colors.black,padding: const EdgeInsets.fromLTRB(160, 0, 160, 0),), child: const Text("Allow", style:TextStyle(color:Colors.yellowAccent,fontSize: 22)),),
            ],
          ),

        ],

      ),
    );
  }

}