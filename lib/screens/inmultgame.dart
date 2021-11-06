// @dart=2.9

import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/adhelpers.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/gameended.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/widget/background1.dart';

class inmultigame extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  AudioPlayer audioPlayer2;
  AudioCache audioCache2;


  var nameTab = [];
  var charTab = [];
  inmultigame(this.audioPlayer2,this.audioCache2,this.nameTab,this.charTab);

  @override
  _inmultigameState createState() => _inmultigameState();
}
AnimationController _animationIconController1;

AudioCache audioCache;

AudioPlayer audioPlayer;

//int _duration = new Duration();
//int _position = new Duration();

bool issongplaying = false;

bool isplaying = false;
String gifNumber = "";



void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}

class _inmultigameState extends State<inmultigame> with TickerProviderStateMixin,WidgetsBindingObserver{
  final interval = const Duration(seconds: 1);

  bool condition=false;
  bool condition1=true;




  List blendColorTab = ["1","1","1","1"];
  List charTabSp=[];


  int timerMaxSeconds = 20;
  String points="0";
  String question="";
  String image="";
  String answer1="";
  String answer2="";
  String answer3="";
  String answer4="";
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

  AdmobHelper admobHelper = new AdmobHelper();

  int Z1=0;
  int Z2=0;
  int Z3=0;
  int Z4=0;
  int rnb=1;
  int mnb=0;
  String name1 ="";
  String name2="";
  String name3 ="";
  String name4 ="";
  String char1 ="char1";
  String char2="char1";
  String char3 ="char1";
  String char4 ="char1";
  String point1 ="0";
  String point2="0";
  String point3 ="0";
  String point4 ="0";
  double q1=0.3;
  double q2=0.3;
  double q3=0.3;
  double q4=0.3;
  double q5=0.3;

  String myUsername = "";

  String myEmoji = "";
  String myGif = "";

  String sendName = "";


  String testtest = "habhibo";


  bool test = false;

  bool answered =false;


  int emoTextColor = 0;
  int gifTextColor = 255;

  int gifBorderColor = 255;
  int emoBorderColor = 255;

  double gifContainerColor = 0;
  double emoContainerColor = 1;

  var nameTab = [];
  var charTab = [];
  var nameTabsp =[];











  bool Sfx ;
  bool Music ;

  int nbInt = 0;

  int Faza = 0;


  String realanswer="";

  bool isFirst = true;

  int size = 0;
  int nb = 0;
  String nbstr = "0";

  bool visiblevar = false;
  bool visiblevar2 = false;
  //bool visiblevar3 = false;
  //bool visiblevar4 = false;


  String room = "";
  List options = [];

  List gifList = ["aa","bb","cc","dd","ee","ff","gg","hh","ii","jj","kk","rr","ll","mm","nn","oo","pp","qq"];

  String gifShow = "";
  String emojiShow = "";



  List emoji = [];
  List statutTab = [];

  List pointsTabSp = [];

  List rangTab = [];

  String emoNumber = "";






  String heartLeft = "10";
  String levels = "10";
  String endPoints="0";


  var musList = ['mus1', 'mus2', 'mus3','mus4', 'mus5', 'mus6'];
  var turn = ['question', 'answer'];
  var questionsList = [];




  int currentSeconds = 0;
  int currentMinutes = 0;
  int timerMaxMinutes = 0;

  String conatctName = "";

  bool visibleVar3 = false;
  bool visibleVar4 = false;
  bool visibleVar5 = false;

  String onlineRoom ="";

  List pointsTab = [];

  String rang = "";

  List resultTab = [];

  AudioCache audioCache2;

  AudioPlayer audioPlayer2;
















  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';


