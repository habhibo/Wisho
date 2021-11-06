// @dart=2.9

import 'dart:async';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/LocalSearch.dart';
import 'package:wechou/screens/login.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:audioplayers/audioplayers.dart';

class code extends StatefulWidget {
  final String phone;
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  code(this.phone,this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);


  @override
  _codeState createState() => _codeState();
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


class _codeState extends State<code> with TickerProviderStateMixin,WidgetsBindingObserver{
  @override

  bool exist = true ;
  String trophy;
  String heart;
  String char ="";
  String myUsername = "";
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _verificationCode ="";
  var gamerequests = new Map();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool Music;


  void dispose() {
    newTextEditingController.dispose();
    focusNode.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    gamerequests['id']='-1';
    gamerequests['room']="nah";
    gamerequests['roomname']="nah";
    fn();
    _verifyPhone();



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
  Future<void> fn() async {
    Music = await HelperFunctions.getMusic();
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





  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage4(),
        Center(
          child: Scaffold(
            key: _scaffoldkey,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(

              child:  SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                  children:[ SizedBox(height: 30),
                    Row(
                        children: [InkWell(
                          child: Container(width: 110,height: 25,decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/images/backb.png",),),),),
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Login(audioPlayer,audioCache,audioPlayer2, audioCache2)));
                          },

                        ),

                          SizedBox(width: 220,)
                        ]
                    ),


                    Container(
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: 70.0,
                            ),
                            Container(child:Text("رمز التحقق",textAlign: TextAlign.center,style:TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w600))),


                            Container(width: 300,
                              child: PinCodeFields(
                                length: 6,
                                textStyle: TextStyle(color: Color.fromARGB(236,236 ,197, 198),fontSize: 32),
                                keyboardType: TextInputType.number,
                                borderColor: Colors.white54,
                                controller: newTextEditingController,
                                autoHideKeyboard: true,
                                focusNode: focusNode,
                                onComplete: (result) async {
                                  // Your logic with code
                                  myUsername=await HelperFunctions.getname();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithCredential(PhoneAuthProvider.credential(
                                        verificationId: _verificationCode, smsCode: result))
                                        .then((value) async {
                                      if (value.user != null) {

                                        await HelperFunctions.saveUserExist(true);
                                        char = await HelperFunctions.getChar();
                                        if(char==null){char="1";};
                                        trophy=await HelperFunctions.getTrophy();
                                        await FirebaseFirestore.instance.collection("users").doc(myUsername).update({
                                          "game requests" : gamerequests,

                                        }).catchError((e) {
                                          print(e.toString());
                                        });

                                        print("done");
                                        FocusScope.of(context).unfocus();
                                        _scaffoldkey.currentState
                                            .showSnackBar(SnackBar(content: Text('Succesfully Logged In')));
                                        try {
                                          await FirebaseFirestore.instance.doc("users""/"+myUsername).get().then((doc) {
                                            exist = doc.exists;
                                          });
                                        } catch (e) {
                                          // If any error
                                          exist=false;
                                        }
                                        print(exist);
                                        if(exist==false){
                                          await FirebaseFirestore.instance.collection("users").doc(myUsername).set({
                                            "username" : myUsername,
                                            "char" : char,
                                            "phone" : widget.phone,
                                            "identifier" : "player",
                                            "trophy": trophy,
                                            "game requests" : gamerequests,
                                          }).catchError((e) {
                                            print(e.toString());
                                          });
                                        }

                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) => FilterLocalListPage(audioPlayer,audioCache,audioPlayer2, audioCache2)));



                                      }
                                      }








                                    );
                                  } catch (e) {
                                    FocusScope.of(context).unfocus();
                                    _scaffoldkey.currentState
                                        .showSnackBar(SnackBar(content: Text('invalid OTP')));
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            InkWell(child: Container(child:Text("إعادة إرسال رمز التحقق ؟",textAlign: TextAlign.center,style:TextStyle(color: Colors.tealAccent,fontSize: 21)))
                            ,onTap: () {
                              _verifyPhone();
                            },),

                          ],
                        ),
                      ),



                  ]
              ),

              ),
            ),
          ),
        ),],);







  }
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+216${widget.phone}',
        verificationCompleted: (PhoneAuthCredential phoneNumber) async {
          await FirebaseAuth.instance
              .signInWithCredential(phoneNumber)
              .then((value) async {
            if (value.user != null) {
              print("done");
              //////to ADD
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }


}
