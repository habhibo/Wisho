import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wechou/screens/menu.dart';
import 'package:wechou/widget/background1.dart';
import 'package:wechou/widget/background5.dart';

class QuittedGame extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    String heartLeft ="0";
    String points="0";
    String levels = "10";

    return
      Stack(
        children: [
          BackgroundImage5(),
          Center(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body:Center(
                  child: SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:[Container(child:Text("تبي تكمل؟",style: TextStyle(fontSize: 33,color: Colors.white,fontWeight: FontWeight.w700),)),
                        SizedBox(height: 50,),
                        Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          InkWell(
                            child: CircleAvatar(
                              radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                              backgroundColor:Colors.white,
                              child:Center(child:Stack(alignment: Alignment.center,
                                children: [Container(padding:EdgeInsets.all(1),child:Image.asset(
    'assets/images/heart.png',
    width: 70,
    height: 70,
    ),
    width: 60,
    height: 60,
    ),
                                  Container(alignment: Alignment.center,padding: EdgeInsets.all(17),child:Text(heartLeft,style: TextStyle(fontSize: 25,color: Colors.white),),
                                    width: 60,
                                    height: 60,
                                  ),]
                              ),
                              ),
                            ),onTap: () {
                            print("Tapped on container");
                          },
                          ),
                          SizedBox(width:20),
                          InkWell(
                            child: CircleAvatar(
                              radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                              backgroundColor:Colors.white ,
                              child:Center(child:Container(child:Image.asset(
    'assets/images/Ads.png',
    width: 70,
    height: 70,
    ),
    width: 90,
    height: 90,
    )
                              ),
                            ),onTap: () {
                            print("Tapped on container");
                          },
                          )
                        ],)),

                      SizedBox(height:20),
                      Container(color: Colors.grey.withOpacity(0.6),height: 1,width: 300,),
                        SizedBox(height:20),
                      Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(width:150,height:30,child:Text(points,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),),
                        Container(width:100,height:40,child:Text("عدد النقاط",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),),





                      ],)),
                        SizedBox(height:20),
                        Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(width:150,height:30,child:Text(levels,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),),
                          Container(width:100,height:40,child:Text("عدد الجولات",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),),],),),

    SizedBox(height:20),
                        InkWell(child: Container(child:Text("الصفحة الرئيسية",style: TextStyle(fontSize: 15,color: Colors.tealAccent,fontWeight: FontWeight.w700),))


                        ,onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => menu(audioPlayer,audioCache,audioPlayer, audioCache)));
                        },),



                        ]

                  ),
                  ),
                )
            ),

          ),

        ],
      );
  }
}

