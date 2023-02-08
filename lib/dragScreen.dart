import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:myolaapp/pickuppage.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:myolaapp/scrollscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'confirmationpage.dart';
import 'main.dart';


class CabListing extends StatefulWidget {
  const CabListing({super.key});

  @override
  _CabListing createState() => _CabListing();
}

class _CabListing extends State<CabListing> {
  late SharedPreferences shared;

  void bookMyCar(String ct,String rp)async {
    shared=await SharedPreferences.getInstance();
    //store the user entered data in user object
    BookingDetails bookcar= BookingDetails(ct, rp);

    // encode / convert object into json string
    String user = jsonEncode(bookcar);

    print(user+"from store user data");

    //save the data into sharedPreferences using key-value pairs
    shared.setString('bookingdata', user);

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(

          children: [
            Container(
              color: Colors.black,
            ),

            //for navigation arrow
            Positioned(
              top: 15,
              right: 15,
              left: 15,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children:  <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const SearchPage()));
                      },
                      icon:const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20.0,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 25.0,
                          color: Colors.black,
                        ),

                      ),

                    )
                  ],
                ),
              ),
            ),

            Positioned(
              top: 300,
              right: 15,
              left: 300,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children:  <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const SearchPage()));
                      },
                      icon:const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20.0,
                        child: Icon(
                          Icons.zoom_in_map,
                          size: 20.0,
                          color: Colors.black,
                        ),

                      ),

                    )
                  ],
                ),
              ),
            ),