  startTimeout([int milliseconds]) {

    var duration = interval;

    Timer.periodic(duration, (timer) {
      setState(() async {




        if (timer.tick ==20 && answered==false){

          await CheckForUpdateSp();
          print("this is the previous ");
          print(resultTab);
          print(charTab);
          print(pointsTabSp);




            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => gameended(audioPlayer,audioCache,audioPlayer2,audioCache2,charTab,pointsTabSp,resultTab)));



          }
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

  Future<void> sendGif(String name,String gif) async {

    await FirebaseFirestore.instance.collection(onlineRoom).doc(name).update({
      "gif" : gif+myUsername,
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> sendEmoji(String name, String emoji) async {
    await FirebaseFirestore.instance.collection(onlineRoom).doc(name).update({
      "emoji" : emoji+myUsername,
    }).catchError((e) {
      print(e.toString());
    });

  }

  Future<void> checkUpdate() async {

    nameTab=widget.nameTab;

    for(int i=0;i<nameTab.length;i++){emoji.add("empty");}
    await FirebaseFirestore.instance
        .collection(onlineRoom).where("username", isEqualTo : myUsername)
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          size = value.size;
          myEmoji = value.docs[0].data()["emoji"];
          myGif = value.docs[0].data()["gif"];
        }
      });
    });

    if(myEmoji!="-1"){
      print("ahaya aasba");
      print(widget.nameTab.indexOf(myEmoji.substring(1)));
      setState(() {
        emoji[widget.nameTab.indexOf(myEmoji.substring(1))]="emo"+(myEmoji.substring(0,1)).toString();
      });
      await FirebaseFirestore.instance.collection(onlineRoom).doc(myUsername).update({
        "emoji" : "-1",
      }).catchError((e) {
        print(e.toString());
      });





    }
    if(myEmoji=="-1"){
      setState(() {
        for(int i =0;i<emoji.length;i++){
        emoji[i] = ["empty"];
        }

      });




    }

    if(myGif!="-1"){
      setState(() {
        conatctName=myGif.substring(1);
        gifShow=gifList[int.parse(myGif.substring(0,1))-1];
        visibleVar5=true;

      });
      await FirebaseFirestore.instance.collection(onlineRoom).doc(myUsername).update({
        "gif" : "-1",
      }).catchError((e) {
        print(e.toString());
      });
    }

    await FirebaseFirestore.instance
        .collection(onlineRoom).where("identifier", isEqualTo : "player")
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          size = value.size;
          print(size = value.size);
          for(int index = 0 ; index < size; index++){
            pointsTab[index]=(value.docs[index].data()["points"]);
            statutTab[index]=(value.docs[index].data()["statut"]);


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
          statutTab[statutTab.length-1]=(value.docs[0].data()["statut"]);
          pointsTab[statutTab.length-1]=(value.docs[0].data()["points"]);

        }
      });
    });

    setState(() {
      pointsTab=pointsTab;
    });
    for(int i =0;i<statutTab.length;i++){


      if(statutTab[i]!="1"){


        rang=(int.parse(rang)+1).toString();

        resultTab.add(widget.nameTab[i]);


        setState(() {
          blendColorTab[i]="0,5";
        });

      }
    }

  }

  Future<void> CheckForUpdateSp() async {


    print("begin checkForupdatesp");
    print(pointsTab);



    await FirebaseFirestore.instance
        .collection(onlineRoom).where("identifier", isEqualTo : "player")
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          size = value.size;

          print('this is size');
          print(size);


          for(int index = 0 ; index < size; index++){
            pointsTab[index]=(value.docs[index].data()["points"]);
            statutTab[index]=(value.docs[index].data()["statut"]);


          }
        }
      });
    });

    print("aaaaaaaaaaaaaaaaaaaaaaaaa");
    print(pointsTab);
    print(statutTab);
    print("bbbbbbbbbbbbbbbbbbbbbbbbb");

    await FirebaseFirestore.instance
        .collection(onlineRoom).where("identifier", isEqualTo : "host")
        .get()
        .then((value) {
      setState((){
        if (value != null) {
          print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          print(value);
          statutTab[statutTab.length-1]=(value.docs[0].data()["statut"]);
          pointsTab[statutTab.length-1]=(value.docs[0].data()["points"]);

        }
      });
    });
    rang="1";
    print("searching");


    print("cccccccccccccccccccccccc");


    print(pointsTab);

    for(int i=0;i<pointsTab.length;i++){

      pointsTabSp.add(pointsTab[i]);
      nameTabsp.add(widget.nameTab[i]);

    }







    pointsTabSp.sort();
    print(pointsTabSp);


    print(widget.nameTab);

    print(resultTab);

    print(charTab);




    for(int i=0;i<widget.nameTab.length;i++){

    resultTab[i]=nameTabsp[pointsTab.indexOf(pointsTabSp[i])];




    charTabSp[i]=widget.charTab[pointsTab.indexOf(pointsTabSp[i])];




  }
    print("this is result tab");
    print(resultTab);

    print("dddddddddddddddddddddddd");

    print("end checkForupdatesp");


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
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    audioPlayer2 = widget.audioPlayer2;
    audioCache2 = widget.audioCache2;
    /*setState(() {
      _duration = audioPlayer.getDuration() as Duration;
    });

    setState(() {
      _position = audioPlayer.getCurrentPosition() as Duration;
    });*/
  }



  void initState() {
    //WidgetsBinding.instance.addObserver(this);
    super.initState();
    initPlayer();

    fn();




  }

  Future<void> getHeart() async {
    await HelperFunctions.saveHeart(2.toString());
    heartLeft = await HelperFunctions.getHeart();
    setState(() {
      heartLeft;
    });
  }

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

  Future<void> fnV2() async {

    print("begin fn2");


    for(int i =0;i<widget.nameTab.length;i++){


      statutTab.add("0");
      resultTab.add("0");
      charTabSp.add("0");


    }
    charTab=widget.charTab;

    print("aaaaaaaaaaaaaaaaaa");
    print(widget.nameTab.length);
    for(int i=0;i<widget.nameTab.length;i++){

      pointsTab.add("0");
      emoji.add("empty");}

    setState(() {
      emoji=emoji;
      pointsTab=pointsTab;
    });
    print("this is emoji");
    print("this is emoji");
    print(emoji);

    myUsername=await HelperFunctions.getname();





    onlineRoom =(await HelperFunctions.getOnlineRoom());



    print("end fn2");}


  Future<void> fn() async {


    fnV2();
    getHeart();



    print(testtest.substring(0,1));
    print(testtest.substring(1));

    startTimeout();
    musList.shuffle();
    Sfx = await HelperFunctions.getSfx();
    Music = await HelperFunctions.getMusic();
    print(Sfx);
    print(Music);

    if(Music==true){
      print("aaaaaaaaaaaa");
      audioCache.play(musList[0]+".mp3");}
    else{audioCache.play(musList[0]+".mp3");
    audioPlayer.pause();}



    await HelperFunctions.saveRoom("1");

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


    print("end fn");


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
                  preferredSize: Size(200,90),
                  //Size.fromHeight(100.0), // here the desired height
                  child:AppBar(automaticallyImplyLeading: false, // hides leading widget
                    flexibleSpace:
                        Stack(alignment: Alignment.centerRight,children:[Container(color : Color.fromARGB(253, 247, 210, 210),),
                    Container(color : Colors.deepOrangeAccent,width: ((20 - Faza) * (MediaQuery
        .of(context)
        .size
        .width / 20)).toDouble(),),
    Container(alignment: Alignment.centerLeft,color : Colors.transparent,width: 400,


                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [Column(children: [SizedBox(height:50),
                            Center(
                              child: Container(width:400,child:Row(mainAxisAlignment: MainAxisAlignment.center,
                                //mainAxisSize: MainAxisSize,
                                children: <Widget>[Stack(
                                    children: [Container(width:135,height:35,decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3),borderRadius: BorderRadius.circular(10)),child:Column(children: [
                                      Container(margin: EdgeInsets.fromLTRB(75, 9.0, 9.0, 10),alignment: Alignment.center,child: Center(child: Text(timerText,textAlign: TextAlign.center,style:TextStyle(color: Colors.white))))
                                    ],)),Container(width:70,height:35,decoration: BoxDecoration(color: Colors.red.withOpacity(0.7),borderRadius: BorderRadius.circular(10)),child:Center(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                        Icon(Icons.pause,color: Colors.white,),InkWell(child: Container(child:Text("وقف  ",style: TextStyle(fontSize: 17,color: Colors.white),)),onTap: () {
                                          print("Tapped on container");
                                          setState(() {
                                            visiblevar=true;
                                          });
                                        }


                                        ),
                                      ],),
                                    )),

                                    ]
                                ),SizedBox(width: 250,),



                                ],

                              ),
                              ),),],
                          ),
                            //Container(width:160)
    ]
                      ),
                    ),

                    //backgroundColor: Color.fromARGB(253, 247, 210, 210),
                  ]),),),
                bottomNavigationBar: condition? InkWell(
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),color:Colors.tealAccent),
                      alignment: Alignment.center,
                      height: 70,child:Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_outlined,size: 25,),
                          Text(' كمل',style: TextStyle(fontSize: 25),),


                        ],
                      )

                  ),onTap: () async {
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
                      checkUpdate();

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
                ): null,
                backgroundColor: Colors.transparent,
                body:SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,

                      children:[
    Center(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Container(width:70,height: 6,color: Colors.white.withOpacity(q1),),
      Container(width:2,height: 6,color: Colors.white),
      Container(width:70,height: 6,color: Colors.white.withOpacity(q2),),
      Container(width:2,height: 6,color: Colors.white),
      Container(width:70,height:6,color: Colors.white.withOpacity(q3),),
      Container(width:2,height: 6,color: Colors.white),
      Container(width:70,height: 6,color: Colors.white.withOpacity(q4),),
      Container(width:2,height: 6,color: Colors.white),
      Container(width:70,height: 6,color: Colors.white.withOpacity(q5),),

    ]),),

                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(height:150,child:
    ListView.builder(
    scrollDirection: Axis.horizontal,
    //padding: const EdgeInsets.all(8),

    shrinkWrap: true,

    itemCount: widget.nameTab.length,
    itemBuilder: (BuildContext context, int index) {
    return
    Column(mainAxisAlignment:MainAxisAlignment.center,
                              children: [Container(child:Stack(alignment:Alignment.topLeft
                                  ,children: [Stack(alignment:Alignment.bottomCenter,children: [
                                    InkWell(
                                      child: Center(child:Container(child:Image.asset(
                                        'assets/images/char'+widget.charTab[index]+'.png',
                                        color :Color.fromRGBO(255, 255, 255, double.parse(blendColorTab[index])),
                                        colorBlendMode: BlendMode.modulate,
                                        width: 65,
                                        height: 65,
                                      ),
                                        width: 65,
                                        height:65,
                                      ),),onTap: () {
                                      if(widget.nameTab[index]!=myUsername){setState(() {
                                        visibleVar3=true;
                                        sendName=widget.nameTab[index];
                                      });}
                                    },
                                    ),
                                    Column(mainAxisAlignment: MainAxisAlignment.center,
                                        children:[ SizedBox(height:00),Center(
                                          child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.black),child:
                                          Container(alignment:Alignment.center,child:Text(widget.nameTab[index],style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.w800),)),

                                          ),
                                        ),

                                        ]),
                                  ]), Column(
                                      children: [
                                        Row(
                                            children: [SizedBox(width: 0,),Container(child:Image.asset(
                                              'assets/images/emo'+emoji[index]+'.png',
                                              color:  Color.fromRGBO(255, 255, 255, double.parse("10")),
                                              colorBlendMode: BlendMode.modulate,
                                              width: 20,
                                              height: 20,
                                            ),
                                              width: 20,
                                              height:20,
                                            ),SizedBox(width: 00,)]
                                        ),
                                        SizedBox(height: 0,),]
                                  ),]
                              ),),

                                Container(child : Text(pointsTab[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)))]);}),
                        ), ],),

                        
                        Stack(
                            children:[ Container(width:280,height:350,decoration: BoxDecoration(image: DecorationImage(image:new ExactAssetImage('assets/images/white.png',),

                            ),
                            ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(height: 5),Container(child: Text(question,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),),
                                SizedBox(height: 20,),
                                Container(child:Image.asset(
                                  'assets/images/questions/' + image + ".png",
                                  width: 70,
                                  height: 70,
                                ),
                                  width: 70,
                                  height: 70,
                                ),
                                SizedBox(height: 10,),
                                Center(child: InkWell(
                                  child: Container(padding:EdgeInsets.all(8),decoration: BoxDecoration(color: Color.fromARGB(255, R1, G1, B1),borderRadius: BorderRadius.circular(10),border: Border.all(
                                    color: Colors.grey,
                                    width:1,

                                  ),),width:180,height:40,child: Text(answer1,textAlign: TextAlign.center,style: TextStyle(color:Color.fromARGB(255, Z1, Z1, Z1),fontSize: 18,fontWeight: FontWeight.w400),) ,),onTap: () {
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
                                  child: Container(padding:EdgeInsets.all(8),decoration: BoxDecoration(color: Color.fromARGB(255, R2, G2, B2),borderRadius: BorderRadius.circular(10),border: Border.all(
                                    color: Colors.grey,
                                    width:1,

                                  ),),width:180,height:40,child: Text(answer2,textAlign: TextAlign.center,style: TextStyle(color:Color.fromARGB(255, Z2, Z2, Z2),fontSize: 18,fontWeight: FontWeight.w400),) ,),
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
                                  child: Container(padding:EdgeInsets.all(8),decoration: BoxDecoration(color: Color.fromARGB(255, R3, G3, B3),borderRadius: BorderRadius.circular(10),border: Border.all(
                                    color: Colors.grey,
                                    width:1,

                                  ),),width:180,height:40,child: Text(answer3,textAlign: TextAlign.center,style: TextStyle(color:Color.fromARGB(255, Z3, Z3, Z3),fontSize: 18,fontWeight: FontWeight.w400),) ,)
                                  ,onTap: () {
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
                                  child: Container(padding:EdgeInsets.all(8),decoration: BoxDecoration(color: Color.fromARGB(255, R4, G4, B4),borderRadius: BorderRadius.circular(10),border: Border.all(
                                    color: Colors.grey,
                                    width:1,

                                  ),),width:180,height:40,child: Text(answer4,textAlign: TextAlign.center,style: TextStyle(color:Color.fromARGB(255, Z4, Z4, Z4),fontSize: 18,fontWeight: FontWeight.w400),) ,)
                                  ,onTap: () {
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
                                    ), onTap: () {
                                    print("Tapped on container");
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
                                    ), onTap: () {
                                    print("Tapped on container");
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
                                    child: Text(rang, style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),),),
                                  Container(width: 100,
                                    height: 40,
                                    child: Text("الترتيب", style: TextStyle(
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
                                  await FirebaseFirestore.instance.collection(onlineRoom).doc(myUsername).update({
                                    "statut" : "0",
                                  }).catchError((e) {
                                    print(e.toString());
                                  });
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
                                },),
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

                                  await FirebaseFirestore.instance.collection(onlineRoom).doc(myUsername).update({
                                    "statut" : "0",
                                  }).catchError((e) {
                                    print(e.toString());
                                  });


                                  print("Tapped on container");
                                  audioPlayer.stop();
                                  audioCache.play("intro.mp3");
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          menu(audioPlayer, audioCache,audioPlayer2, audioCache2)));
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

          Visibility(
    visible : visibleVar3,
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
                        child:

                        SafeArea(child : Column(mainAxisAlignment: MainAxisAlignment.center,children:[ SizedBox(height: 30),

                          Container(margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
                                InkWell(
                                  child: Container(width: 80,height: 25,decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                                  onTap: () {
                                    setState(() {
                                      visibleVar3=false;

                                    });
                                    print("Tapped on container");
                                  },

                                ),
                                Container(width: 90,),
                                Center(child: Container(width:150,)),
                              ]

                              ),),
                          ),

                          SizedBox(height:45),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                            InkWell(
                              child: Container(alignment: Alignment.center
                                  ,width: 100,height: 25,decoration:BoxDecoration(color:Color.fromARGB(255, 0, 255, 255).withOpacity(emoContainerColor),border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("إيموجي",style: TextStyle(color: Color.fromARGB(255, emoTextColor, emoTextColor, emoTextColor),fontSize:15,fontWeight: FontWeight.w500),)),
                              onTap: () {
                                setState(() {
                                  visibleVar3=true;
                                  visibleVar4=false;
                                  emoTextColor = 0;
                                  gifTextColor = 255;
                                  emoContainerColor=1;
                                  gifContainerColor=0;
                                });

                              },),
                            SizedBox(width:30),

                            InkWell(
                              child: Container(alignment: Alignment.center
                                  ,width: 100,height: 25,decoration:BoxDecoration(color:Color.fromARGB(255, 0, 255, 255).withOpacity(gifContainerColor),border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("ردة فعل",style: TextStyle(color: Color.fromARGB(255, gifTextColor, gifTextColor, gifTextColor),fontSize:15,fontWeight: FontWeight.w500),)),
                              onTap: () {
                                setState(() {
                                  visibleVar3=false;
                                  visibleVar4=true;
                                  emoTextColor = 255;
                                  gifTextColor = 0;
                                  gifContainerColor=1;
                                  emoContainerColor=0;
                                });

                              },),

                          ],),
                          SizedBox(height:45),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            InkWell(child: Container(child :Image.asset("assets/images/emo1.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="1";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                            SizedBox(width: 20,),
                            InkWell(child: Container(child :Image.asset("assets/images/emo2.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="2";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                            SizedBox(width: 20,),
                            InkWell(child: Container(child :Image.asset("assets/images/emo3.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="3";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                          ],),
                          SizedBox(height: 15,),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            InkWell(child: Container(child :Image.asset("assets/images/emo4.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="4";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                            SizedBox(width: 20,),
                            InkWell(child: Container(child :Image.asset("assets/images/emo5.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="5";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                            SizedBox(width: 20,),
                            InkWell(child: Container(child :Image.asset("assets/images/emo6.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="6";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                          ],),

                          SizedBox(height: 15,),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            InkWell(child: Container(child :Image.asset("assets/images/emo7.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="7";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;

                                });

                              },),
                            SizedBox(width: 20,),
                            InkWell(child: Container(child :Image.asset("assets/images/emo8.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="8";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                            SizedBox(width: 20,),
                            InkWell(child: Container(child :Image.asset("assets/images/emo9.png",width: 80,height: 80,))
                              ,onTap: () {
                                emoNumber="9";
                                sendEmoji(sendName, emoNumber);
                                setState(() {
                                  visibleVar3=false;
                                });

                              },),
                          ],),

                        ]

                        ),

                        ),),
                    ),),

                ]
            ),
          ),

    Visibility(
      visible : visibleVar4,
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
      child:

      SafeArea(child : Column(mainAxisAlignment: MainAxisAlignment.center,children:[ SizedBox(height: 30),

      Container(margin: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
      InkWell(
      child: Container(width: 80,height: 25,decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
      onTap: () {
        setState(() {
          visibleVar4=false;
        });
      print("Tapped on container");
      },

      ),
        Container(width: 90,),
        Center(child: Container(width:150,)),
      ]

      ),),
      ),
        SizedBox(height:45),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [

          InkWell(
            child: Container(alignment: Alignment.center
                ,width: 100,height: 25,decoration:BoxDecoration(color:Color.fromARGB(255, 0, 255, 255).withOpacity(emoContainerColor),border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("إيموجي",style: TextStyle(color: Color.fromARGB(255, emoTextColor, emoTextColor, emoTextColor),fontSize:15,fontWeight: FontWeight.w500),)),
            onTap: () {
              setState(() {
                visibleVar3=true;
                visibleVar4=false;
                emoTextColor = 0;
                gifTextColor = 255;
                emoContainerColor=1;
                gifContainerColor=0;
              });

            },),
          SizedBox(width:30),

          InkWell(
            child: Container(alignment: Alignment.center
                ,width: 100,height: 25,decoration:BoxDecoration(color:Color.fromARGB(255, 0, 255, 255).withOpacity(gifContainerColor),border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("ردة فعل",style: TextStyle(color: Color.fromARGB(255, gifTextColor, gifTextColor, gifTextColor),fontSize:15,fontWeight: FontWeight.w500),)),
            onTap: () {
              setState(() {
                visibleVar3=false;
                visibleVar4=true;
                emoTextColor = 255;
                gifTextColor = 0;
                gifContainerColor=1;
                emoContainerColor=0;
              });

            },),

        ],),
        SizedBox(height:45),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      InkWell(child: Container(child :Image.asset("assets/images/aa.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="1";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/bb.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="2";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/cc.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="3";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      ],),
      SizedBox(height: 15,),

      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      InkWell(child: Container(child :Image.asset("assets/images/dd.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="4";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/ee.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="5";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/ff.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="6";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      ],),

      SizedBox(height: 15,),

      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      InkWell(child: Container(child :Image.asset("assets/images/gg.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="7";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/hh.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="8";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/ii.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="9";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      ],),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      InkWell(child: Container(child :Image.asset("assets/images/jj.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="10";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/kk.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="11";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/rr.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="12";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      ],),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      InkWell(child: Container(child :Image.asset("assets/images/ll.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="13";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/mm.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="14";
      sendGif(sendName, gifNumber);

      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/nn.gif",width: 80,height: 80,))
      ,onTap: () {
        gifNumber="15";
          setState(() {
            visibleVar4=false;
          });


        },),
      ],),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      InkWell(child: Container(child :Image.asset("assets/images/oo.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="16";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/pp.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="17";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });

      },),
      SizedBox(width: 20,),
      InkWell(child: Container(child :Image.asset("assets/images/qq.gif",width: 80,height: 80,))
      ,onTap: () {

      gifNumber="18";
      sendGif(sendName, gifNumber);
      setState(() {
        visibleVar4=false;
      });


      },),
      ],),
      SizedBox(height:50),

      ]

      ),

      ),),
      ),),

      ]
      ),
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
                            Container(alignment:Alignment.center,child:Text("ردة فعل من "+conatctName,style: TextStyle(color: Colors.white,fontSize:30,fontWeight: FontWeight.w500),)),
                            SizedBox(height: 30,),
                            Container(alignment:Alignment.center,child:Image.asset("assets/images/"+gifShow+".gif",width: 150,height: 150,)),
                            SizedBox(height: 30,),
                            InkWell(
                              child: Container(alignment: Alignment.center
                                  ,width: 270,height: 45,decoration:BoxDecoration(color:Colors.tealAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("أرسل ردة فعل",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                              onTap: () {
                                setState(() {
                                  visibleVar5=false;

                                });

                              },),
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






        ],
      );
  }
}