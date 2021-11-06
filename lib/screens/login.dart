// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/screens/choice.dart';
import 'package:wechou/screens/code.dart';
import 'package:wechou/services/auth_services.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:wechou/widget/background7.dart';
import 'package:audioplayers/audioplayers.dart';

class Login extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  Login(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);

  @override
  _LoginState createState() => _LoginState();
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
class _LoginState extends State<Login> with TickerProviderStateMixin,WidgetsBindingObserver{
  @override

  final AuthService _auth = AuthService();
  String name = "";
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  String number ="";
  String error = "";

  void initState() {
    // TODO: implement initState
    super.initState();


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



  Widget build(BuildContext context) {
    return Directionality(
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

                 SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                    children:[ SizedBox(height: 30),
                      Container(margin: EdgeInsets.symmetric(horizontal: 20),

                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[Container(width:145,),
                            Center(child: Container(width:165,child:Text("مشاركة",style:TextStyle(fontSize: 23,color:Colors.white,fontFamily: 'Almarai')),)),
                            InkWell(
                            child: Container(width: 50,height: 25,decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer2, audioCache2)));
                            },

                          ),
                            ]

                          ),
                      ),
                      SizedBox(height:30),
                      Container(width:325,margin: EdgeInsets.all(15),alignment:Alignment.centerRight,child:Text("إسم المستخدم",style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w800),)),
                      Stack(
                        children: [Container(alignment: Alignment.center
    ,width: 330,height: 45,decoration:BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.1),border: Border.all(color: Colors.grey),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))),),
                          Container(alignment: Alignment.center,width: 330,
                            child: TextFormField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 204, 255),fontSize: 17
                              ),

                              decoration: InputDecoration(



                                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 1),

                                hintText: 'الإسم',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),

                                ),
                                hintStyle: TextStyle(color :Colors.white.withOpacity(0.4)),
                                errorStyle: TextStyle(
                                  fontSize: 16.0,),
                              ),


                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'أدخل الإسم رجاءا';
                                }
                                // Check if the entered email has the right format
                                if (value.trim().length<3) {
                                  return 'الإسم قصير للغاية';
                                }
                                // Return null if the entered email is valid
                                return null;
                              },
                              onChanged: (value) => name = value,
                              onSaved: (value) => name = value,



                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,



                            ),
                          ),
                        ]
                      ),
                      SizedBox(height:15),
                      Container(width:325,margin: EdgeInsets.all(15),alignment:Alignment.centerRight,child:Text("رقم الجوال",style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w800),)),
                      Stack(children: [
                      Container(alignment: Alignment.center
                        ,width: 330,height: 45,decoration:BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.1),border: Border.all(color: Colors.grey),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))),),
                        Container(alignment: Alignment.center,width: 330,
                          child: TextFormField(

                            decoration: InputDecoration(
                              suffixText: "-996      ",
                              suffixStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 204, 255),fontSize: 17
                          ),


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


                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 204, 255),fontSize: 17
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,



                          ),
                        ),
                      ],),
                      SizedBox(height:30),

                      InkWell(
                        child: Container(alignment: Alignment.center
                            ,width: 330,height: 50,decoration:BoxDecoration(color:Colors.tealAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("موافق",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                        onTap: () {
                          _formSubmit();
                        },),




                    ]
                ),
                ),

              ),),


          ),),]),);
  }
  Future<void> _formSubmit() async {
    final FormState formStateVal = _formKeyValue.currentState;
    if(formStateVal.validate()){
      formStateVal.save();
      /*dynamic result = await _auth.registerWithEmailAndPassword(formsignup.password,formsignup.name);
      res.sendOTP(formsignup.email);
      if(result == null) {
        setState(() {
          error = 'Email already registered';
        });

      }

      if(result == null) {
        setState(() {
          error = 'Could not sign in with those credentials';

        });}*/

      await HelperFunctions.savename(name);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => code(number,audioPlayer,audioCache,audioPlayer2, audioCache2)));




      }


    }
  }
