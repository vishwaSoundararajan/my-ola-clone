

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:myolaapp/scrollPage.dart';


final _olasdkPlugin=Fluttersdkplugin();

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

void defaultNavigate(){

  const SearchPage();

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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 50,
            width: double.infinity,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0,0,300,0),
            child:(
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 30,
            child: Icon(
              Icons.person,
              size: 50.0,
              color: Colors.white,
            ),
           )
            ),
          ),
          ListTile(
            leading: Text('My Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
            onTap: () => {
              formdataCapture()
            },
          ),

          ListTile(
            leading: const Icon(Icons.electric_bolt),
            title: const Text('Electric'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.more_time_outlined),
            title: const Text('Your Rides'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.money_rounded),
            title: const Text('Ola Money'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_sharp),
            title: const Text('Payments'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(

            leading: const Icon(Icons.safety_check_rounded),
            title: const Text('Insurance'),
            onTap: () => {Navigator.of(context).pop()},
            trailing:ClipOval(
              child:  Container(
                height: 30,
                width:40,
                color: Colors.red,
                child: const Center(
                  child: Icon(Icons.fiber_new_outlined,color: Colors.white,),
                ),
              ),
            )
              //Icon(Icons.fiber_new_rounded),
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () => {Navigator.of(context).pop()},
              trailing:Text("5.7.7"),
          ),

        ],
      ),
    );
  }
}
