
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/widget/background1.dart';

class mul extends StatefulWidget {
  const mul({Key? key}) : super(key: key);

  @override
  _mulState createState() => _mulState();
}

class _mulState extends State<mul> {

  final interval = const Duration(seconds: 1);

  bool condition = false;
  bool condition1 = true;

  int timerMaxSeconds = 600;
  String points = "175";
  String question = "blahblahblah";
  String image = "";
  String answer1 = "answer1";
  String answer2 = "answer2";
  String answer3 = "answer3";
  String answer4 = "answer4";
  int R1 = 255;
  int R2 = 255;
  int R3 = 255;
  int R4 = 255;
  int G1 = 255;
  int G2 = 255;
  int G3 = 255;
  int G4 = 255;
  int B1 = 255;
  int B2 = 255;
  int B3 = 255;
  int B4 = 255;

  int Z1 = 0;
  int Z2 = 0;
  int Z3 = 0;
  int Z4 = 0;
  int rnb = 1;
  int mnb = 0;
  String name1 = "";
  String name2 = "";
  String name3 = "";
  String name4 = "";
  String char1 = "char1";
  String char2 = "char1";
  String char3 = "char1";
  String char4 = "char1";
  String point1 = "10";
  String point2 = "10";
  String point3 = "10";
  String point4 = "10";
  double q1 = 0.3;
  double q2 = 0.3;
  double q3 = 0.3;
  double q4 = 0.3;
  double q5 = 0.3;


