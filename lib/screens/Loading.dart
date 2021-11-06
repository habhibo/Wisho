// @dart=2.9

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:wechou/screens/menu.dart';

import 'package:wechou/widget/background0.dart';
import 'dart:async';
import 'package:wechou/models/helpers.dart';





class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingState();
  }}

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

class LoadingState extends State<Loading> with TickerProviderStateMixin{
  @override

  bool Sfx ;
  bool Music ;


  void initState() {
    // TODO: implement initState
    super.initState();


    startTime();
    initPlayer();




  }







  void initPlayer() {
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    audioPlayer2 = new AudioPlayer();
    audioCache2 = new AudioCache(fixedPlayer: audioPlayer2);
    /*setState(() {
      _duration = audioPlayer.getDuration() as Duration;
    });

    setState(() {
      _position = audioPlayer.getCurrentPosition() as Duration;
    });*/
  }
  Future<void> fn() async {


    print("beginfn");

    Sfx = await HelperFunctions.getSfx();
    Music = await HelperFunctions.getMusic();
    print(Sfx);
    print(Music);

    if(Music==true){
      print("aaaaaaaaaaaa");
      audioCache.play("intro.mp3");}
    else{audioCache.play("intro.mp3");

    var duration = new Duration(seconds: 2);
    return new Timer(duration,pause);

    print("else khedmet");

    };

    //hearts=await HelperFunctions.getHeart();
    //trophy1=await HelperFunctions.getTrophy();
    //setState(() { hearts=hearts;
    //trophy1=trophy1;});

    print("endfn");
  }

  Future<void> pause() async {

    //int result = await audioPlayer.pause();
    await audioCache.fixedPlayer.pause();
    await audioCache.fixedPlayer.pause();
    await audioCache.fixedPlayer.pause();


    print("pauseed nmet");
  }






  startTime() async {


    var duration = new Duration(seconds: 4);
    return new Timer(duration, route);
  }
  route() async {
    await fn();


    Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => menu(audioPlayer,audioCache,audioPlayer2,audioCache2,)));
    }









  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage0(),

      ],
    );
  }
}