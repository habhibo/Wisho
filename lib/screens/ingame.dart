// @dart=2.9

import 'package:audioplayers/audioplayers.dart';

import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wechou/models/adhelpers.dart';
import 'package:wechou/models/helpers.dart';

import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/quitgame.dart';
import 'package:wechou/screens/win.dart';
import 'package:wechou/widget/background1.dart';
import 'package:wechou/widget/background5.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class ingame extends StatefulWidget {


  @override
  _ingameState createState() => _ingameState();
}
AnimationController _animationIconController1;

AudioCache audioCache;

AudioPlayer audioPlayer;

//int _duration = new Duration();
//int _position = new Duration();

bool issongplaying = false;

bool isplaying = false;



void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}

class _ingameState extends State<ingame> with TickerProviderStateMixin,WidgetsBindingObserver{
  final interval = const Duration(seconds: 1);

  bool condition=false;
  bool condition1=true;
  bool test = false;

  bool answered =false;





  bool Sfx ;
  bool Music ;

  int nbInt = 0;

  int Faza = 0;

  int timerMaxSeconds = 20;
  String points="0";
  String question="";
  String image="";
  String answer1="";
  String answer2="";
  String answer3="";
  String answer4="";
  String realanswer="";
  int R1=255;
  int R2=255;
  int R3=255;
  int R4=255;
  int G1=255;
  int G2=255;
  int G3=255;
  int G4=255;
  int B1=255;
  int B2=255;
  int B3=255;
  int B4=255;
  bool isFirst = true;
  int Z1=0;
  int Z2=0;
  int Z3=0;
  int Z4=0;
  int rnb=0;
  int mnb=0;
  int size = 0;
  int nb = 0;
  String nbstr = "0";

  bool visiblevar = false;
  bool visiblevar2 = false;
  String room = "";
  List options = [];
  RewardedAd _rewardedAd;
  AdmobHelper admobHelper = new AdmobHelper();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;





  String heartLeft = "10";
  String levels = "10";
  String endPoints="0";


  var musList = ['mus1', 'mus2', 'mus3','mus4', 'mus5', 'mus6'];
  var turn = ['question', 'answer'];
  var questionsList = [];
  bool adCond = true;




