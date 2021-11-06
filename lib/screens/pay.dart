
// @dart=2.9

import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class pay extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  pay(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);

  @override
  _payState createState() => _payState();
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

class _payState extends State<pay> with TickerProviderStateMixin  ,WidgetsBindingObserver {
  @override
  String coins = "";
  String hearts="";

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

  RewardedAd _rewardedAd;
  bool Music;

  void initState() {
    // TODO: implement initState
    super.initState();
    xfn();
    fn();
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
    Music= await HelperFunctions.getMusic();

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

  Future<void> fn() async {
    hearts = await HelperFunctions.getHeart();
    coins=await HelperFunctions.getCoin();
    if(hearts!=null){
      setState(() {
        hearts=hearts;


      });

    }
    else{setState(() {
      hearts="";


    });}
    if(coins!=null){
      setState(() {

        coins=coins;


      });}
    else{setState(() {
      coins="";


    });}
    print(coins);
    print(hearts);





  }

  Widget build(BuildContext context) {
    return Stack(
      children: [ Stack(
          children: [
            BackgroundImage4(),
            Center(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(

                  child:  SafeArea(child :Column(
                      children:[ SizedBox(height: 30),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(splashColor: Colors.transparent,
                                child: Container(width: 50,height: 25,decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                                onTap: () {
                                  if(Sfx==true){
                                    audioCache.play("click.mp3");}
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => menu(audioPlayer,audioCache,audioPlayer, audioCache)));

                                },

                              ),
                              SizedBox(width: 280,),
                            ]
                        ),
                        Container(child:Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                            Container(alignment: Alignment.center,
                                width: 50,
                                height: 40,
                                child:Text(hearts,style: TextStyle(color: Colors.white,fontSize: 20),)


                            ),
                            Container(child: Image.asset(
                              'assets/images/heart.png',
                              width: 50,
                              height: 100,
                            ),
                              width: 50,
                              height: 50,

                            ),
                            Container(
                                width: 20,
                                height: 10
                            ),
                            Container(alignment: Alignment.center,
                                width: 50,
                                height: 40,
                                child:Text( " "+ coins,style: TextStyle(color: Colors.white,fontSize: 20),)


                            ),

                            Center(
                              child: Container(child: Image.asset(
                                'assets/images/coin.png',
                                width: 100,
                                height: 100,),
                                width:60,
                                height: 60,
                              ),
                            ),










                          ],),
                        )),
                        SizedBox(height: 30,),
                        Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                          Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius:new BorderRadius.circular(20.0)),margin: EdgeInsets.symmetric(horizontal: 10),width:90,height: 90,
                            child:Column(children :[
                              SizedBox(height: 8,),Container(height: 35,margin: EdgeInsets.symmetric(vertical:
                              0),
                                child: Image.asset(
                                  'assets/images/3hearts.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              Container(margin: EdgeInsets.symmetric(vertical: 2),child:Text("10",style: TextStyle(color: Colors.white,fontSize: 17),)
                              ),

                              Container(margin: EdgeInsets.symmetric(vertical: 5),width: 70,height: 30,
                                child: new RaisedButton(color: Colors.greenAccent,
                                  elevation: 0.0,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0)),
                                  padding: EdgeInsets.only(
                                      top: 0.0, bottom: 0.0, right: 8.0, left: 8.0),
                                  onPressed: () async {

                                  if(int.parse(coins)>100){
                                    hearts=(int.parse(hearts)+10).toString();
                                    coins=(int.parse(coins)-100).toString();
                                    setState(() {
                                      coins=coins;
                                      hearts=hearts;
                                    });
                                    await HelperFunctions.saveHeart(hearts);
                                    await HelperFunctions.saveCoin(coins);




                                  }

                                    print("non");
                                    if(Sfx==true){
                                      audioCache.play("click.mp3");}
                                  },

                                  child: new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: new Text(
                                            "100",
                                            style: TextStyle(
                                                fontSize: 15.0, fontWeight: FontWeight.bold),
                                          )),
                                      new Image.asset(
                                        'assets/images/coin.png',
                                        height: 20.0,
                                        width: 20.0,
                                      ),

                                    ],),),
                              ),
                              Container(decoration: BoxDecoration(border:Border.symmetric(horizontal:BorderSide.none ) ),),



                              /*ElevatedButton.icon(
      icon: Icon(
      Icons.monetization_on,
      color: Colors.amber,
      size: 28.0,
      ),
      label: Text('Login with facebook',
      style: TextStyle(fontSize: 20),),
      onPressed: () {}

      ),*/

                            ],
                            ),
                          ),

                          Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius:new BorderRadius.circular(20.0)),margin: EdgeInsets.symmetric(horizontal: 10),width:90,height: 90,
                            child:Column(children :[
                              SizedBox(height: 8,),Container(height: 35,margin: EdgeInsets.symmetric(vertical:
                              0),
                                child: Image.asset(
                                  'assets/images/3hearts.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              Container(margin: EdgeInsets.symmetric(vertical: 2),child:Text("20",style: TextStyle(color: Colors.white,fontSize: 17),)
                              ),

                              Container(margin: EdgeInsets.symmetric(vertical: 5),width: 70,height: 30,
                                child: new RaisedButton(color: Colors.greenAccent,
                                  elevation: 0.0,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0)),
                                  padding: EdgeInsets.only(
                                      top: 0.0, bottom: 0.0, right: 8.0, left: 8.0),
                                  onPressed: () async {
                                    if(int.parse(coins)>175){
                                      hearts=(int.parse(hearts)+20).toString();
                                      coins=(int.parse(coins)-175).toString();
                                      setState(() {
                                        coins=coins;
                                        hearts=hearts;
                                      });
                                      await HelperFunctions.saveHeart(hearts);
                                      await HelperFunctions.saveCoin(coins);




                                    }
                                    print("non");
                                    if(Sfx==true){
                                      audioCache.play("click.mp3");}
                                  },

                                  child: new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: new Text(
                                            "175",
                                            style: TextStyle(
                                                fontSize: 15.0, fontWeight: FontWeight.bold),
                                          )),
                                      new Image.asset(
                                        'assets/images/coin.png',
                                        height: 20.0,
                                        width: 20.0,
                                      ),

                                    ],),),
                              ),
                              Container(decoration: BoxDecoration(border:Border.symmetric(horizontal:BorderSide.none ) ),),



                              /*ElevatedButton.icon(
      icon: Icon(
      Icons.monetization_on,
      color: Colors.amber,
      size: 28.0,
      ),
      label: Text('Login with facebook',
      style: TextStyle(fontSize: 20),),
      onPressed: () {}

      ),*/

                            ],
                            ),
                          ),
                          Stack(
                            children: [Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius:new BorderRadius.circular(20.0)),margin: EdgeInsets.symmetric(horizontal: 10),width:90,height: 90,
                              child:Column(children :[
                                SizedBox(height: 8,),Container(height: 35,margin: EdgeInsets.symmetric(vertical:
                                0),
                                  child: Image.asset(
                                    'assets/images/3hearts.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                Container(margin: EdgeInsets.symmetric(vertical: 2),child:Text("30",style: TextStyle(color: Colors.white,fontSize: 17),)
                                ),

                                Container(margin: EdgeInsets.symmetric(vertical: 5),width: 70,height: 30,
                                  child: new RaisedButton(color: Colors.greenAccent,
                                    elevation: 0.0,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(20.0)),
                                    padding: EdgeInsets.only(
                                        top: 0.0, bottom: 0.0, right: 8.0, left: 8.0),
                                    onPressed: () async {
                                      if(int.parse(coins)>225){
                                        hearts=(int.parse(hearts)+30).toString();
                                        coins=(int.parse(coins)-225).toString();
                                        setState(() {
                                          coins=coins;
                                          hearts=hearts;
                                        });
                                        await HelperFunctions.saveHeart(hearts);
                                        await HelperFunctions.saveCoin(coins);




                                      }
                                      print("non");
                                      if(Sfx==true){
                                        audioCache.play("click.mp3");}
                                    },

                                    child: new Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(right: 5.0),
                                            child: new Text(
                                              "225",
                                              style: TextStyle(
                                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                                            )),
                                        new Image.asset(
                                          'assets/images/coin.png',
                                          height: 20.0,
                                          width: 20.0,
                                        ),

                                      ],),),
                                ),
                                Container(decoration: BoxDecoration(border:Border.symmetric(horizontal:BorderSide.none ) ),),



                                /*ElevatedButton.icon(
      icon: Icon(
      Icons.monetization_on,
      color: Colors.amber,
      size: 28.0,
      ),
      label: Text('Login with facebook',
      style: TextStyle(fontSize: 20),),
      onPressed: () {}

      ),*/

                              ],
                              ),
                            ),]
                          ),
                        ],)),
                        Container(margin:EdgeInsets.symmetric(horizontal: 20,vertical: 30),alignment: Alignment.center,child: Text("الباقات",style: TextStyle(fontSize: 20,color: Colors.white,),),),
                        Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),borderRadius: BorderRadius.circular(20.0)),width: 360,height: 70,child:Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(margin: EdgeInsets.symmetric(vertical: 5),width: 70,height: 30,
                              child: new RaisedButton(color: Colors.black,
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20.0)),
                                padding: EdgeInsets.only(
                                    top: 0.0, bottom: 0.0, right: 0.0, left: 0.0),
                                onPressed: () {
                                  print("non");
                                  if(Sfx==true){
                                   // audioCache.play("click.mp3");
                                   }

                                  RewardedAd.load(
                                      adUnitId: 'ca-app-pub-2346389603430594/5014282322',
                                      request: AdRequest(),
                                      rewardedAdLoadCallback: RewardedAdLoadCallback(
                                        onAdLoaded: (RewardedAd ad) {
                                          print('$ad loaded.');
                                          // Keep a reference to the ad so you can show it later.
                                          this._rewardedAd = ad;
                                        },
                                        onAdFailedToLoad: (LoadAdError error) {
                                          print('RewardedAd failed to load: $error');
                                        },
                                      ));

                                  _rewardedAd.show(
                                      onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
                                        // action to reward the app user
                                      });





                                },

                                child: new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(right: 5.0,left:5),
                                        child: new Text(
                                          "ريال  5",
                                          style: TextStyle(
                                              fontSize: 15.0, fontWeight: FontWeight.bold,color:Colors.white),
                                        )),


                                  ],),),
                            ),
                            SizedBox(width:20),


                            Container(alignment: Alignment.center,
                                width: 30,
                                height: 40,
                                child:Text("50",style: TextStyle(color: Colors.white,fontSize: 15),)


                            ),
                            Center(child: Container(child: Image.asset(
                              'assets/images/coin.png',
                              width: 35,
                              height: 35,),
                              width:35,
                              height: 35,
                            ),),


                            Container(alignment: Alignment.center,
                                width: 35,
                                height: 40,
                                child:Text( " "+ "1",style: TextStyle(color: Colors.white,fontSize: 15),)


                            ),

                            Center(child:
                            Container(child: Image.asset(
                              'assets/images/heart.png',
                              width: 30,
                              height: 30,),
                              width:30,
                              height: 30,

                            ),



                            ),
                            SizedBox(width: 20,),
                            CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius: 25,
                              child: Center(child:
                              Container(child: Image.asset(
                                'assets/images/heartscoin.png',
                                width: 55,
                                height: 55,),
                                width:55,
                                height: 55,

                              ),



                              ),
                            ),










                          ],),
                        )),
                        SizedBox(height:10),
                        Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),borderRadius: BorderRadius.circular(20.0)),width: 360,height: 70,child:Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(margin: EdgeInsets.symmetric(vertical: 5),width: 70,height: 30,
                              child: new RaisedButton(color: Colors.black,
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20.0)),
                                padding: EdgeInsets.only(
                                    top: 0.0, bottom: 0.0, right: 0.0, left: 0.0),
                                onPressed: () {
                                  print("non");
                                  if(Sfx==true){
                                    audioCache.play("click.mp3");}
                                },

                                child: new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(right: 5.0,left:5),
                                        child: new Text(
                                          "ريال  10",
                                          style: TextStyle(
                                              fontSize: 15.0, fontWeight: FontWeight.bold,color:Colors.white),
                                        )),


                                  ],),),
                            ),
                            SizedBox(width:20),


                            Container(alignment: Alignment.center,
                                width: 30,
                                height: 40,
                                child:Text("125",style: TextStyle(color: Colors.white,fontSize: 15),)


                            ),
                            Center(child: Container(child: Image.asset(
                              'assets/images/coin.png',
                              width: 35,
                              height: 35,),
                              width:35,
                              height: 35,
                            ),),


                            Container(alignment: Alignment.center,
                                width: 35,
                                height: 40,
                                child:Text( " "+ "3",style: TextStyle(color: Colors.white,fontSize: 15),)


                            ),

                            Center(child:
                            Container(child: Image.asset(
                              'assets/images/heart.png',
                              width: 30,
                              height: 30,),
                              width:30,
                              height: 30,

                            ),



                            ),
                            SizedBox(width: 20,),
                            CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius: 25,
                              child: Center(child:
                              Container(child: Image.asset(
                                'assets/images/heartscoin.png',
                                width: 55,
                                height: 55,),
                                width:55,
                                height: 55,

                              ),



                              ),
                            ),










                          ],),
                        )),
                        SizedBox(height:10),
                        Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),borderRadius: BorderRadius.circular(20.0)),width: 360,height: 70,child:Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(margin: EdgeInsets.symmetric(vertical: 5),width: 70,height: 30,
                              child: new RaisedButton(color: Colors.black,
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20.0)),
                                padding: EdgeInsets.only(
                                    top: 0.0, bottom: 0.0, right: 0.0, left: 0.0),
                                onPressed: () {
                                  print("non");
                                  if(Sfx==true){
                                    audioCache.play("click.mp3");}
                                },

                                child: new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(right: 5.0,left:5),
                                        child: new Text(
                                          "ريال  30",
                                          style: TextStyle(
                                              fontSize: 15.0, fontWeight: FontWeight.bold,color:Colors.white),
                                        )),


                                  ],),),
                            ),
                            SizedBox(width:20),


                            Container(alignment: Alignment.center,
                                width: 30,
                                height: 40,
                                child:Text("400",style: TextStyle(color: Colors.white,fontSize: 15),)


                            ),
                            Center(child: Container(child: Image.asset(
                              'assets/images/coin.png',
                              width: 35,
                              height: 35,),
                              width:35,
                              height: 35,
                            ),),


                            Container(alignment: Alignment.center,
                                width: 35,
                                height: 40,
                                child:Text( " "+ "10",style: TextStyle(color: Colors.white,fontSize: 15),)


                            ),

                            Center(child:
                            Container(child: Image.asset(
                              'assets/images/heart.png',
                              width: 30,
                              height: 30,),
                              width:30,
                              height: 30,

                            ),



                            ),
                            SizedBox(width: 20,),
                            CircleAvatar(backgroundColor: Colors.white.withOpacity(0.2),radius: 25,
                              child: Center(child:
                              Container(child: Image.asset(
                                'assets/images/heartscoin.png',
                                width: 55,
                                height: 55,),
                                width:55,
                                height: 55,

                              ),



                              ),
                            ),










                          ],),
                        )),




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