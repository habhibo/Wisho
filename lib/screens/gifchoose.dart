
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:wechou/widget/background7.dart';
import 'package:wechou/widget/background8.dart';

class gifchoose extends StatefulWidget {
  const gifchoose({Key? key}) : super(key: key);

  @override
  _gifchooseState createState() => _gifchooseState();
}

class _gifchooseState extends State<gifchoose> {
  @override
  String name = "fahd";






  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
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
                          Container(alignment:Alignment.center,child:Text("ردة فعل من "+name,style: TextStyle(color: Colors.white,fontSize:30,fontWeight: FontWeight.w500),)),
                          SizedBox(height: 30,),
                        Container(alignment:Alignment.center,child:Image.asset("assets/images/aa.gif",width: 150,height: 150,)),
                        SizedBox(height: 30,),
                        InkWell(
                          child: Container(alignment: Alignment.center
                              ,width: 270,height: 45,decoration:BoxDecoration(color:Colors.tealAccent,borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("حفظ",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                          onTap: () {

                          },),
                        SizedBox(height: 20,),
                        SizedBox(width:50),

                        InkWell(
                          child: Container(alignment: Alignment.center
                              ,width: 270,height: 45,decoration:BoxDecoration(color:Colors.transparent,border: Border.all(color: Colors.tealAccent),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))), child:Text("إلغاء",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),)),
                          onTap: () {

                          },),



                      ]
                      ),
                    ),

                    ),),
                ),),),

            ]
        ),
      ),


    );
  }





}