// @dart=2.9

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';
import'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background1.dart';
import 'package:wechou/widget/background3.dart';

class gameended extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  List charTab;
  List pointsTab;
  List resultTab;
  gameended(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2,this.charTab,this.pointsTab,this.resultTab);
  _gameendedState createState() => _gameendedState();
}
AnimationController _animationIconController1;

AudioCache audioCache;

AudioPlayer audioPlayer;

AudioCache audioCache2;

AudioPlayer audioPlayer2;

//int _duration = new Duration();
//int _position = new Duration();

bool issongplaying = false;

bool isplaying = false;

void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}
class _gameendedState extends State<gameended> with TickerProviderStateMixin  ,WidgetsBindingObserver {

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

  var torphyTab = [];

  String nbtrophy1 = "10";
  String nbtrophy2 = "10";
  String nbtrophy3 = "10";
  String nbtrophy4 = "10";

  String point1 = "";
  String point2 = "";
  String point3 = "";
  String point4 = "";

  String name1 = "";
  String name2 = "";
  String name3 = "";
  String name4 = "";

  String char1 = "";
  String char2 = "";
  String char3 = "";
  String char4 = "";

  bool Music;

  double active1 = 0;
  double active2 = 0;
  double active3 = 0;
  double active4 = 0;
  double active5 = 0;
  double active6 = 0;
  double active7 = 0;
  double active8 = 0;
  double active9 = 0;
  double active10 = 0;
  double active11 = 0;
  double active12 = 0;
  double active13 = 0;
  double active14 = 0;
  double active15 = 0;
  double active16 = 0;
  double active17 = 0;
  double active18 = 0;

  List gifTab = [];

  bool visibleVar5 = false;

  int size;
  String onlineRoom ="";
  String myGif = "";
  String contactName = "";
  String gifShow = "";
  List gifList = ["aa","bb","cc","dd","ee","ff","gg","hh","ii","jj","kk","rr","ll","mm","nn","oo","pp","qq"];
  String gif = "-1";

  List resultTab =[];
  List charTab =[];
  List pointsTab =[];