  int currentSeconds = 0;
  int currentMinutes = 0;
  int timerMaxMinutes = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';



  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);


    if (state == AppLifecycleState.paused ) {audioPlayer.pause();}



    if (state == AppLifecycleState.resumed ) {

      if(Music==true){audioPlayer.resume();}}



    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }
  startTimeout([int milliseconds]) {

    var duration = interval;

    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);



        if (timer.tick ==20 && answered==false){ setState(() {
          visiblevar2=true;

          timer.cancel();

        });}
        if (timer.tick >= timerMaxSeconds && currentMinutes<1){timer.cancel();}
        if(answered==true){timer.cancel();

        }
        if (answered==false){setState(() {
          currentSeconds = timer.tick;
          Faza=currentSeconds;

        });}
        else {setState(() {
          Faza=20;
        });}});});








  }


  @override

  void initPlayer() {
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    /*setState(() {
      _duration = audioPlayer.getDuration() as Duration;
    });

    setState(() {
      _position = audioPlayer.getCurrentPosition() as Duration;
    });*/
  }

  Future<void> pause() async {

    //int result = await audioPlayer.pause();
    await audioCache.fixedPlayer.pause();
    await audioCache.fixedPlayer.pause();
    await audioCache.fixedPlayer.pause();

    Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context) =>
            menu(audioPlayer, audioCache,audioPlayer2, audioCache2)));


    print("pauseed nmet");
  }



  void initState() {
    fn();
    initPlayer();
    WidgetsBinding.instance.addObserver(this);
    getHeart();

    super.initState();

  }

  Future<void> getHeart() async {

    heartLeft = await HelperFunctions.getHeart();
    setState(() {
      heartLeft;
    });
  }

  Future<Timer> fnspp() async {
    startTimeout();
    musList.shuffle();
    Sfx = await HelperFunctions.getSfx();
    Music = await HelperFunctions.getMusic();
    print(Sfx);
    print(Music);

    if(Music==true){
      print("aaaaaaaaaaaa");
      audioCache.play(musList[0]+".mp3");}



  }



  Future<void> fn() async {
    fnspp();




    room =(await HelperFunctions.getRoom());
    print(" rooooom :  "+room );
    //nbstr=(await HelperFunctions.getnb());





    await FirebaseFirestore.instance
        .collection(room)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          size = value.size;


          if(isFirst==true){
          for(int i=0;i<size;i++){
            questionsList.add(i);

          }
          questionsList.shuffle();
          isFirst=false;}

          print(questionsList);

          for(int i =0;i<3;i++){
          options.add(value.docs[questionsList[nbInt]].data()["options"][i]);
          }
          options.add(value.docs[questionsList[nbInt]].data()["answer"]);
          realanswer = (value.docs[questionsList[nbInt]].data()["answer"]);

          question = (value.docs[questionsList[nbInt]].data()["question"]);
          options.shuffle();

        }
      });
    });
    print("this is the options :");
    print(options);
    if(int.parse(nbstr)==size-1){
      test=true;

    }


    else{await HelperFunctions.savenb((int.parse(nbstr)+1).toString());}
    setState(() {
      question=question;
      answer1= options[0];
      answer2=options[1];
      answer3=options[2];
      answer4=options[3];
      image=room+"/"+(questionsList[nbInt]+1).toString()+turn[0];
      print(image);

    });
    rnb=options.indexOf(realanswer)+1;
    options.removeLast();
    options.removeLast();
    options.removeLast();
    options.removeLast();





    print("this is it : ");
    print(nbInt);
    print(questionsList[nbInt]);


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
                  child: PreferredSize(
                    preferredSize: Size(200, 100),
                    //Size.fromHeight(100.0), // here the desired height
                    child: AppBar(
                      automaticallyImplyLeading: false, // hides leading widget
                      flexibleSpace:
                      Stack(alignment: Alignment.centerRight,
                          children: [Container(color: Color.fromARGB(253, 247,
                              210, 210),),
                            Container(color: Color.fromARGB(255, 76, 217, 100),
                              width: ((20 - Faza) * (MediaQuery
                                  .of(context)
                                  .size
                                  .width / 20)).toDouble(),),
                            Container(alignment: Alignment.centerLeft,
                              color: Colors.transparent,
                              width: 400,


                              child: Row(mainAxisAlignment: MainAxisAlignment
                                  .center,
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
                                                                75, 9.0, 9.0,
                                                                10),
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
                                                              .center,
                                                          children: [
                                                            Icon(Icons.pause,
                                                              color: Colors
                                                                  .white,),
                                                            InkWell(
                                                                child: Container(
                                                                    child: Text(
                                                                      "وقف  ",
                                                                      style: TextStyle(
                                                                          fontSize: 17,
                                                                          color: Colors
                                                                              .white),)),
                                                                onTap: () {
                                                                  setState(() {
                                                                    visiblevar =
                                                                    true;
                                                                  });
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
                          ]),),),),
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

                  ), onTap: () async {
                  answered = true;
                  setState(() {
                    image=room+"/"+(questionsList[nbInt]+1).toString()+turn[1];
                  });
                  nbInt++;



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


                    await Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        points=(int.parse(points)+(20-currentSeconds)).toString();
                      });
                      setState(() {
                        condition = false;
                      });
                      setState(() {
                        currentSeconds = 0;
                      });
                      R2 = 255;
                      G2 = 255;
                      B2 = 255;
                      Z2 = 0;
                      R3 = 255;
                      G3 = 255;
                      B3 = 255;
                      Z3 = 0;
                      R4 = 255;
                      G4 = 255;
                      B4 = 255;
                      Z4 = 0;
                      R1 = 255;
                      G1 = 255;
                      B1 = 255;
                      Z1 = 0;

                      answered = false;

                      fn();
                    });
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
                    await Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        visiblevar2 = true;
                      });
                    });
                  }
                },
                ) : null,
                backgroundColor: Colors.transparent,
                body:

                SafeArea(child: Column(
                    children: [Center(
                      child: Container(width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius
                                .circular(15),
                                bottomRight: Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage('assets/images/specialbac.png'),
                              fit: BoxFit.cover,

                            ),),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 13),
                                  child: Text(points, style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),)),
                              Container(child: Image.asset(
                                'assets/images/coin.png',
                                width: 30,
                                height: 30,
                              ),
                                width: 30,
                                height: 30,

                              ),
                            ],)),
                    ),
                      SizedBox(height: 00),
                      Stack(
                          children: [
                            Container(width: 340,
                              height: 420,
                              decoration: BoxDecoration(image: DecorationImage(
                                image: new ExactAssetImage(
                                  'assets/images/white.png',),

                              ),
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment
                                  .center, children: [
                                Container(child: Text(question,
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.w600),),),
                                SizedBox(height: 20,),
                                Container(child: Image.asset(
                                  'assets/images/questions/' + image + ".png",
                                  width: 70,
                                  height: 70,
                                ),
                                  width: 70,
                                  height: 70,
                                ),
                                SizedBox(height: 10,),
                                Center(child: InkWell(
                                  child: Container(padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, R1, G1, B1),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,

                                      ),),
                                    width: 180,
                                    height: 40,
                                    child: Text(
                                      answer1, textAlign: TextAlign.center,
                                      style: TextStyle(color: Color.fromARGB(
                                          255, Z1, Z1, Z1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),),),
                                  onTap: () {
                                    print("answer1");



                                    setState(() {
                                      if (condition1 ==
                                          true) { //condition1=false;
                                        condition = true;
                                        R2 = 255;
                                        G2 = 255;
                                        B2 = 255;
                                        Z2 = 0;
                                        R3 = 255;
                                        G3 = 255;
                                        B3 = 255;
                                        Z3 = 0;
                                        R4 = 255;
                                        G4 = 255;
                                        B4 = 255;
                                        Z4 = 0;
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
                                  child: Container(padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, R2, G2, B2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,

                                      ),),
                                    width: 180,
                                    height: 40,
                                    child: Text(
                                      answer2, textAlign: TextAlign.center,
                                      style: TextStyle(color: Color.fromARGB(
                                          255, Z2, Z2, Z2),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),),),
                                  onTap: () {
                                    print("answer2");



                                    setState(() {
                                      if (condition1 ==
                                          true) { //condition1=false
                                        ;
                                        condition = true;
                                        R2 = 139;
                                        G2 = 109;
                                        B2 = 244;
                                        Z2 = 255;

                                        R1 = 255;
                                        G1 = 255;
                                        B1 = 255;
                                        Z1 = 0;
                                        R3 = 255;
                                        G3 = 255;
                                        B3 = 255;
                                        Z3 = 0;
                                        R4 = 255;
                                        G4 = 255;
                                        B4 = 255;
                                        Z4 = 0;
                                        mnb = 2;
                                      }
                                    }
                                    );
                                  },

                                )),
                                SizedBox(height: 10,),
                                Center(child: InkWell(
                                  child: Container(padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, R3, G3, B3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,

                                      ),),
                                    width: 180,
                                    height: 40,
                                    child: Text(
                                      answer3, textAlign: TextAlign.center,
                                      style: TextStyle(color: Color.fromARGB(
                                          255, Z3, Z3, Z3),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),),)
                                  , onTap: () {
                                  print("answer3");



                                  setState(() {
                                    if (condition1 ==
                                        true) { //condition1=false;
                                      condition = true;
                                      R3 = 139;
                                      G3 = 109;
                                      B3 = 244;
                                      Z3 = 255;

                                      R2 = 255;
                                      G2 = 255;
                                      B2 = 255;
                                      Z2 = 0;
                                      R4 = 255;
                                      G4 = 255;
                                      B4 = 255;
                                      Z4 = 0;
                                      R1 = 255;
                                      G1 = 255;
                                      B1 = 255;
                                      Z1 = 0;
                                      mnb = 3;
                                    }
                                  }
                                  );
                                },
                                )),
                                SizedBox(height: 10,),
                                Center(child: InkWell(
                                  child: Container(padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, R4, G4, B4),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,

                                      ),),
                                    width: 180,
                                    height: 40,
                                    child: Text(
                                      answer4, textAlign: TextAlign.center,
                                      style: TextStyle(color: Color.fromARGB(
                                          255, Z4, Z4, Z4),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),),)
                                  , onTap: () {
                                  print("answer4");



                                  setState(() {
                                    if (condition1 ==
                                        true) { //condition1=false;
                                      condition = true;
                                      R4 = 139;
                                      G4 = 109;
                                      B4 = 244;
                                      Z4 = 255;

                                      R1 = 255;
                                      G1 = 255;
                                      B1 = 255;
                                      Z1 = 0;
                                      R2 = 255;
                                      G2 = 255;
                                      B2 = 255;
                                      Z2 = 0;
                                      R3 = 255;
                                      G3 = 255;
                                      B3 = 255;
                                      Z3 = 0;

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
          Visibility(
            visible: visiblevar2,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),),
                Center(
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: SafeArea(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Container(child: Text("تبي تكمل؟",
                              style: TextStyle(fontSize: 33,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),)),
                              SizedBox(height: 50,),
                              Container(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: CircleAvatar(
                                      radius: 60,
                                      foregroundColor: Colors.white.withOpacity(
                                          0.1),
                                      backgroundColor: Colors.white,
                                      child: Center(child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                padding: EdgeInsets.all(1),
                                                child: Image.asset(
                                                  'assets/images/heart.png',
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                width: 60,
                                                height: 60,
                                              ),onTap: () async {
                                                if(int.parse(heartLeft)>0){
                                              heartLeft=(int.parse(heartLeft)-1).toString();
                                                await HelperFunctions.saveHeart(heartLeft);
                                              setState(() {
                                                condition = false;
                                              });
                                              setState(() {
                                                currentSeconds = 0;
                                              });
                                              R2 = 255;
                                              G2 = 255;
                                              B2 = 255;
                                              Z2 = 0;
                                              R3 = 255;
                                              G3 = 255;
                                              B3 = 255;
                                              Z3 = 0;
                                              R4 = 255;
                                              G4 = 255;
                                              B4 = 255;
                                              Z4 = 0;
                                              R1 = 255;
                                              G1 = 255;
                                              B1 = 255;
                                              Z1 = 0;

                                              answered = false;
                                                visiblevar2=false;
                                                fn();



                                                }
                                              },
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(17),
                                              child: Text(heartLeft,
                                                style: TextStyle(fontSize: 25,
                                                    color: Colors.white),),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ]
                                      ),
                                      ),
                                    ),onTap: () async {
    if(int.parse(heartLeft)>0){
    heartLeft=(int.parse(heartLeft)-1).toString();
    await HelperFunctions.saveHeart(heartLeft);
    setState(() {
    condition = false;
    });
    setState(() {
    currentSeconds = 0;
    });
    R2 = 255;
    G2 = 255;
    B2 = 255;
    Z2 = 0;
    R3 = 255;
    G3 = 255;
    B3 = 255;
    Z3 = 0;
    R4 = 255;
    G4 = 255;
    B4 = 255;
    Z4 = 0;
    R1 = 255;
    G1 = 255;
    B1 = 255;
    Z1 = 0;

    answered = false;
    visiblevar2=false;
    fn();



    }
                                  },
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                    child: CircleAvatar(
                                      radius: 60,
                                      foregroundColor: Colors.white.withOpacity(
                                          0.1),
                                      backgroundColor: Colors.white,
                                      child: Center(
                                          child: Container(child: Image.asset(
                                            'assets/images/Ads.png',
                                            width: 70,
                                            height: 70,
                                          ),
                                            width: 90,
                                            height: 90,
                                          )
                                      ),
                                    ), onTap: () async {
                                      if(adCond==true){

                                    admobHelper .createRewardAd();
                                    admobHelper .showRewardAd();



                                    setState(() {
                                      condition = false;
                                    });
                                    setState(() {
                                      currentSeconds = 0;
                                    });
                                    R2 = 255;
                                    G2 = 255;
                                    B2 = 255;
                                    Z2 = 0;
                                    R3 = 255;
                                    G3 = 255;
                                    B3 = 255;
                                    Z3 = 0;
                                    R4 = 255;
                                    G4 = 255;
                                    B4 = 255;
                                    Z4 = 0;
                                    R1 = 255;
                                    G1 = 255;
                                    B1 = 255;
                                    Z1 = 0;

                                    answered = false;
                                    visiblevar2=false;
                                    fn();
                                    adCond=false;
                                    print("Tapped on container");}
                                  },
                                  )
                                ],)),

                              SizedBox(height: 20),
                              Container(color: Colors.grey.withOpacity(0.6),
                                height: 1,
                                width: 300,),
                              SizedBox(height: 20),
                              Container(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: 150,
                                    height: 30,
                                    child: Text(points, style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),),),
                                  Container(width: 100,
                                    height: 40,
                                    child: Text("عدد النقاط", style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),),),


                                ],)),
                              SizedBox(height: 20),
                              Container(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: 150,
                                    height: 30,
                                    child: Text((nbInt).toString(), style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),),),
                                  Container(width: 100,
                                    height: 40,
                                    child: Text("عدد الجولات", style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),),),
                                ],),)


                              , SizedBox(height: 20),
                              InkWell(child: Container(child: Text(
                                "الصفحة الرئيسية", style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.w700),))


                                , onTap: () async {
                                if(int.parse(points)<200){
                                  audioPlayer.stop();
                                  Sfx = await HelperFunctions.getSfx();
                                  Music = await HelperFunctions.getMusic();
                                  print(Sfx);
                                  print(Music);

                                  if(Music==true){
                                    print("aaaaaaaaaaaa");
                                    audioCache.play("intro.mp3");
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(
                                        builder: (context) =>
                                            menu(audioPlayer, audioCache,audioPlayer, audioCache)));}
                                  else{audioCache.play("intro.mp3");

                                  var duration = new Duration(milliseconds: 60);
                                  return new Timer(duration,pause);}
                                  audioCache.play("intro.mp3");
                                }
                                else{
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          Win(audioPlayer, audioCache,points)));

                                }},),
                            ]

                        ),
                        ),
                      )
                  ),

                ),

              ],
            ),
          ),


          Visibility(child:
          Stack(

            children: [

              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),),
              //BackgroundImage5(),
              Center(
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: SafeArea(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Container(child: Text("متأكد تبي تطلع؟",
                            style: TextStyle(fontSize: 33,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),)),
                            SizedBox(height: 20,),
                            Container(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    radius: 60,
                                    foregroundColor: Colors.white.withOpacity(
                                        0.1),
                                    backgroundColor: Colors.white.withOpacity(
                                        0.2),
                                    child: Center(child: Container(child: Text(
                                      "كمل", style: TextStyle(fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),),)
                                    ),
                                  ), onTap: () {
                                  setState(() {
                                    visiblevar = false;
                                  });
                                },
                                ),
                                SizedBox(width: 20),
                                InkWell(
                                  child: CircleAvatar(
                                    radius: 60,
                                    foregroundColor: Colors.white.withOpacity(
                                        0.1),
                                    backgroundColor: Colors.white,
                                    child: Center(child: Container(child: Text(
                                      "اطلع", style: TextStyle(fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),),)
                                    ),
                                  ), onTap: () async {

                                  audioPlayer.stop();
                                  Sfx = await HelperFunctions.getSfx();
                                  Music = await HelperFunctions.getMusic();
                                  print(Sfx);
                                  print(Music);

                                  if(Music==true){
                                  print("aaaaaaaaaaaa");
                                  audioCache.play("intro.mp3");
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          menu(audioPlayer, audioCache,audioPlayer2, audioCache2)));}
                                  else{audioCache.play("intro.mp3");

                                  var duration = new Duration(milliseconds: 60);
                                  return new Timer(duration,pause);}


                                },
                                )
                              ],)),
                          ]
                      ),
                      ),
                    )
                ),

              ),

            ],
          ),
            visible: visiblevar,
          ),


        ],
      );
  }
}