

import 'package:flutter/material.dart';
import 'package:myolaapp/phonefield.dart';
import 'package:myolaapp/scrollPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loginPage.dart';



class TestRide extends StatefulWidget{
  const TestRide({super.key});
  @override
  _TestRide createState() => _TestRide();
}

class _TestRide extends State<TestRide> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                child:(
                    Column(
                      children: [
                        Container(
                          height:268,
                          width:398,
                          margin: EdgeInsets.fromLTRB(2,0,0,0),
                          child: Row(
                            children: [
                              Image.asset('assets/test_img2.jpeg', height: 450,
                                width:390,
                                fit: BoxFit.fitWidth,),],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                          margin: EdgeInsets.fromLTRB(8,20,12,0),
                          child: Column(
                            children:  [
                              Text('Test ride requested at your doorstep', style: TextStyle(fontSize: 25,fontWeight: FontWeight. bold,),),
                              Container(
                                padding: EdgeInsets.fromLTRB(0,15,0,0),
                                child:Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10,0,10,15),
                                      child: Icon(
                                        size:20.0 ,
                                        Icons.check,
                                        color: Colors.green[600],
                                      ),
                                    ),
                                    Expanded(child:Text('Make sure you keep your driving license handy before the test ride starts', style: TextStyle(fontSize: 15,color: Colors.black38,),),)
                                  ],
                                ) ,
                              ),
                              Container(
                                  child:(
                                      Row(

                                      )
                                  )
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0,15,0,0),
                                child:Row(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.fromLTRB(10,0,10,15),
                                      child: Icon(
                                        size:20.0 ,
                                        Icons.check,
                                        color: Colors.green[600],
                                      ),
                                    ),
                                    Expanded(child:Text('Wearing a Helmet is mandatory while taking the test ride', style: TextStyle(fontSize: 15,color: Colors.black38,),),)

                                  ],
                                ) ,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0,15,0,0),
                                child:Row(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.fromLTRB(10,0,10,15),
                                      child: Icon(
                                        size:20.0 ,
                                        Icons.check,
                                        color: Colors.green[600],
                                      ),
                                    ),
                                    Expanded(child:Text('Our team will reach out to you to confirm your slot preference', style: TextStyle(fontSize: 15,color: Colors.black38,),),)

                                  ],
                                ) ,
                              ),

                            ],


                          ),

                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                          child: Column(
                            children:  [
                              Container(
                                padding: EdgeInsets.fromLTRB(0,0,292,0),
                                child: Text('Location', style: TextStyle(fontSize: 20,fontWeight: FontWeight. bold,),),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(2,15,0,0),
                                child:Row(
                                  children: [

                                    Expanded(child:Text('Bryan Consultancy,3E,3rd Floorl PM TOWER,IDBI BANK, Greams Rd, Thousand Lights Wet, Thousand Ligbts, Chennai,Tamil Nadu 60006, India', style: TextStyle(fontSize: 15,color: Colors.black38,),),)
                                  ],
                                ) ,
                              ),
                            ],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                          child: Column(
                            children:  [
                              Container(
                                padding: EdgeInsets.fromLTRB(0,0,255,0),
                                child: Text('Preferrd slot', style: TextStyle(fontSize: 20,fontWeight: FontWeight. bold,),),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(1,15,0,0),
                                child:Row(
                                  children: [

                                    Expanded(child:Text('11 December 2PM-3PM', style: TextStyle(fontSize: 15,color: Colors.black38,),),)
                                  ],
                                ) ,
                              ),
                            ],
                          ),

                        ),
                      ],
                    )
                )
            ),
            Positioned(
              top: 10,
              right: 12,
              left: 13,
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
                        radius:25.0,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 30.0,
                          color: Colors.black,
                        ),

                      ),

                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ),

    );

  }
}