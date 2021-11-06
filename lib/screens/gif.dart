
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:wechou/widget/background7.dart';
import 'package:wechou/widget/background8.dart';

class gif extends StatefulWidget {
  const gif({Key? key}) : super(key: key);

  @override
  _gifState createState() => _gifState();
}

class _gifState extends State<gif> {
  @override


  String gifNumber = "";







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
                      InkWell(child: Container(child :Image.asset("assets/images/aa.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="1";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/bb.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="2";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/cc.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="3";

                        },),
                    ],),
                    SizedBox(height: 15,),

                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      InkWell(child: Container(child :Image.asset("assets/images/dd.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="4";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/ee.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="5";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/ff.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="6";

                        },),
                    ],),

                    SizedBox(height: 15,),

                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      InkWell(child: Container(child :Image.asset("assets/images/gg.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="7";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/hh.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="8";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/ii.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="9";

                        },),
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      InkWell(child: Container(child :Image.asset("assets/images/jj.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="10";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/kk.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="11";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/rr.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="12";

                        },),
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      InkWell(child: Container(child :Image.asset("assets/images/ll.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="13";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/mm.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="14";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/nn.gif",width: 80,height: 80,))
                        ,onTap: () {

                        },),
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      InkWell(child: Container(child :Image.asset("assets/images/oo.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="15";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/pp.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="16";

                        },),
                      SizedBox(width: 20,),
                      InkWell(child: Container(child :Image.asset("assets/images/qq.gif",width: 80,height: 80,))
                        ,onTap: () {

                          gifNumber="17";

                        },),
                    ],),
                    SizedBox(height:50),

                  ]

                  ),

                  ),),
              ),),

          ]
      ),


    );
  }





}