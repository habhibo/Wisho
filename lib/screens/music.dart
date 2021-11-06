// @dart=2.9

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class music extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  music(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);

  @override
  _musicState createState() => _musicState();
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

class _musicState extends State<music>  with TickerProviderStateMixin  ,WidgetsBindingObserver{


  double MusicImageColor = 0.15;
  double sfxImageColor = 0.1;

  double MusicwordColor = 0.25;
  double sfxwordColor = 0.25;

  double MusicborderColor = 0;
  double sfxborderColor = 0;

  bool Sfx ;
  bool Music ;


  @override
  void initState() {
    fn();
    xfn();
    // TODO: implement initState
    super.initState();
    initPlayer();
    WidgetsBinding.instance.addObserver(this);
  }

  String myUsername = "";
  var gamerequests = new Map();
  var newgamerequests = new Map();
  String room = "1";
  String roomname = "";
  bool visibleVar = false;
  List<String> names = ["شعارات جهات",'عشوائي',"شعارات مطاعم",'شعارات منتجات','شعارات سيارات','شعارات أندية','شعارات تقنية',"شعارات تطبيقات",'ألوان شعارات','شعارات ماركات','ترفيه عربي','ترفيه أجنبي','سيارات','مشاهير','كلمات',"ايموجيز",'معلومات عامة','جغرافيا','رياضيات'];
  String opTrophy = "";
  String opChar = "";


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

  Future<void> fn() async {

    Sfx = (await HelperFunctions.getSfx());
    if(Sfx==Null){Sfx=false;}
    Music = (await HelperFunctions.getMusic());
    if(Music==Null){Music=false;}


    if(Sfx==true){
      setState(() {sfxborderColor=1;
      sfxImageColor=0.25;
      sfxwordColor=1;

      });
    }

    if(Music==true){
      setState(() {
        MusicborderColor=1;
        MusicImageColor=0.25;
        MusicwordColor=1;

      });

    }

  }




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ Stack(
        children: [
          BackgroundImage3(),
          Center(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(

                  child:  SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:[ SizedBox(height: 30),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(splashColor: Colors.transparent,
                            child: Container(width: 50,height: 25,decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                            onTap: () {
                              if(Sfx==true){
                                audioCache2.play("click.mp3");}
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => menu(audioPlayer,audioCache,audioPlayer2,audioCache2)));
                            },

                          ),
                            SizedBox(width: 280,),
                          ]
                        ),
                        Center(child: Container(width: 160,height:380,alignment: Alignment.center,margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 60),child: Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                            InkWell(child:Container(child:Image.asset(
      'assets/images/audio.png',
      width:100,
      height: 100,),width:140,height: 140, alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white.withOpacity(sfxImageColor),borderRadius: BorderRadius.only(topRight: Radius.circular(100),topLeft: Radius.circular(100),bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100)),border: Border.all(color: Colors.white.withOpacity(sfxborderColor)),
      ),), onTap: () async {

      if(sfxborderColor==0){await HelperFunctions.saveSfx(true);
      Sfx=true;
        setState(() {sfxborderColor=1; });}
      else{await HelperFunctions.saveSfx(false);
      Sfx=false;
      setState(() {sfxborderColor=0; });}
      if(sfxImageColor==0.1){setState(() {sfxImageColor=0.25; });}
      else{setState(() {sfxImageColor=0.1; });}
      if(sfxwordColor==1){setState(() {sfxwordColor=0.25; });}
      else{setState(() {sfxwordColor=1; });}
      if(Sfx==true){
        audioCache2.play("click.mp3");}




      },

      ),

                            SizedBox(height: 15,),
                            Container(child:Text("مؤثرات صوتية",textAlign: TextAlign.center,style: TextStyle(color: Colors.white.withOpacity(sfxwordColor),fontWeight: FontWeight.w700),),),
                            SizedBox(height: 30,),
                            InkWell(child:Container(child:Image.asset(
                              'assets/images/music.png',
                              width:100,
                              height: 100,),width:140,height: 140, alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white.withOpacity(MusicImageColor),borderRadius: BorderRadius.only(topRight: Radius.circular(100),topLeft: Radius.circular(100),bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100)),border: Border.all(color: Colors.white.withOpacity(MusicborderColor)),
                              ),), onTap: () async {
                              if(MusicborderColor==0){await HelperFunctions.saveMusic(true);
                              audioPlayer.resume();
                              setState(() {MusicborderColor=1; });}
                              else{await HelperFunctions.saveMusic(false);
                              audioPlayer.pause();
                                setState(() {MusicborderColor=0; });}
                              if(MusicImageColor==0.15){setState(() {MusicImageColor=0.3; });}
                              else{setState(() {MusicImageColor=0.15; });}
                              if(MusicwordColor==1){setState(() {MusicwordColor=0.25; });}
                              else{setState(() {MusicwordColor=1; });}
                              if(Sfx==true){
                                audioCache2.play("click.mp3");}




                            },

                            ),
                            SizedBox(height: 15,),
                            Container(child:Text("موسيقى",textAlign: TextAlign.center,style: TextStyle(color: Colors.white.withOpacity(MusicwordColor),fontWeight: FontWeight.w700),),),
                          ],),
                        ),)),]
                  ),
                  )
              ),

            ),),

        ],
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
    if(Sfx==true){audioCache.play("click.mp3");}
    await FirebaseFirestore.instance.collection("users").doc(myUsername).update({
    "game requests" : newgamerequests,
    }).catchError((e) {
    print(e.toString());
    });

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
