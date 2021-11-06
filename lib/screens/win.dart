// @dart=2.9

import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background1.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background5.dart';
import 'package:wechou/widget/background6.dart';


class Win extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  String points;
  Win(this.audioPlayer,this.audioCache,this.points);

  @override
  _WinState createState() => _WinState();
}
AnimationController _animationIconController1;

AudioCache audioCache;
bool Music;

AudioPlayer audioPlayer;

//int _duration = new Duration();
//int _position = new Duration();

bool issongplaying = false;

bool isplaying = false;

void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}

class _WinState extends State<Win> with TickerProviderStateMixin  ,WidgetsBindingObserver {
  @override

  bool Sfx ;
  String myUsername = "";
  var gamerequests = new Map();
  var newgamerequests = new Map();
  String room = "1";
  String roomname = "";
  bool visibleVar = false;
  List<String> names = ["شعارات جهات",'عشوائي',"شعارات مطاعم",'شعارات منتجات','شعارات سيارات','شعارات أندية','شعارات تقنية',"شعارات تطبيقات",'ألوان شعارات','شعارات ماركات','ترفيه عربي','ترفيه أجنبي','سيارات','مشاهير','كلمات',"ايموجيز",'معلومات عامة','جغرافيا','رياضيات'];
  String opTrophy = "";
  String opChar = "";






  void initState() {
    // TODO: implement initState
    super.initState();
    xfn();
    initPlayer();
    WidgetsBinding.instance.addObserver(this);

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



    if (state == AppLifecycleState.resumed ) {if(Music==true){audioPlayer.resume();}}



    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  Future<void> xfn() async {
    Sfx = await HelperFunctions.getSfx();
    Music = await HelperFunctions.getMusic();

    newgamerequests["id"]="-1";
    newgamerequests["room"]="nah";
    newgamerequests["roomname"]="nah";

    bool exist = await HelperFunctions.getUserExist() ;

    if(exist==true){

    myUsername=(await HelperFunctions.getname());
    await FirebaseFirestore.instance
        .collection('users').doc(myUsername)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          gamerequests = value.data()["game requests"];
          print(gamerequests);//????
          //????

        }
      });
    });
    if(gamerequests["id"]=="yes"){
      room = gamerequests["room"];
      roomname = gamerequests["roomname"];
      visibleVar =  true;

      await FirebaseFirestore.instance
          .collection('users').doc(roomname)
          .get()
          .then((value) {
        setState(() {
          if (value != null) {
            opTrophy = value.data()["trophy"];      //????
            opChar = value.data()["char"];          //????

          }
        });
      });
    }}

  }




  @override
  Widget build(BuildContext context) {


    return
      Directionality(textDirection: TextDirection.rtl,
        child: Stack(
            children : [Stack(
            children: [
          BackgroundImage6(),
          Center(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body:Center(
                  child: SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                          Container(decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
    Colors.white,
    Colors.white.withOpacity(0.1),
    ],
    ),),height: 2,width: 80,),
                          Container(child:Text("  مبرووووووك  ",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w300),),),
                          Container(decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,

                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.1),
                              ],
                            ),),height: 2,width: 80,),



                        ],)),
                        SizedBox(height: 30,),
                        Container(child:Text("فزت بكأس جديد",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),),
                        Stack(
                          children: [Container(child:Image.asset(
                            'assets/images/win.png',
                            width: 190,
                            height: 190,
                          ),
                            width: 190,
                            height: 190,
                          ),
                            Container(child:Image.asset(
                            'assets/images/Trophy.png',
                            width: 190,
                            height: 190,
                          ),
                            width: 190,
                            height: 190,
                          ),]
                        ),
                        SizedBox(height: 20,),
                        Container(child:Text("جمعت",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w800),),),
                        Container(child:Text(widget.points,style: TextStyle(fontSize: 45,color: Colors.black,fontWeight: FontWeight.w800),),),
                        Container(child:Text("نقطة ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w800),),),
                      ]),
                  ),
                )
            ),

          ),

        ],
      ),Visibility(
              visible: visibleVar,
              child: Stack(alignment: Alignment.center,
                  children: [
                    BackgroundImage3(),
                    Center(
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: SingleChildScrollView(

                          child:  SafeArea(child :Center(
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children:[ SizedBox(height: 30),

                                  Container(height:80,width: 250,child:Text(" في "+ names[int.parse("1")] + " " + roomname +" يتحداك ",textAlign: TextAlign.center,style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600))),
                                  SizedBox(height: 80),

                                  Row(mainAxisAlignment: MainAxisAlignment.center,children : [
                                    Stack(alignment: Alignment.center,children: [
                                      Center(child:Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(100) ),child:Image.asset(
                                        'assets/images/char'+opChar +'.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                        width:80,
                                        height: 80,
                                      ),),
                                      Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children:[ SizedBox(height:80),Center(
                                            child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.black),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                              Container(child:Text(opTrophy,style: TextStyle(color: Colors.amber,fontSize:10,fontWeight: FontWeight.w800),)),
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

                                    SizedBox(width: 60,),

                                    CircleAvatar(
                                        radius: 38,foregroundColor: Colors.white.withOpacity(0.1),
                                        backgroundColor:Colors.white ,backgroundImage: AssetImage('assets/images/'+room+'.png'))
                                  ]),







                                  SizedBox(height: 40),

                                  Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                    InkWell(
                                      child: CircleAvatar(
                                        radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                                        backgroundColor:Colors.white ,
                                        child:Center(child:Container(child:Text("إلعب",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w600),),)
                                        ),
                                      ),onTap: () async {

                                      await FirebaseFirestore.instance.collection("users").doc(myUsername).update({
                                        "game requests" : newgamerequests,
                                      }).catchError((e) {
                                        print(e.toString());
                                      });
                                      if(Sfx==true){
                                        audioCache.play("click.mp3");}
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => StartGame(audioPlayer,audioCache,audioPlayer2,audioCache2)));



                                    },
                                    ),

                                    SizedBox(width:20),
                                    InkWell(
                                      child: CircleAvatar(
                                        radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                                        backgroundColor:Colors.white.withOpacity(0.2) ,
                                        child:Center(child:Container(child:Text("أرفض",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),)
                                        ),
                                      ),onTap: () async {
                                      if(Sfx==true){
                                        audioCache.play("click.mp3");}
                                      await FirebaseFirestore.instance.collection("users").doc(myUsername).update({
                                        "game requests" : newgamerequests,
                                      }).catchError((e) {
                                        print(e.toString());
                                      });

                                      setState(() {
                                        visibleVar=false;

                                      });
                                    },
                                    ),

                                  ],)),
                                ]
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),]),
            )


              ,]),
      );

  }
}

