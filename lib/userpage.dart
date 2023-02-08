import 'package:flutter/material.dart';

class Userdata {
  final String name;
  final String phone;
  final String otp;


  Userdata(this.name,this.phone,this.otp);

  //constructor that convert json to object instance
  Userdata.fromJson(Map<String, dynamic> json) : name = json['name'],phone=json['phone'],otp=json['otp'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'phone':phone,
    'otp':otp,
  };
}