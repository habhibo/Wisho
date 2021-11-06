
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:wechou/widget/background7.dart';
import 'package:wechou/widget/background8.dart';

class emojis extends StatefulWidget {
  const emojis({Key? key}) : super(key: key);

  @override
  _emojisState createState() => _emojisState();
}

class _emojisState extends State<emojis> {
  @override
  String name = "";
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  String number ="";
  String error = "";
  String char = "char1";

  String profilename = "fahd";




  Widget build(BuildContext context) {
    return Directionality(
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
                  child:

                    SafeArea(child : Column(mainAxisAlignment: MainAxisAlignment.center,children:[ SizedBox(height: 30),

                    Container(margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[Container(width: 90,),
                          Center(child: Container(width:150,)),
                          InkWell(
                            child: Container(width: 80,height: 25,decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                            onTap: () {
                              print("Tapped on container");
                            },

                          ),
                        ]

                        ),),
                    ),
                    SizedBox(height:90),
                      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        InkWell(child: Container(child :Image.asset("assets/images/emo1.png",width: 80,height: 80,))
                        ,onTap: () {

                        },),
                        SizedBox(width: 20,),
                        InkWell(child: Container(child :Image.asset("assets/images/emo2.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                        SizedBox(width: 20,),
                        InkWell(child: Container(child :Image.asset("assets/images/emo3.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                      ],),
                      SizedBox(height: 15,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        InkWell(child: Container(child :Image.asset("assets/images/emo4.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                        SizedBox(width: 20,),
                        InkWell(child: Container(child :Image.asset("assets/images/emo5.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                        SizedBox(width: 20,),
                        InkWell(child: Container(child :Image.asset("assets/images/emo6.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                      ],),

                      SizedBox(height: 15,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        InkWell(child: Container(child :Image.asset("assets/images/emo7.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                        SizedBox(width: 20,),
                        InkWell(child: Container(child :Image.asset("assets/images/emo8.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                        SizedBox(width: 20,),
                        InkWell(child: Container(child :Image.asset("assets/images/emo9.png",width: 80,height: 80,))
                          ,onTap: () {

                          },),
                      ],),

                      ]

                    ),

                  ),),
    ),),

      ]
      ),


              );
  }





}
