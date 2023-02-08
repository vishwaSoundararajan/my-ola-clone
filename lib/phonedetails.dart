import 'package:flutter/material.dart';

class PhoneDetails {
  final String phone;



  PhoneDetails(this.phone);

  //constructor that convert json to object instance
  PhoneDetails.fromJson(Map<String, dynamic> json) : phone=json['phone'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {

    'phone':phone,

  };
}