// @dart=2.9

import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/models/meuser.dart';
import 'package:wechou/models/myhistory.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background7.dart';

import 'package:flutter_contacts/flutter_contacts.dart';



class trophy extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  trophy(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);


  @override
  _trophyState createState() => _trophyState();
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

class _trophyState extends State<trophy> with TickerProviderStateMixin  ,WidgetsBindingObserver{
  @override
  String nbOfplayers = "single player";
  String trophy="10";
  String day= "monday";
  String type="type";
  List<String> players= ["لاعب واحد",'أكثر من لاعب',];


  List<String> names = ["شعارات جهات",'عشوائي',"شعارات مطاعم",'شعارات منتجات','شعارات سيارات','شعارات أندية','شعارات تقنية',"شعارات تطبيقات",'ألوان شعارات','شعارات ماركات','ترفيه عربي','ترفيه أجنبي','سيارات','مشاهير','كلمات',"ايموجيز",'معلومات عامة','جغرافيا','رياضيات'];
  List<String> days = ["يوم الإثنين","يوم الثلاثاء","يوم الأربعاء","يوم الخميس","يوم الجمعة","يوم السبت","يوم الأحد",];

  List History = [];
  String query = '';

  @override


  bool Sfx ;
  String myUsername = "";
  var gamerequests = new Map();
  var newgamerequests = new Map();
  String room = "1";
  String roomname = "";
  bool visibleVar = false;

  String opTrophy = "";
  String opChar = "";
  int size;

  bool Music;

  void initState() {
    // TODO: implement initState

    ImportUser();
    super.initState();
    xfn();
    //meUser = myHistory;
    initPlayer();
    WidgetsBinding.instance.addObserver(this);

  }

  Future<void> ImportUser() async {

    print("aaaaaaaaaaaaaaa");
    await FirebaseFirestore.instance
        .collection("users").where("username", isEqualTo : "ahmed")
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          print("aaaaaaaaaaaaaaa");
          print("aaaaaaaaaaaaaaa");
          print(value);
          size = value.docs[0].data()["myHistory"].length;
          print(value.docs[0].data()["myHistory"][0]["room"]);
          print(value.docs[0].data()["myHistory"][0]);
          for(int i =0; i<size;i++) {
            var map = {
              "trophy": value.docs[0].data()["myHistory"][i]["trophy"],
              "day": value.docs[0].data()["myHistory"][i]["day"],
              "numberOfTrophy": value.docs[0].data()["myHistory"][i]["numberOfTrophy"],
              "numberOfPlayer": value.docs[0].data()["myHistory"][i]["numberOfPlayer"],
              "room" : value.docs[0].data()["myHistory"][i]["room"],

            };
            History.add(map);





          }


        }
      });
    });


    setState(() {
      History=History;
    });





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

  Future<void> xfn() async {
    Sfx = await HelperFunctions.getSfx();
    Music = await HelperFunctions.getMusic();

    newgamerequests["id"]="-1";
    newgamerequests["room"]="nah";
    newgamerequests["roomname"]="nah";

    myUsername=(await HelperFunctions.getname());
    bool exist = await HelperFunctions.getUserExist() ;

    if(exist==true){
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


  Widget build(BuildContext context) {
    return Stack(
      children:[ Stack(
          children: [
            BackgroundImage7(),
            Center(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Directionality(textDirection: TextDirection.rtl,

                    child:  SafeArea(child :Column(
                        children:[ SizedBox(height: 30),

                          Container(margin: EdgeInsets.symmetric(horizontal: 20),

                            child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[Container(width:115,),
                              Center(child: Container(width:155,child:Text("الكؤوس",style:TextStyle(fontSize: 23,color:Colors.white,fontFamily: 'Almarai')),)),
                              InkWell(
                                child: Container(width: 40,height: 25,decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                                onTap: () {
                                  if(Sfx==true){
                                    audioCache.play("click.mp3");}
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => menu(audioPlayer,audioCache,audioPlayer, audioCache)));
                                },

                              ),
                            ]

                            ),
                          ),

                          SizedBox(height:30),
                          Expanded(
                            child: ListView.builder(
                              itemCount: History.length,
                              itemBuilder: (context, index) {
                                final meuser = History[index];

                                return buildUser(meuser);
                              },
                            ),
                          ),
                           /*Container(width:340,height: 500,
                             child: ListView.builder(
                                    itemCount:8,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                                        child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius:new BorderRadius.circular(20.0)),margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),width:360,height: 80,
                                          child:Column(children:[Container(
                                              child:Column(children:[
                                                Container(child:Row(children: [
                                                  Container(child:Text(nbOfplayers)),
                                                  Icon(
                                                    Icons.assignment_ind_sharp,
                                                    color: Colors.white,
                                                    size: 24.0,
                                                    semanticLabel: 'Text to announce in accessibility modes',
                                                  ),
                                                ],)),
                                                Container(child:Row(children: [
                                                  Container(),
                                                  Container(),
                                                ],)),
                                              ])
                                          ),
                                            Container(),
                                            Container(),

                                          ]),


                                        )
                                      );
                                    }
                                ),
                           ),*/




                          ]
                    ),
                    ),


                ),),


            ),]),
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
    if(Sfx==true){
    await FirebaseFirestore.instance.collection("users").doc(myUsername).update({
    "game requests" : newgamerequests,
    }).catchError((e) {
    print(e.toString());
    });
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

  Widget buildUser(Map meuser) => InkWell(
    child: Container(width: double.infinity, height: 90,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1),borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),),
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Container(width:60,child:Image.asset("assets/images/trophyfolder/tr"+(meuser["trophy"]).toString()+".png",width: 80,height: 80,)),

        Container(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(margin: EdgeInsets.fromLTRB(5, 5, 5, 5),child:Text(days[int.parse(meuser["day"])],style: TextStyle(fontSize: 12,color:Colors.white.withOpacity(0.5)))),
          Container(margin: EdgeInsets.fromLTRB(5, 5, 5, 5),child:Text(names[int.parse(meuser["room"])],textAlign: TextAlign.right,style: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.w600),),),



        ],)),
        SizedBox(width: 45,),
        Container(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Container(child:Text(players[int.parse(meuser["numberOfPlayer"])],style: TextStyle(fontSize: 12,color:Colors.white)),),
            Container(child :Image.asset("assets/images/trophyfolder/user.png",width: 20,height: 20,)),

          ],),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Container(child:Text(meuser["numberOfTrophy"],style: TextStyle(fontSize: 12,color:Colors.white)),),
            Container(child :Image.asset("assets/images/trophyfolder/trophy.png",width: 20,height: 20,)),

          ],),
        ]

        ))


      ],),



    ),onTap: () {

    print("aaaaaaaaaaa");},
  );
}

