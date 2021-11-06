// @dart=2.9

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';
import'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/inmultgame.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import'package:cloud_firestore/cloud_firestore.dart';

class StartGametest extends StatefulWidget {
  @override
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  StartGametest(this.audioPlayer,this.audioCache);

  @override
  _StartGametestState createState() => _StartGametestState();
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

class _StartGametestState extends State<StartGametest> with TickerProviderStateMixin  ,WidgetsBindingObserver  {
  @override
  String nbtrophy = "150";
  int currentSeconds = 0;
  int currentMinutes = 0;
  int timerMaxMinutes = 10;
  final interval = const Duration(seconds: 1);
  int timerMaxSeconds = 600;
  String imagenb = "1";
  String roomname = "";
  List<String> names = ["شعارات جهات",'عشوائي',"شعارات مطاعم",'شعارات منتجات','شعارات سيارات','شعارات أندية','شعارات تقنية',"شعارات تطبيقات",'ألوان شعارات','شعارات ماركات','ترفيه عربي','ترفيه أجنبي','سيارات','مشاهير','كلمات',"ايموجيز",'معلومات عامة','جغرافيا','رياضيات'];
  String oneTrophy = "10";
  String twoTrophy = "10";
  String threeTrophy = "10";
  String threeIn = "0.5";
  String oneIn = "0.5";
  String twoIn = "0.5";
  String char0 = "0";
  String char1 = "0";
  String char2 = "0";
  String char3 = "0";
  String name1 = "aa";
  String name2 = "";
  String name3 = "";
  String name4 = "";
  int size = 0;

  List<String> entryTab = ["0.5","0.5","0.5"];

  String onlineRoom = "";

  List<String> nameTab = [];
  List<String> trophyTab = [];
  List<String> charTab = [];

  List<String> stateTab = [];



  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';


  startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);

        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds && currentMinutes<1) timer.cancel();




      });
    });
  }


  @override
  void initState() {

    startTimeout();
    super.initState();
    roomname=names[int.parse(imagenb)-1];
    fn();
    ln();
    initPlayer();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> fn() async {
    await HelperFunctions.saveRoom("1");
    await HelperFunctions.saveOnlineRoom("hibo");
    imagenb =(await HelperFunctions.getRoom());
    onlineRoom =(await HelperFunctions.getOnlineRoom());


    print(imagenb);
    setState(() {
      imagenb=imagenb;
      name1=name1;
      nbtrophy=nbtrophy;

    });
    await FirebaseFirestore.instance
        .collection(onlineRoom).where("identifier", isEqualTo : "player")
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          size = value.size;
          print(size = value.size);
          for(int index = 0 ; index < size; index++){
            nameTab.add(value.docs[index].data()["username"]);


          }
        }
      });
    });

    await FirebaseFirestore.instance
        .collection(onlineRoom).where("identifier", isEqualTo : "host")
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          name1 = value.docs[0].data()["username"];
        }
      });
    });

    for(int index = 0 ; index < nameTab.length; index++){
      await FirebaseFirestore.instance
          .collection('users').doc(nameTab[index])
          .get()
          .then((value) {
        setState(() {
          if (value != null) {
            trophyTab.add(value.data()["trophy"]);      //????
            charTab.add(value.data()["char"]);          //????

          }
        });
      });}

    await FirebaseFirestore.instance
        .collection('users').doc(name1)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          trophyTab.add(value.data()["trophy"]);      //????
          charTab.add(value.data()["char"]);          //????

        }
      });
    });


    setState(() {
      name2= nameTab[0];
      name3=nameTab[1];
      name4=nameTab[2];

      char1= charTab[0];
      char2=charTab[1];
      char3=charTab[2];


      oneTrophy = trophyTab[0];
      twoTrophy = trophyTab[1];
      threeTrophy = trophyTab[2];


    });

    ln();



  }
  void initPlayer() {
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = widget.audioPlayer;
    audioCache = widget.audioCache;
    /*setState(() {
      _duration = audioPlayer.getDuration() as Duration;
    });

    setState(() {
      _position = audioPlayer.getCurrentPosition() as Duration;
    });*/
  }
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);


    if (state == AppLifecycleState.paused ) {audioPlayer.pause();}



    if (state == AppLifecycleState.resumed ) {audioPlayer.resume();}



    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  Future<Timer> ln() async {
    print("now ln §!!");

    await FirebaseFirestore.instance
        .collection(onlineRoom).doc("entry")
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          for(int i=0;i<nameTab.length;i++){

            stateTab.add(value.data()[nameTab[i]]);

          }}
      });
    });
    for(int i=0;i<nameTab.length;i++){
      if(stateTab[i]!="-1"){
        setState(() {
          entryTab[i] = "1";

        });

      }

    }
    print("éé");

    var duration = new Duration(seconds: 15);
    return new Timer(duration,  ln);



  }



  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage4(),
        Center(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(

              child:  SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                  children:[ SizedBox(height: 20),
                    Row(
                        children: [InkWell(
                          child: Container(width: 110,height: 25,decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/images/backb.png",),),),),
                          onTap: () {
                            print("Tapped on container");
                          },

                        ),
                          SizedBox(width: 220,)
                        ]
                    ),
                    SizedBox(height: 10,),
                    Container(child:Center(child: Text(timerText,textAlign: TextAlign.center,style:TextStyle(color: Colors.white)))),
                    SizedBox(height: 15,),
                    Stack(children: [
                      Container(height:3,width: 200,color: Colors.white30.withOpacity(0.3),),
                      Container(height:3,width: (200*3-currentSeconds).toDouble()*0.3,color: Colors.white),
                    ],),
                    SizedBox(height: 10,),
                    Container(child:Text("يتحداكم "+name1,textAlign: TextAlign.center,style:TextStyle(color: Colors.white,fontSize: 25))),
                    SizedBox(height: 10,),
                    Stack(children: [
                      Center(child:Container(child:Image.asset(
                        'assets/images/char1.png',
                        width: 130,
                        height: 130,
                      ),
                        width: 130,
                        height: 130,
                      ),),
                      Column(mainAxisAlignment: MainAxisAlignment.center,
                          children:[ SizedBox(height:113),Center(
                            child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.black),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                              Container(child:Text(nbtrophy,style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.w800),)),
                              Container(child: Image.asset(
                                'assets/images/Trophy.png',
                                width: 20,
                                height: 20,
                              ),
                                width: 20,
                                height: 20,

                              ),
                            ],)),
                          ),]),]),
                    SizedBox(height: 15,),

                    CircleAvatar(
                      radius: 30,foregroundColor: Colors.white.withOpacity(0.1),
                      backgroundColor:Colors.white ,backgroundImage: AssetImage('assets/images/'+imagenb+'.png'),




                    ),
                    SizedBox(height: 10,),
                    Container(child:Text(roomname,style: TextStyle(color: Colors.white,fontSize:13,fontWeight: FontWeight.w600),),),
                    SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Container(child:Stack(alignment:Alignment.center,children: [
                        Center(child:Container(child:Image.asset(
                          'assets/images/char1.png',
                          color:  Color.fromRGBO(255, 255, 255, double.parse(entryTab[0])),
                          colorBlendMode: BlendMode.modulate,
                          width: 80,
                          height: 80,
                        ),
                          width: 80,
                          height:80,
                        ),),
                        Column(mainAxisAlignment: MainAxisAlignment.center,
                            children:[ SizedBox(height:95),Center(
                              child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.black),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                Container(child:Text(oneTrophy,style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.w800),)),
                                Container(child: Image.asset(
                                  'assets/images/Trophy.png',
                                  width: 20,
                                  height: 20,
                                ),
                                  width: 20,
                                  height: 20,

                                ),
                              ],)),
                            ),SizedBox(height: 10,),Container(child:Text(name2,style: TextStyle(color: Colors.white.withOpacity(double.parse(entryTab[0])),fontSize:10,fontWeight: FontWeight.w800),)),
                            ])
                      ]),),SizedBox(width:20,
                      ),
                      Container(child:Stack(alignment:Alignment.center,children: [
                        Center(child:Container(child:Image.asset(
                          'assets/images/char1.png',color :Color.fromRGBO(255, 255, 255, double.parse(entryTab[1])),
                          colorBlendMode: BlendMode.modulate,

                          width: 80,
                          height: 80,
                        ),
                          width: 80,
                          height:80,
                        ),),
                        Column(mainAxisAlignment: MainAxisAlignment.center,
                            children:[ SizedBox(height:95),Center(
                              child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.black),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                Container(child:Text(twoTrophy,style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.w800),)),
                                Container(child: Image.asset(
                                  'assets/images/Trophy.png',
                                  width: 20,
                                  height: 20,
                                ),
                                  width: 20,
                                  height: 20,

                                ),
                              ],)),

                            ),SizedBox(height: 10,),Container(child:Text(name3,style: TextStyle(color: Colors.white.withOpacity(double.parse(entryTab[1])),fontSize:10,fontWeight: FontWeight.w800),)),
                            ])
                        ,]),),
                      SizedBox(width:20,
                      ),
                      Container(child:Stack(alignment:Alignment.center,children: [
                        Center(child:Container(child:Image.asset(
                          'assets/images/char1.png',color :Color.fromRGBO(255, 255, 255, double.parse(entryTab[2])),
                          colorBlendMode: BlendMode.modulate,
                          width: 80,
                          height: 80,
                        ),
                          width: 80,
                          height:80,
                        ),),
                        Column(mainAxisAlignment: MainAxisAlignment.center,
                            children:[ SizedBox(height:95),Center(
                              child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.black),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                Container(child:Text(threeTrophy,style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.w800),)),
                                Container(child: Image.asset(
                                  'assets/images/Trophy.png',
                                  width: 20,
                                  height: 20,
                                ),
                                  width: 20,
                                  height: 20,

                                ),
                              ],)),
                            ),SizedBox(height: 10,),Container(child:Text(name4,style: TextStyle(color: Colors.white.withOpacity(double.parse(entryTab[2])),fontSize:10,fontWeight: FontWeight.w800),)),
                            ])

                      ]),),
                    ],),
                    SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      InkWell(
                        child: Container(alignment: Alignment.center
                            ,width: 130,height: 45,decoration:BoxDecoration(border: Border.all(color: Colors.tealAccent),color:Colors.transparent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))),child:Text("إلغاء",style: TextStyle(color: Colors.tealAccent,fontSize:20,fontWeight: FontWeight.w500),)),
                        onTap: () {
                          print("aa");
                        },),
                      SizedBox(width: 45,),
                      InkWell(
                        child: Container(alignment: Alignment.center
                            ,width: 130,height: 45,decoration:BoxDecoration(color:Colors.tealAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("ابدا اللعب  ",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                        onTap: () {
                          if(entryTab[0]==1 && entryTab[1]==1 && entryTab[2]==1){
                            audioPlayer.stop();
                            /*Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => inmultigame(nameTab,charTab)));*/
                          }
                        },),
                    ],)

                  ]
              ),

              ),
            ),
          ),
        ),],);







  }
}