  void initState() {
    // TODO: implement initState
    spFn();
    super.initState();
    xfn();
    initPlayer();
    WidgetsBinding.instance.addObserver(this);
    checkUpdate();

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

  void initPlayer() {
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = widget.audioPlayer;
    audioCache = widget.audioCache;
    audioPlayer2 = widget.audioPlayer2;
    audioCache2 = widget.audioCache2;
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


  Future<void> spFn() async {

    print(widget.charTab);
    resultTab = new List.from(widget.resultTab.reversed);
    charTab = new List.from(widget.charTab.reversed);
    pointsTab = new List.from(widget.pointsTab.reversed);


    print("this is it");

    print(resultTab);


    setState(() {

      widget.resultTab=widget.resultTab;
      widget.charTab=widget.charTab;
      widget.pointsTab=widget.pointsTab;


    });

    gifTab.add(active1);
    gifTab.add(active2);
    gifTab.add(active3);
    gifTab.add(active4);
    gifTab.add(active5);
    gifTab.add(active6);
    gifTab.add(active7);
    gifTab.add(active8);
    gifTab.add(active9);
    gifTab.add(active10);
    gifTab.add(active11);
    gifTab.add(active12);
    gifTab.add(active13);
    gifTab.add(active14);
    gifTab.add(active15);
    gifTab.add(active16);
    gifTab.add(active17);
    gifTab.add(active18);

    for(int i=0;i<resultTab.length;i++){

    await FirebaseFirestore.instance
        .collection('users').doc(resultTab[i])
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          if (value != null) {

            torphyTab.add(value.data()["trophy"]);


          }
        });
      }});}













  }


  Future<void> checkUpdate() async {

    roomname=await HelperFunctions.getOnlineRoom();

    myUsername=await HelperFunctions.getname();


    await FirebaseFirestore.instance
        .collection(onlineRoom).where("username", isEqualTo : myUsername)
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          size = value.size;
          myGif = value.docs[0].data()["gif"];
        }
      });
    });



    if(myGif!="-1"){
      setState(() {
        contactName=myGif.substring(1);
        gifShow=gifList[int.parse(myGif.substring(0,1))-1];
        visibleVar5=true;

      });
      await FirebaseFirestore.instance.collection(onlineRoom).doc(myUsername).update({
        "gif" : "-1",
      }).catchError((e) {
        print(e.toString());
      });
    }




  }

  Future<void> xfn() async {
    Sfx = await HelperFunctions.getSfx();

    newgamerequests["id"]="-1";
    newgamerequests["room"]="nah";
    newgamerequests["roomname"]="nah";

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
    }

  }








  @override
  Widget build(BuildContext context) {

    return
      Stack(
        children: [
          Stack(
          children: [
            BackgroundImage1(),
            Center(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(

                    child:  SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                        children:[ SizedBox(height: 15,),
                          Container(child:Center(child: Text("المركز الأول",textAlign: TextAlign.center,style:TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w600))))
                          ,SizedBox(height: 5,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children:[


                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                              SizedBox(height:15,),
                              Container(child:Text(resultTab[0],style: TextStyle(color: Colors.black,fontSize:16,fontWeight: FontWeight.w700),)),
                              //SizedBox(height:15,),

    Container(padding: EdgeInsets.all(1),width:70,height:55,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.transparent),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
    Container(child:Text(pointsTab[0],style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w800),)),
    Container(child: Image.asset(
    'assets/images/coin.png',
    width: 35,
    height: 35,
    ),
    width: 35,
    height: 35,

    ),]),),


                            ]),
                            SizedBox(width: 15,),
                            Stack(alignment: Alignment.center,children: [
                              Center(child:Container(child:Image.asset(
                                'assets/images/char'+charTab[0]+'.png',
                                width: 100,
                                height: 100,
                              ),
                                width: 100,
                                height: 100,
                              ),),
                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children:[ SizedBox(height:90),Center(
                                    child: Container(padding: EdgeInsets.all(1),width:60,height:27,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.indigo),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                      Container(child:Text(nbtrophy1,style: TextStyle(color: Colors.white,fontSize:13,fontWeight: FontWeight.w800),)),
                                      Container(child: Image.asset(
                                        'assets/images/Trophy.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                        width: 24,
                                        height: 24,

                                      ),
                                    ],)),
                                  ),]),

                              Column(children: [


                                Row(children: [SizedBox(width: 75),

                                Container(alignment:Alignment.center,width:15,height:15,decoration: BoxDecoration(color: Colors.black87 ,borderRadius: BorderRadius.circular(100)),child: Text("1",style: TextStyle(color: Colors.white,fontSize: 13))
                                ),

                              ],),
                                SizedBox(height:75),],)





                            ]),



                          ]),
                          SizedBox(height:20),
                          Container(height:2 ,width:250, color: Colors.black.withOpacity(0.3)),
                          SizedBox(height:20),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(height:80
    ,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    //padding: const EdgeInsets.all(8),

    shrinkWrap: true,

    itemCount: charTab.length-1,
    itemBuilder: (BuildContext context, int index) {
    return
    Stack(alignment: Alignment.center,children: [
                              Center(child:Container(margin:EdgeInsets.fromLTRB(15, 0, 15, 0),child:Image.asset(
                                'assets/images/char'+charTab[index+1]+'.png',
                                width: 70,
                                height: 70,
                              ),
                                width: 70,
                                height: 70,
                              ),),
                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children:[ SizedBox(height:75),Center(
                                    child: Container(padding: EdgeInsets.all(1),width:60,height:27,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.indigo),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                      Container(child:Text(nbtrophy2,style: TextStyle(color: Colors.white,fontSize:13,fontWeight: FontWeight.w800),)),
                                      Container(child: Image.asset(
                                        'assets/images/Trophy.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                        width: 24,
                                        height: 24,

                                      ),
                                    ],)),
                                  ),]),Column(children: [


        Row(children: [SizedBox(width: 50),

          Container(alignment:Alignment.center,width:15,height:15,decoration: BoxDecoration(color: Colors.black87 ,borderRadius: BorderRadius.circular(100)),child: Text((index +2).toString(),style: TextStyle(color: Colors.white,fontSize: 13))
          ),

        ],),
        SizedBox(height: 0),],)







                            ]);}),),
                          ],),
                          SizedBox(height: 5),


    Container(height:100
    ,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    //padding: const EdgeInsets.all(8),

    shrinkWrap: true,

    itemCount: charTab.length-1,
    itemBuilder: (BuildContext context, int index) {
    return Row(mainAxisAlignment:MainAxisAlignment.center,children:[
                            Column(mainAxisAlignment: MainAxisAlignment.center,children: [

                              Container(margin:EdgeInsets.fromLTRB(33, 0, 33, 0),child:Text(resultTab[index+1],style: TextStyle(color: Colors.black,fontSize:16,fontWeight: FontWeight.w700),)),
                              //SizedBox(height:15,),

                              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                Container(child:Text(pointsTab[index+1],style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w800),)),
                                Container(child: Image.asset(
                                  'assets/images/coin.png',
                                  width: 35,
                                  height: 35,
                                ),
                                  width: 35,
                                  height: 35,

                                ),]),


                            ]),]);}),),


                          SizedBox(height: 10,),


                          Container(height:2 ,width:250, color: Colors.black.withOpacity(0.3)

                          ),
                          SizedBox(height: 5,),

                          Container(child:Center(child: Text("إرسال ردة فعل",textAlign: TextAlign.center,style:TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w700)))),
                          SizedBox(height: 5,),
                          SingleChildScrollView(scrollDirection: Axis.horizontal,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                              SizedBox(width: 15,),

                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/aa.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active1),child:Container(width:2,height:2,),),onTap: () {
                                      if(active1==0){

                                      setState(() {
                                        gif="1";
                                      active1=0.3;
                                      active2 = 0;
                                    active3 = 0;
                                    active4 = 0;
                                    active5 = 0;
                                    active6 = 0;
                                    active7 = 0;
                                    active8 = 0;
                                    active9 = 0;
                                    active10 = 0;
                                    active11 = 0;
                                    active12 = 0;
                                    active13 = 0;
                                    active14 = 0;
                                    active15 = 0;
                                    active16 = 0;
                                    active17 = 0;
                                    active18 = 0;
                                    });}
                                      else{
                                        setState(() {
                                          active1=0;
                                          active2 = 0;
                                          active3 = 0;
                                          active4 = 0;
                                          active5 = 0;
                                          active6 = 0;
                                          active7 = 0;
                                          active8 = 0;
                                          active9 = 0;
                                          active10 = 0;
                                          active11 = 0;
                                          active12 = 0;
                                          active13 = 0;
                                          active14 = 0;
                                          active15 = 0;
                                          active16 = 0;
                                          active17 = 0;
                                          active18 = 0;
                                          gif = "-1";
                                        });

                                      }



                                      }
                                      ),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active1*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/bb.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active2),child:Container(width:2,height: 2,),),onTap: () {if(active2==0){

                                      setState(() {
                                        gif="2";
                                        active1=0;
                                        active2 = 0.3;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active2*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/cc.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active3),child:Container(width:2,height: 2,),),onTap: () {if(active3==0){

                                      setState(() {
                                        gif="3";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0.3;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active3*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/dd.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active4),child:Container(width:2,height: 2),),onTap: () {if(active4==0){

                                      setState(() {
                                        gif="4";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0.3;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active4*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/ee.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active5),child:Container(width:2,height: 2,),),onTap: () {if(active5==0){

                                      setState(() {
                                        gif="5";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0.3;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active5*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),




                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/ff.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active6),child:Container(width:2,height: 2,),),onTap: () {if(active6==0){

                                      setState(() {
                                        gif="6";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0.3;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active6*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/gg.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active7),child:Container(width:2,height: 2,),),onTap: () {if(active7==0){

                                      setState(() {
                                        gif="7";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0.3;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active7*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/hh.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active8),child:Container(width:2,height: 2,),),onTap: () {if(active8==0){

                                      setState(() {
                                        gif="8";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0.3;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active8*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/ii.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active9),child:Container(width:2,height: 2,),),onTap: () {if(active9==0){

                                      setState(() {
                                        gif="9";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0.3;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active9*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/jj.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active10),child:Container(width:2,height: 2,),),onTap: () {if(active10==0){

                                      setState(() {
                                        gif="10";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0.3;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active10*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/kk.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active11),child:Container(width:2,height: 2),),onTap: () {if(active11==0){

                                      setState(() {
                                        gif="11";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0.3;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active11*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/ll.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active12),child:Container(width:2,height: 2,),),onTap: () {if(active12==0){

                                      setState(() {
                                        gif="12";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0.3;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active12*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/mm.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active13),child:Container(width:2,height: 2),),onTap: () {if(active13==0){

                                      setState(() {
                                        gif="13";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0.3;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active13*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/nn.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active14),child:Container(width:2,height: 2),),onTap: () {if(active14==0){

                                      setState(() {
                                        gif="14";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0.3;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active14*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/oo.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active15),child:Container(width:2,height: 2),),onTap: () {if(active15==0){

                                      setState(() {
                                        gif="15";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0.3;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active15*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/pp.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active16),child:Container(width:2,height: 2),),onTap: () {if(active16==0){

                                      setState(() {
                                        gif="16";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0.3;
                                        active17 = 0;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active16*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/qq.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active17),child:Container(width:2,height: 2),),onTap: () {if(active17==0){

                                      setState(() {
                                        gif="17";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0.3;
                                        active18 = 0;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active17*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                              Stack(alignment:  Alignment.center,
                                  children: [


                                    Container(width:80,height:80,child:Image.asset("assets/images/rr.gif",width: 80,height: 80,)),
                                    InkWell(child: Container(width:80,height:80,color : Colors.green.withOpacity(active18),child:Container(width:2,height: 2),),onTap: () {if(active18==0){

                                      setState(() {
                                        gif="18";
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0.3;
                                      });}
                                    else{
                                      setState(() {
                                        active1=0;
                                        active2 = 0;
                                        active3 = 0;
                                        active4 = 0;
                                        active5 = 0;
                                        active6 = 0;
                                        active7 = 0;
                                        active8 = 0;
                                        active9 = 0;
                                        active10 = 0;
                                        active11 = 0;
                                        active12 = 0;
                                        active13 = 0;
                                        active14 = 0;
                                        active15 = 0;
                                        active16 = 0;
                                        active17 = 0;
                                        active18 = 0;
                                        gif = "-1";
                                      });

                                    }}),
                                    Container(child:Image.asset(
                                      'assets/images/tic.png',
                                      color :Color.fromARGB(((active18*255)/0.3).toInt(), 255, 255, 255),
                                      colorBlendMode: BlendMode.modulate,
                                      width: 15,
                                      height: 15,
                                    ),
                                      width: 15,
                                      height:15,
                                    ),



                                  ]
                              ),
                              SizedBox(width: 15,),
                            ],),
                          ),
                          SizedBox(height: 6,),
                          InkWell(
                            child: Container(alignment: Alignment.center
                                ,width: 290,height: 45,decoration:BoxDecoration(color:Colors.tealAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("إغلاق",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                            onTap: () async {

                              for(int i=0;i<widget.resultTab.length;i++){
                                if(widget.resultTab[i]!=myUsername){
                                  if(gif!="-1"){



                                await FirebaseFirestore.instance.collection(onlineRoom).doc(widget.resultTab[i]).update({
                                  "gif" : gif+myUsername,
                                }).catchError((e) {
                                  print(e.toString());
                                });}}}

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





                            },),


                          ]
                    ),
                    )
                ),

              ),),

          ],
        ),

          Visibility(
            visible : visibleVar5,
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
                      body: SingleChildScrollView(
                        child: Center(child:

                        SafeArea(child : Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[
                            SizedBox(height: 150,),
                            Container(alignment:Alignment.center,child:Text("ردة فعل من "+contactName,style: TextStyle(color: Colors.white,fontSize:30,fontWeight: FontWeight.w500),)),
                            SizedBox(height: 30,),
                            Container(alignment:Alignment.center,child:Image.asset("assets/images/"+gifShow+".gif",width: 150,height: 150,)),
                            SizedBox(height: 30,),

                            SizedBox(height: 20,),
                            SizedBox(width:50),

                            InkWell(
                              child: Container(alignment: Alignment.center
                                  ,width: 270,height: 45,decoration:BoxDecoration(color:Colors.transparent,border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("إغلاق",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),)),
                              onTap: () {
                                setState(() {
                                  visibleVar5=false;

                                });

                              },),



                          ]
                          ),
                        ),

                        ),),
                      ),),),

                ]
            ),
          ),


          Visibility(
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
          )]
      );
  }
}
