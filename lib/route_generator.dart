// @dart=2.9

import 'package:flutter/material.dart';
import 'package:wechou/models/ggg.dart';
import 'package:wechou/screens/Loading.dart';
import 'package:wechou/screens/LocalSearch.dart';
import 'package:wechou/screens/atest.dart';
import 'package:wechou/screens/choice.dart';
import 'package:wechou/screens/code.dart';
import 'package:wechou/screens/emojis.dart';
import 'package:wechou/screens/ff.dart';
import 'package:wechou/screens/gameended.dart';
import 'package:wechou/screens/gif.dart';
import 'package:wechou/screens/gifchoose.dart';
import 'package:wechou/screens/ingame.dart';
import 'package:wechou/screens/inmultgame.dart';
import 'package:wechou/screens/login.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/screens/music.dart';
import 'package:wechou/screens/offer.dart';
import 'package:wechou/screens/pay.dart';
import 'package:wechou/screens/profile.dart';
import 'package:wechou/screens/profilepicture.dart';
import 'package:wechou/screens/quitgame.dart';
import 'package:wechou/screens/quittedgame.dart';
import 'package:wechou/widget/search.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/screens/trophy.dart';
import 'package:wechou/screens/win.dart';
import './main.dart';

import 'package:audioplayers/audioplayers.dart';

class RouteGenerator {
  static  Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    var name = ["aa","bb","cc","dd"];
    var char = ["1","2","3","4"];
    var point = ["10","20","30","40"];

    AudioPlayer audioPlayer;
    AudioCache audioCache;



    switch(settings.name) {

      case'/':
        return MaterialPageRoute(builder: (_) =>Loading());



      /*case 'Signup' :

        if(args is String) {

          return MaterialPageRoute(
            builder: (_) => Signup(
              data : args,
            ),
          );

        }
        return _errorRoute();*/


      default :
        return _errorRoute();
    }

  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('error'),
        ),
      );
    });

  }
}