  int currentSeconds = 0;
  int currentMinutes = 0;
  int timerMaxMinutes = 10;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(
          2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60)
          .toString()
          .padLeft(2, '0')}';


  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds && currentMinutes < 1) timer.cancel();
      });
    });
  }


  @override
  void initState() {
    startTimeout();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          BackgroundImage1(),
          Center(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(200, 100),
                  //Size.fromHeight(100.0), // here the desired height
                  child: AppBar(
                    automaticallyImplyLeading: false, // hides leading widget
                    flexibleSpace:
                    Stack(alignment: Alignment.centerRight,
                        children: [
                          Container(color: Color.fromARGB(253, 247, 210, 210),),
                          Container(color: Colors.deepOrangeAccent,
                            width: (455 * 3 - currentSeconds).toDouble() *
                                0.3,),
                          Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.transparent,
                            width: 400,


                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(children: [SizedBox(height: 50),
                                    Center(
                                      child: Container(width: 400,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          //mainAxisSize: MainAxisSize,
                                          children: <Widget>[Stack(
                                              children: [
                                                Container(width: 135,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        borderRadius: BorderRadius
                                                            .circular(10)),
                                                    child: Column(children: [
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                              75, 9.0, 9.0, 10),
                                                          alignment: Alignment
                                                              .center,
                                                          child: Center(
                                                              child: Text(
                                                                  timerText,
                                                                  textAlign: TextAlign
                                                                      .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white))))
                                                    ],)),
                                                Container(width: 70,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red
                                                            .withOpacity(0.7),
                                                        borderRadius: BorderRadius
                                                            .circular(10)),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, children: [
                                                        Icon(Icons.pause,
                                                          color: Colors.white,),
                                                        InkWell(
                                                            child: Container(
                                                                child: Text(
                                                                  "وقف  ",
                                                                  style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Colors
                                                                          .white),)),
                                                            onTap: () {
                                                              print(
                                                                  "Tapped on container");
                                                            }

                                                        ),
                                                      ],),
                                                    )),

                                              ]
                                          ), SizedBox(width: 250,),


                                          ],

                                        ),
                                      ),),
                                  ],
                                  ),
                                  //Container(width:160)
                                ]
                            ),
                          ),

                          //backgroundColor: Color.fromARGB(253, 247, 210, 210),
                        ]),),),
                bottomNavigationBar: condition ? InkWell(
                  child: Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.tealAccent),
                      alignment: Alignment.center,
                      height: 70, child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_outlined, size: 25,),
                          Text(' كمل', style: TextStyle(fontSize: 25),),


                        ],
                      )

                  ), onTap: () {
                  print("to complete");
                  print(rnb);
                  print(mnb);
                  if (mnb == rnb) {
                    print("eeeee");
                    setState(() {
                      if (mnb == 1) {
                        R1 = 84;
                        G1 = 255;
                        B1 = 118;
                      }
                      if (mnb == 2) {
                        R2 = 84;
                        G2 = 255;
                        B2 = 118;
                      }
                      if (mnb == 3) {
                        R3 = 84;
                        G3 = 255;
                        B3 = 118;
                      }
                      if (mnb == 4) {
                        R4 = 84;
                        G4 = 255;
                        B4 = 118;
                      }
                    }
                    );
                  }


                  else {
                    setState(() {
                      print("eeeee");
                      setState(() {
                        if (rnb == 1) {
                          R1 = 217;
                          G1 = 135;
                          B1 = 76;
                        }
                        if (rnb == 2) {
                          R2 = 217;
                          G2 = 135;
                          B2 = 76;
                        }
                        if (rnb == 3) {
                          R3 = 217;
                          G3 = 135;
                          B3 = 76;
                        }
                        if (rnb == 4) {
                          R4 = 217;
                          G4 = 135;
                          B4 = 76;
                        }
                      }
                      );
                    }

                    );
                  }
                },
                ) : null,
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 70,
                                height: 6,
                                color: Colors.white.withOpacity(q1),),
                              Container(
                                  width: 2, height: 6, color: Colors.white),
                              Container(width: 70,
                                height: 6,
                                color: Colors.white.withOpacity(q2),),
                              Container(
                                  width: 2, height: 6, color: Colors.white),
                              Container(width: 70,
                                height: 6,
                                color: Colors.white.withOpacity(q3),),
                              Container(
                                  width: 2, height: 6, color: Colors.white),
                              Container(width: 70,
                                height: 6,
                                color: Colors.white.withOpacity(q4),),
                              Container(
                                  width: 2, height: 6, color: Colors.white),
                              Container(width: 70,
                                height: 6,
                                color: Colors.white.withOpacity(q5),),

                            ]),),
                        Center(child:
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: Stack(alignment: Alignment.center,
                                children: [
                                  Center(child: Container(child: Image.asset(
                                    'assets/images/' + char1 + '.png',
                                    color: Color.fromRGBO(
                                        255, 255, 255, double.parse("10")),
                                    colorBlendMode: BlendMode.modulate,
                                    width: 80,
                                    height: 80,
                                  ),
                                    width: 80,
                                    height: 80,
                                  ),),
                                  Column(mainAxisAlignment: MainAxisAlignment
                                      .center,
                                      children: [ SizedBox(height: 80), Center(
                                        child: Container(
                                            padding: EdgeInsets.all(1),
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        15),
                                                    bottomRight: Radius
                                                        .circular(15),
                                                    topLeft: Radius.circular(
                                                        15),
                                                    topRight: Radius.circular(
                                                        15)),
                                                color: Colors.black),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center, children: [
                                              Container(child: Text(name1,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w800),)),

                                            ],)),
                                      ),
                                        SizedBox(height: 5),
                                        Container(child: Text(point1,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w700)))
                                      ]),
                                ]),), SizedBox(width: 20,
                            ),
                            Container(child: Stack(alignment: Alignment.center,
                                children: [
                                  Center(child: Container(child: Image.asset(
                                    'assets/images/' + char2 + '.png',
                                    color: Color.fromRGBO(
                                        255, 255, 255, double.parse("10")),
                                    colorBlendMode: BlendMode.modulate,

                                    width: 80,
                                    height: 80,
                                  ),
                                    width: 80,
                                    height: 80,
                                  ),),
                                  Column(mainAxisAlignment: MainAxisAlignment
                                      .center,
                                      children: [ SizedBox(height: 80), Center(
                                        child: Container(
                                            padding: EdgeInsets.all(1),
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        15),
                                                    bottomRight: Radius
                                                        .circular(15),
                                                    topLeft: Radius.circular(
                                                        15),
                                                    topRight: Radius.circular(
                                                        15)),
                                                color: Colors.black),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center, children: [
                                              Container(child: Text(name2,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w800),)),

                                            ],)),
                                      ), SizedBox(height: 5),
                                        Container(child: Text(point2,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w700)))

                                      ]),
                                ]),),
                            SizedBox(width: 20,
                            ),
                            Container(child: Stack(alignment: Alignment.center,
                                children: [
                                  Center(child: Container(child: Image.asset(
                                    'assets/images/' + char3 + '.png',
                                    color: Color.fromRGBO(
                                        255, 255, 255, double.parse("10")),
                                    colorBlendMode: BlendMode.modulate,
                                    width: 80,
                                    height: 80,
                                  ),
                                    width: 80,
                                    height: 80,
                                  ),),
                                  Column(mainAxisAlignment: MainAxisAlignment
                                      .center,
                                      children: [ SizedBox(height: 80), Center(
                                        child: Container(
                                            padding: EdgeInsets.all(1),
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        15),
                                                    bottomRight: Radius
                                                        .circular(15),
                                                    topLeft: Radius.circular(
                                                        15),
                                                    topRight: Radius.circular(
                                                        15)),
                                                color: Colors.black),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center, children: [
                                              Container(child: Text(name3,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w800),)),

                                            ],)),
                                      ),
                                        SizedBox(height: 5),
                                        Container(child: Text(point3,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w700)))
                                      ]),
                                ]),), SizedBox(width: 20,
                            ),
                            Container(child: Stack(alignment: Alignment.center,
                                children: [
                                  Center(child: Container(child: Image.asset(
                                    'assets/images/' + char4 + '.png',
                                    color: Color.fromRGBO(
                                        255, 255, 255, double.parse("10")),
                                    colorBlendMode: BlendMode.modulate,
                                    width: 80,
                                    height: 80,
                                  ),
                                    width: 80,
                                    height: 80,
                                  ),),
                                  Column(mainAxisAlignment: MainAxisAlignment
                                      .center,
                                      children: [ SizedBox(height: 80), Center(
                                        child: Container(
                                            padding: EdgeInsets.all(1),
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        15),
                                                    bottomRight: Radius
                                                        .circular(15),
                                                    topLeft: Radius.circular(
                                                        15),
                                                    topRight: Radius.circular(
                                                        15)),
                                                color: Colors.black),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center, children: [
                                              Container(child: Text(name4,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight
                                                        .w800),)),

                                            ],)),
                                      ),
                                        SizedBox(height: 5),
                                        Container(child: Text(point4,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w700)))
                                      ]),
                                ]),),
                          ],),
                        ),
                        SizedBox(height: 00),
                        Stack(
                            children: [ Container(width: 280,
                              height: 370,
                              decoration: BoxDecoration(image: DecorationImage(
                                image: new ExactAssetImage(
                                  'assets/images/white.png',),

                              ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Container(child: Text(question,
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.w600),),),
                                    SizedBox(height: 20,),
                                    Container(child: Image.asset(
                                      'assets/images/' + image + ".png",
                                      width: 70,
                                      height: 70,
                                    ),
                                      width: 70,
                                      height: 70,
                                    ),
                                    SizedBox(height: 10,),
                                    Center(child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, R1, G1, B1),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,

                                          ),),
                                        width: 180,
                                        height: 40,
                                        child: Text(
                                          answer1, textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, Z1, Z1, Z1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),),),
                                      onTap: () {
                                        print("answer1");

                                        setState(() {
                                          if (condition1 == true) {
                                            condition1 = false;
                                            condition = true;
                                            R1 = 139;
                                            G1 = 109;
                                            B1 = 244;
                                            Z1 = 255;
                                            mnb = 1;
                                          }
                                        }
                                        );
                                      },
                                    )
                                    ),
                                    SizedBox(height: 10,),
                                    Center(child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, R2, G2, B2),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,

                                          ),),
                                        width: 180,
                                        height: 40,
                                        child: Text(
                                          answer2, textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, Z2, Z2, Z2),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),),),
                                      onTap: () {
                                        print("answer2");

                                        setState(() {
                                          if (condition1 == true) {
                                            condition1 = false;
                                            condition = true;
                                            R2 = 139;
                                            G2 = 109;
                                            B2 = 244;
                                            Z2 = 255;
                                            mnb = 2;
                                          }
                                        }
                                        );
                                      },

                                    )),
                                    SizedBox(height: 10,),
                                    Center(child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, R3, G3, B3),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,

                                          ),),
                                        width: 180,
                                        height: 40,
                                        child: Text(
                                          answer3, textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, Z3, Z3, Z3),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),),)
                                      , onTap: () {
                                      print("answer3");

                                      setState(() {
                                        if (condition1 == true) {
                                          condition1 = false;
                                          condition = true;
                                          R3 = 139;
                                          G3 = 109;
                                          B3 = 244;
                                          Z3 = 255;
                                          mnb = 3;
                                        }
                                      }
                                      );
                                    },
                                    )),
                                    SizedBox(height: 10,),
                                    Center(child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, R4, G4, B4),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,

                                          ),),
                                        width: 180,
                                        height: 40,
                                        child: Text(
                                          answer4, textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, Z4, Z4, Z4),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),),)
                                      , onTap: () {
                                      print("answer4");

                                      setState(() {
                                        if (condition1 == true) {
                                          condition1 = false;
                                          condition = true;
                                          R4 = 139;
                                          G4 = 109;
                                          B4 = 244;
                                          Z4 = 255;
                                          mnb = 4;
                                        }
                                      }
                                      );
                                    },
                                    )),
                                    SizedBox(height: 10,)

                                  ]),),

                            ]
                        )
                      ]
                  ),
                ),
              )
          ),


        ],
      );
  }
}