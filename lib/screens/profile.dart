// @dart=2.9


import 'dart:ui';

import'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/profilepicture.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:wechou/widget/background7.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin  ,WidgetsBindingObserver {
  @override
  String name = "";
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  String number ="";
  String error = "";
  String char = "char1";

  String profilename = "";

  bool visibility = false;

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
  bool Music;

  var picTab = [];

  String profilePic ="1";

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);


    if (state == AppLifecycleState.paused ) {audioPlayer.pause();}



    if (state == AppLifecycleState.resumed ) {if(Music==true){audioPlayer.resume();}}




  }

  void initState() {
   fn();
  }

  Future<void> fn() async {

    picTab.add(active1);
    picTab.add(active2);
    picTab.add(active3);
    picTab.add(active4);
    picTab.add(active5);
    picTab.add(active6);
    picTab.add(active7);
    picTab.add(active8);
    picTab.add(active9);
    picTab.add(active10);
    picTab.add(active11);
    picTab.add(active12);
    Music =await HelperFunctions.getMusic();


    profilename = await HelperFunctions.getname();


    print(profilename);
    if(profilename!=null){
      setState(() {
        profilename=profilename;
      });
    await FirebaseFirestore.instance
        .collection("users").doc("profilename")
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          if (value != null) {

            char=value.data()["char"];
            profilePic=char;


            }}
        );}
    });}
    print("aaaaaaaaaa");
    print(profilePic);
    setState(() {
      profilePic=profilePic;
    });
    print(picTab);


    print(picTab);

    for(int i =0;i<picTab.length;i++){

      if(i+1==int.parse((char.toString()))){
        setState(() {
          picTab[i]=0.3;
        });

      }
    }
    print(picTab);





  }









  Widget build(BuildContext context) {
    return Stack(
      children: [Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
            children: [
              BackgroundImage7(),
              Center(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Form(
                      key : _formKeyValue,
                      child :

                      SafeArea(child :Column(
                          children:[ SizedBox(height: 30),

                            Container(margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[Container(width: 80,),
                                  Center(child: Container(width:180,child:Text("الملف الشخصي",style:TextStyle(fontSize: 23,color:Colors.white)),)),
                                  InkWell(
                                    child: Container(width: 40,height: 25,decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                                    onTap: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => menu(audioPlayer,audioCache,audioPlayer, audioCache)));
                                    },

                                  ),
                                ]

                                ),),
                            ),
                            SizedBox(height:30),
                            Stack(alignment: Alignment.center,children: [
                              Center(child:Container(child:Image.asset(
                                'assets/images/char'+profilePic+'.png',
                                width: 100,
                                height: 100,
                              ),
                                width: 100,
                                height: 100,
                              ),),
                              SizedBox(height: 100,),
                              Row(mainAxisAlignment: MainAxisAlignment.center,children: [


                                Column(children: [
                                  SizedBox(height:70),


                                  Row(children: [

                                    InkWell(
                                      child: Container(alignment:Alignment.center,width:18,height:18,decoration: BoxDecoration(color: Colors.purple ,borderRadius: BorderRadius.circular(100)),child: Icon(
                                        Icons.create_outlined,
                                        color: Colors.white,
                                        size: 17.0,
                                      ),),onTap: () {

                                     /* Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => ProfilePicture()));*/
                                      setState(() {
                                        visibility=true;
                                      });




                                      },
                                    ),
                                    SizedBox(width: 75),

                                  ],),
                      ],),
                                  ],)








                            ]),
                            Container(width:285,margin: EdgeInsets.all(15),alignment:Alignment.centerRight,child:Text("إسم المستخدم",style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w800),)),
                            Container(alignment: Alignment.center
                              ,width: 290,height: 45,decoration:BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.3),border: Border.all(color: Colors.grey),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))),
                              child: TextFormField(

                                decoration: InputDecoration(


                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 1),

                                  hintText: profilename,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),

                                  ),
                                  hintStyle: TextStyle(color :Colors.white.withOpacity(1)),
                                  errorStyle: TextStyle(
                                    fontSize: 16.0,),
                                ),

                                validator: (value) {

                                  // Check if the entered email has the right format
                                  if (value.trim().length<3) {
                                    return 'الإسم قصير للغاية';
                                  }
                                  // Return null if the entered email is valid
                                  return null;
                                },
                                onChanged: (value) => name = value,
                                onSaved: (value) => name = value,


                                style: TextStyle(color : Colors.white,fontSize: 22),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,



                              ),
                            ),
                            Container(width:285,margin: EdgeInsets.all(15),alignment:Alignment.centerRight,child:Text("رقم الجوال",style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w800),)),
                            Container(alignment: Alignment.center
                              ,width: 290,height: 45,decoration:BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.3),border: Border.all(color: Colors.grey),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))),
                              child: TextFormField(

                                decoration: InputDecoration(


                                  contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 1),

                                  hintText: '*******',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),

                                  ),
                                  hintStyle: TextStyle(color :Colors.white.withOpacity(0.4)),
                                  errorStyle: TextStyle(
                                    fontSize: 16.0,),
                                ),

                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'أدخل الرقم رجاءا';
                                  }
                                  // Check if the entered email has the right format
                                  if (value.trim().length!=8) {
                                    return 'الرقم خاطئ';
                                  }
                                  // Return null if the entered email is valid
                                  return null;
                                },
                                onChanged: (value) => number = value,
                                onSaved: (value) => number = value,


                                style: TextStyle(color : Colors.white,fontSize: 22),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,



                              ),
                            ),
                            SizedBox(height:30),
                            Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                              InkWell(
                                child: Container(alignment: Alignment.center
                                    ,width: 100,height: 45,decoration:BoxDecoration(color:Colors.tealAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("حفظ",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                                onTap: () async {
                                  await HelperFunctions.savename(name);
                                  await HelperFunctions.savePhone(number);

                                  if(name!=""){

                                    await FirebaseFirestore.instance.collection("users").doc(profilename).update({
                                      'username':name,



                                    }).catchError((e) {
                                      print(e.toString());
                                    });}

                                  if(number!=""){

                                    await FirebaseFirestore.instance.collection("users").doc(profilename).update({

                                      'phone' : number,


                                    }).catchError((e) {
                                      print(e.toString());
                                    });}



                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => menu(audioPlayer,audioCache,audioPlayer, audioCache)));

                                  /*RewardedAd.load(
                                      adUnitId: '<test id or account id>',
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
                                  );*/

                                },),
                              SizedBox(width:50),

                              InkWell(
                                child: Container(alignment: Alignment.center
                                    ,width: 100,height: 45,decoration:BoxDecoration(color:Colors.transparent,border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("إلغاء",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),)),
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => menu(audioPlayer,audioCache,audioPlayer, audioCache)));

                                },),

                            ],),






                          ]
                      ),
                      ),

                    ),),


                ),),]),),


    Visibility(
    visible: visibility,
    child: Directionality(
    textDirection: TextDirection.rtl,
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

    child :

    SafeArea(child :Column(
    children:[ SizedBox(height: 30),

    Container(margin: EdgeInsets.symmetric(horizontal: 20),
    child: Center(
    child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[InkWell(child: Container(width: 90,child :Image.asset("assets/images/tic.png",width: 20,height: 20,))
    ,onTap: () async {
      if(profilename!=null){

      await FirebaseFirestore.instance.collection("users").doc(profilename).update({
                            'char':profilePic,


                          }).catchError((e) {
                            print(e.toString());
                          });}

        setState(() {
          visibility=false;
        });

    },),
    Center(child: Container(width:160,child:Text("الصورة الشخصية",style:TextStyle(fontSize: 23,color:Colors.white)),)),
    InkWell(
    child: Container(width: 70,height: 25,decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
    onTap: () {
      setState(() {
        visibility=false;
      });
    },


    ),
    ]

    ),),
    ),
    SizedBox(height:50),
    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
    Stack(
      children: [ InkWell(child: Container(child :Image.asset("assets/images/char1.png",width: 80,height: 80,)),onTap: () {

        setState(() {
          picTab[0]=0.3;
          picTab[1]=0;
          picTab[2]=0;
          picTab[3]=0;
          picTab[4]=0;
          picTab[5]=0;
          picTab[6]=0;
          picTab[7]=0;
          picTab[8]=0;
          picTab[9]=0;
          picTab[10]=0;
          picTab[11]=0;
        });
        setState(() {
          profilePic="1";
        });





      },),

      Container(child:Image.asset(
        'assets/images/ticgreen.png',
        color :Color.fromARGB(((picTab[0]*255)/0.3).toInt(), 255, 255, 255),
        colorBlendMode: BlendMode.modulate,
        width: 25,
        height: 25,
      ),
        width: 25,
        height:25,
      ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char2.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0.3;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="2";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[1]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char3.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0.3;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="3";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[2]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    ],),
    SizedBox(height: 15,),

    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char4.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0.3;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="4";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[3]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char5.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0.3;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="5";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[4]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char6.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0.3;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="6";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[5]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    ],),

    SizedBox(height: 15,),

    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char7.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0.3;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="7";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[6]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char8.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0.3;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="8";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[7]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char9.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0.3;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="9";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[8]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    ],),

    SizedBox(height: 15,),

    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char10.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0.3;
              picTab[10]=0;
              picTab[11]=0;
            });

            setState(() {
              profilePic="10";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[9]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char11.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0.3;
              picTab[11]=0;
            });

            setState(() {
              profilePic="11";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[10]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    SizedBox(width: 20,),
      Stack(
          children: [ InkWell(child: Container(child :Image.asset("assets/images/char12.png",width: 80,height: 80,)),onTap: () {

            setState(() {
              picTab[0]=0;
              picTab[1]=0;
              picTab[2]=0;
              picTab[3]=0;
              picTab[4]=0;
              picTab[5]=0;
              picTab[6]=0;
              picTab[7]=0;
              picTab[8]=0;
              picTab[9]=0;
              picTab[10]=0;
              picTab[11]=0.3;
            });

            setState(() {
              profilePic="12";
            });



          },),

            Container(child:Image.asset(
              'assets/images/ticgreen.png',
              color :Color.fromARGB(((picTab[11]*255)/0.3).toInt(), 255, 255, 255),
              colorBlendMode: BlendMode.modulate,
              width: 25,
              height: 25,
            ),
              width: 25,
              height:25,
            ),]),
    ],),




    ]
    ),
    ),

    ),),


    ),]),),),


      ]
    );
  }



}
