// @dart=2.9

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/choice.dart';
import 'package:wechou/screens/music.dart';
import 'package:wechou/screens/pay.dart';
import 'package:wechou/screens/profile.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/screens/trophy.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wechou/widget/background3.dart';


class menu extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  menu(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);


  @override
  _menuState createState() => _menuState();
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

class _menuState extends State<menu> with TickerProviderStateMixin,WidgetsBindingObserver{

  String trophy1 ='';
  String hearts ='';
  bool Sfx ;
  bool Music ;

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

  Future<void> xfn() async {
    fn();

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

  Future<void> fn() async {


    hearts = await HelperFunctions.getHeart();
    trophy1=await HelperFunctions.getTrophy();
    if(hearts!=null){
      setState(() {
        hearts=hearts;


      });

    }
    else{setState(() {
      hearts="";


    });}
    if(trophy1!=null){
      setState(() {

        trophy1=trophy1;


      });}
    else{setState(() {
      trophy1="";


    });}
    print(trophy1);
    print(hearts);





  }









  @override
  Widget build(BuildContext context) {

    return Center(
        child: Stack(
          children:[ Stack(
          children: [
          //BackgroundImage1(),
    Center(
    child: Scaffold(
      appBar: AppBar(


          centerTitle: true,

          title: Center(
            child: Row(mainAxisSize: MainAxisSize.min,
              children:[

                  InkWell(
                    child: Container(child: Image.asset(
    'assets/images/profile.png',
    width: 35,
      height: 35,),
    width: 35,
    height: 35,),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => Profile()));
                      if(Sfx==true){
                        audioCache2.play("click.mp3");}
                    },
                  ),

                Container(

                  width: 30,
                  height: 35,),
                Container(width: 155,
                height: 40,alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF).withOpacity(0.1),

                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(children: [
                    Container(
                      width: 3,
                      height: 2,
                    ),
                    Container(alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      child:Text(trophy1)


                    ),
                    Center(
                      child: InkWell(
                        child: Container(child: Image.asset(
                          'assets/images/Trophy.png',
                          width: 35,
                          height: 35,),
                          width: 35,
                          height: 35,
                        ),onTap: () {

                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => trophy(audioPlayer,audioCache,audioPlayer2,audioCache2)));
                        if(Sfx==true){
                          audioCache2.play("click.mp3");}

                      },
                      ),
                    ),

                  Container(alignment: Alignment.center,
                  width: 40,
                  height: 40,
                      child:Text(hearts)


                    ),
                    InkWell(child:Container(child: Image.asset(
                      'assets/images/heart.png',
                      width: 2,
                      height: 2,
                    ),
                      width: 30,
                      height: 30,

                    ),onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => pay(audioPlayer,audioCache,audioPlayer2,audioCache2)));
                      if(Sfx==true){
                        audioCache2.play("click.mp3");}

                    },),






                  ],),
                )

              ),
              Container(

                width: 30,
                height: 35,),
                InkWell(
                  child: Container(child: Image.asset(
                    'assets/images/setting.png',
                    width: 35,
                    height: 35,),
                    width: 35,
                    height: 35,),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => music(audioPlayer,audioCache,audioPlayer, audioCache)));
    if(Sfx==true){
    audioCache2.play("click.mp3");}
                  },
                ),],
            ),
          ),



          backgroundColor: Colors.indigo,




      ),
      bottomNavigationBar: Container(color:Colors.indigo,
            alignment: Alignment.center,
            height: 25,

      ),



    backgroundColor: Colors.transparent,
    body: SingleChildScrollView(

    child:  SafeArea(child :GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,


      crossAxisCount: 2,
      children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Text("شعارات جهات",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w800),),

            ),
            onTap: () async {

              await HelperFunctions.saveRoom("1");
              print("Tapped on container");
              if(Sfx==true){
              audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));}



          ),
          InkWell(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Text('عشوائي',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),

            ),
            onTap: () async {
              await HelperFunctions.saveRoom("2");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Text('شعارات مطاعم',style: TextStyle(color: Colors.brown,fontWeight: FontWeight.w800),),

            ),
            onTap: () async {
              await HelperFunctions.saveRoom("3");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },
          ),

          InkWell(child :
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/4.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('شعارات منتجات',style: TextStyle(color: Colors.brown,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("4");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/6.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('شعارات سيارات',style: TextStyle(color: Colors.lightGreen,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("6");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/5.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('شعارات أندية',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("5");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/8.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('شعارات تقنية',style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("8");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/7.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text("شعارات تطبيقات",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("7");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/9.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: const Text('ألوان شعارات',style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("9");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/10.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('شعارات ماركات',style: TextStyle(color: Colors.indigoAccent,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("10");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/11.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('ترفيه عربي',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("11");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/12.png"),

                fit: BoxFit.cover,
              ),
            ),
            child: const Text('ترفيه أجنبي',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("12");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/13.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('سيارات',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("13");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/14.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('مشاهير',style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("14");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/16.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('كلمات',style: TextStyle(color: Colors.brown,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("16");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/15.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text("ايموجيز",style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("15");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/17.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: const Text('معلومات عامة',style: TextStyle(color: Colors.brown,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("17");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/18.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('جغرافيا',style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("18");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/19.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('رياضيات',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("19");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
          InkWell(child:
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/20.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text('أعلام',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w800),),

          ),
            onTap: () async {
              await HelperFunctions.saveRoom("20");
              if(Sfx==true){
                audioCache2.play("click.mp3");}
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2,audioCache2)));
            },),
      ],
    )
    )
    ),

    ),
    ),
          ]
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
        ),);
  }
}