//for naviagation arrow
            DraggableScrollableSheet(
                initialChildSize:0.25,
                maxChildSize:0.75,
                builder:(BuildContext context,ScrollController scrollController){
                  return Container(
                      color: Colors.white,
                      child: ListView(
                        physics:ClampingScrollPhysics(),
                        controller:scrollController,

                        children: [


                          Container(
                            margin: EdgeInsets.fromLTRB(0,0,0,0),
                            padding: EdgeInsets.fromLTRB(10,0,10,0),
                            height:100 ,
                            width:double.infinity,

                            decoration: const BoxDecoration(

                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 0.10,
                                  spreadRadius: 1.0,
                                  offset: Offset(0.0,0.0), // shadow direction: bottom right
                                )
                              ],
                            ),

                            child:Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0,20,0,0),
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),

                                    Container(
                                        margin: const EdgeInsets.fromLTRB(0,8,0,6),
                                        color: Colors.black26,
                                        child:const SizedBox(
                                          height:30 ,
                                          width: 2,
                                        )
                                    ),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      margin: EdgeInsets.fromLTRB(0,0,0,0),
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 280,
                                      height: 40,
                                      margin:  EdgeInsets.fromLTRB(14,4,0,0),
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:const TextField(
                                        onChanged: null,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.go,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 15),
                                            hintText: "Search for an address or landmark",suffixStyle: TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                    Container(
                                      margin:  EdgeInsets.fromLTRB(20,7,0,0),
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      color: Colors.black12,
                                      child: const SizedBox(
                                        width:280,
                                        height:0.50,
                                      ),
                                    ),
                                    Container(
                                      width: 280,
                                      height: 40,
                                      margin:  EdgeInsets.fromLTRB(14,4,0,0),
                                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:const TextField(
                                        onChanged: null,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.go,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 15),
                                            hintText: "Enter Destination",suffixStyle: TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 70,
                                        margin: EdgeInsets.fromLTRB(5,14,0,0),
                                        padding: EdgeInsets.fromLTRB(0,0,0,0),
                                        decoration:  BoxDecoration(
                                          shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(8.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 0.30,
                                              spreadRadius: 1.0,
                                              offset: Offset(0.0,0.0), // shadow direction: bottom right
                                            )
                                          ],
                                          color: Colors.white,
                                        ),
                                        child:Column(
                                          children: const [
                                            IconButton(
                                              splashColor: Colors.black,
                                              icon: Icon(Icons.alarm),
                                              onPressed:null,
                                            ),
                                            Text("Now",style: TextStyle(fontSize: 12,color: Colors.black),)
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //search bar
                          const SizedBox(
                            height:20,
                            width:100,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(children: const [
                              Text("Recomended for you",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),)
                            ],),
                          ),
                          Container(
                            child: Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const RideConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("MiniCar","720Rs");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d2.png',
                                          width: 15,
                                          height: 15,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text('2min', style: TextStyle(
                                            color: Colors.black))
                                      ],
                                    ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(50, 0, 89, 0),
                                        child: Column(
                                          children: const [
                                            Text('Book Any', style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,)),
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
                            ) ,
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const RideConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Auto","470.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d4.png',
                                          width: 25,
                                          height: 25,
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
                          ),
                          Container(
                            child: Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const RideConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Mini Car","510.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d2.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text('2min', style: TextStyle(
                                            color: Colors.black))
                                      ],
                                    ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(50, 0, 101, 0),
                                        child: Column(
                                          children: const [
                                            Text('Mini Car', style: TextStyle(color: Colors.black,
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
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const RideConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Auto","470.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d4.png',
                                          width: 25,
                                          height: 25,
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
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const RideConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Minicar","510.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d2.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        Text('2min', style: TextStyle(color: Colors.black))
                                      ],
                                    ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(50, 0, 101, 0),
                                        child: Column(
                                          children: const [
                                            Text('Mini Car', style: TextStyle(color: Colors.black,
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
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Bike","200.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white60,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d1.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text('2min', style: TextStyle(
                                            color: Colors.black))
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
                                          Text('200.RS', style: TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                    ],))
                              ],
                            ),
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Sedan","750.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d5.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text('2min', style: TextStyle(
                                            color: Colors.black))
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
                                          Text('750.RS', style: TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                    ],))
                              ],
                            ),
                          ),
                          Container(
                            child:   Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Minicar","510.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d3.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text('2min', style: TextStyle(
                                            color: Colors.black))
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
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Auto","470.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d4.png',
                                          width: 25,
                                          height: 25,
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
                          ),
                          Container(
                            child:  Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Mini Car","510.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d2.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text('2min', style: TextStyle(
                                            color: Colors.black))
                                      ],
                                    ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(50, 0, 101, 0),
                                        child: Column(
                                          children: const [
                                            Text('Mini Car', style: TextStyle(color: Colors.black,
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
                          ),
                          Container(
                            child: Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Auto", "470.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d4.png',
                                          width: 25,
                                          height: 25,
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
                          ),
                          Container(
                            child:Row(
                              children: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ConfirmationPage();
                                    },
                                  ));
                                  bookMyCar("Minicar","750.RS");
                                },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white54,),
                                    child: Row(children: [Column(
                                      children: [
                                        Image.asset(
                                          'assets/d2.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                        Text('2min', style: TextStyle(color: Colors.black))
                                      ],
                                    ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(50, 0, 101, 0),
                                        child: Column(
                                          children: const [
                                            Text('Mini Car', style: TextStyle(color: Colors.black,
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
                            )
                          )


                        ],
                      )
                  );

                }
            ),

     Container(
       margin:EdgeInsets.fromLTRB(0, 670, 0, 0),
       color:Colors.white,
       child:  Column(
         children: [
           Container(
             color:Colors.white,
             child: Row(
               children: [
                 Container(
                   margin:EdgeInsets.fromLTRB(0,0,0,0),
                   height: 45,
                   width: 123,

                     child: Card(
                       // shape: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black)),
                       margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

                       child: ListTile(
                         leading: Icon(

                           Icons.money,
                           color: Colors.green[600],
                         ),
                         title:TextButton(
                           onPressed: (){
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                          context: context,
                           builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0,0,0,0),
                              padding: EdgeInsets.fromLTRB(0,0,0,0),
                                height: MediaQuery.of(context).size.height * 0.75,
                               color: Colors.white,
                              width:double.maxFinite,
                              child:Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0,20,120,0),
                                    child: Text("Select payment mode ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20,0,0,0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                    value: "Home",
                                                    groupValue: "Hom",
                                                    onChanged: (value){
                                                      print(value); //selected value
                                                    }
                                                ),

                                                Image.asset(
                                                  'assets/cash_0.jpeg',
                                                  width: 15,
                                                  height: 15,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  width:10,
                                                ),
                                                Text("Cash"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                    value: "Home",
                                                    groupValue: "Hom",
                                                    onChanged: (value){
                                                      print(value); //selected value
                                                    }
                                                ),
                                                Image.asset(
                                                  'assets/img_1.png',
                                                  width: 15,
                                                  height: 15,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  width:10,
                                                ),
                                                Text('Google Pay')
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                    value: "Home",
                                                    groupValue: "Hom",
                                                    onChanged: (value){
                                                      print(value); //selected value
                                                    }
                                                ),
                                                Text("Ola Money Wallet"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0,20,150,0),
                                          child: Text("Add Payment method",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                        ),
                                            Container(
                                               padding: EdgeInsets.fromLTRB(0,0,20,0),
                                                child: Column(
                                                   children:  [

                                                Card(
                                                child: ListTile(
                                                leading: Image.asset(
                                                  'assets/paytm_pic.png',
                                                  width: 20,
                                                  height: 25,
                                                  fit: BoxFit.cover,
                                                ),
                                              title: Text('Add Paytm Wallet'),
                                              trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                                )
                                                ),
                                                     Container(
                                                       child: Card(

                                                           child: ListTile(

                                                             leading: Image.asset(
                                                               'assets/phonepe_pic.png',
                                                               width: 20,
                                                               height: 25,
                                                               fit: BoxFit.cover,
                                                             ),
                                                             title: Text('Add PhonePe Wallet'),
                                                             trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                                           )
                                                       ),
                                                     ),

                                                     Card(

                                                         child: ListTile(
                                                           leading: Icon(
                                                                 Icons.credit_card,
                                                                 color: Colors.blue[600],
                                                             ),
                                                           title: Text('Add a Credit/Debit Card'),
                                                           trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                                         )
                                                     ),
                                                     Card(
                                                         child: ListTile(
                                                           leading: Icon(
                                                                    Icons.add,
                                                                     color: Colors.blue[600],
                                                                      ),
                                                           title: Text('Add more Ola Money'),
                                                           trailing: Icon(Icons.keyboard_arrow_right_outlined),
                                                         )
                                                     ),
                                                     SizedBox(
                                                       height:30,
                                                     ),
                                                     Container(
                                                         height:45,
                                                         color: Colors.white,
                                                         margin: EdgeInsets.fromLTRB(5,0,5,0),

                                                         child: Expanded(
                                                           child: Row(

                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             children: [
                                                               TextButton(onPressed:null, style: TextButton.styleFrom(backgroundColor: Colors.black,padding: const EdgeInsets.fromLTRB(145, 15, 145, 15)), child: const Text("Confirm", style:TextStyle(color:Colors.white)),),


                                                             ],
                                                           ),
                                                         )
                                                     )
                                                   ]
                                                )
                                            ),


                                      ],
                                    ),
                                  )


                                ],
                              )



                            );

                           }
                          );

                           },
                           child:  Text('Cash',style:TextStyle(color:Colors.black)),
                         ),
                         visualDensity: VisualDensity(vertical: -4),
                           minLeadingWidth:20,
                       ),
                     ),


                 ),
                 Container(
                     margin: const EdgeInsets.fromLTRB(0,8,0,6),
                     color: Colors.black26,
                     child: SizedBox(
                       height:30 ,
                       width: 1,

                     )
                 ),
                 Container(

                   margin:EdgeInsets.fromLTRB(0,0,0,0),
                   height: 45,
                   width: 135,

                   child: Card(
                     // shape: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black)),
                     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

                       child: ListTile(
                       leading:Icon(
                         Icons.local_offer,
                         color: Colors.green[600],
                       ),
                        title:
                         TextButton(
                           onPressed: (){
                             showModalBottomSheet<void>(
                               context: context,
                               builder: (BuildContext context) {
                                 return Container(
                                   padding: EdgeInsets.fromLTRB(15,0,0,0),
                                   height: 150,
                                   color: Colors.white,
                                   child: Center(
                                     child: Column(
                                       children: [
                                         Container(

                                           margin:EdgeInsets.fromLTRB(0,0,0,0),
                                           color:Colors.white,
                                           height: 50,
                                           width:600,

                                           child:Column(
                                             children: [
                                               TextField(
                                                 decoration: InputDecoration(hintText: "Enter Coupon Code",),style: TextStyle(color: Colors.blue),
                                               )
                                             ],
                                           ),
                                         ),

                                         SizedBox(
                                           height: 20,
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
                                                           backgroundColor: Colors.white10,),
                                                         child: const Text('Cancel',style: TextStyle(color: Colors.black)),
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
                                                           backgroundColor: Colors.black38,),
                                                         child: const Text('Apply',style: TextStyle(color: Colors.white),),
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
                           child:Text('coupon',style: TextStyle(color: Colors.black),),
                         ),
                         visualDensity: VisualDensity(vertical: -4),
                          minLeadingWidth:20,
                         ),
                        ),
                   ),
                 Container(
                     margin: const EdgeInsets.fromLTRB(0,8,0,6),
                     color: Colors.black26,
                     child:const SizedBox(
                       height:30 ,
                       width: 2,
                     )
                 ),
                 Container(
                   height: 45,
                   width: 131,
                   margin:EdgeInsets.fromLTRB(0,0,0,0),
                   color: Colors.white,
                   child: ListTile(
                     leading:Icon(
                       Icons.perm_identity,
                       color: Colors.black,
                     ),
                     title:TextButton(
                       onPressed:(){
                         showModalBottomSheet<void>(
                           isScrollControlled: true,
                           context: context,
                           builder: (BuildContext context) {

                             return Container(
                                // height: MediaQuery.of(context).size.height * 0.5,
                               padding: EdgeInsets.fromLTRB(15,0,0,0),
                               height: 300,
                               color: Colors.white,
                               child: Center(
                                 child: Column(
                                   children: [
                                     Container(
                                       padding: EdgeInsets.fromLTRB(0,15,0,0),
                                       child: Row(

                                         children: const [
                                           Text("Someone else taking this ride?",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                         ],
                                       ),
                                     ),
                                     Container(
                                       padding: EdgeInsets.fromLTRB(3,10,0,0),
                                       child: Row(
                                         children: const [
                                           Text("Choose a contact so that they also get driver number,\nvehicle details and ride OTP via SMS"),
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
                                                     Icon(
                                                       Icons.perm_identity,
                                                       color: Colors.blue[600],
                                                     ),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text('Myself')
                                                   ],
                                                 ),
                                                 SizedBox(
                                                   width:50
                                                 ),


                                               ]
                                           ),
                                         ],
                                       ),
                                     ),
                                     SizedBox(
                                       height: 20,
                                     ),
                                     Container(
                                       margin:EdgeInsets.fromLTRB(48,0,0,0),
                                       child:    Row(
                                         children: [
                                           Icon(
                                             Icons.contacts_rounded,
                                             color: Colors.blue[600],
                                           ),
                                           SizedBox(
                                             width: 10,
                                           ),
                                           Text('Choose another contact',style: TextStyle(color: Colors.blue),)
                                         ],
                                       ),
                                     ),
                                     SizedBox(
                                       height: 20,
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
                       child:   Text('Myself',style:TextStyle(color:Colors.black)),
                     ),

                     visualDensity: VisualDensity(vertical: -4),
                     minLeadingWidth:20,
                   ),
                 )
               ],

             ) ,
           ),
           Container(
             height:45,
            color: Colors.white,
             margin: EdgeInsets.fromLTRB(5,0,5,0),

             child: Expanded(
               child: Row(

                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   TextButton(onPressed:null, style: TextButton.styleFrom(backgroundColor: Colors.black,padding: const EdgeInsets.fromLTRB(155, 15, 155, 15)), child: const Text("Book Ride", style:TextStyle(color:Colors.white)),),


                 ],
               ),
             )
           )

         ],
       ),


     )

          ],),
      ),
    );
  }
}
