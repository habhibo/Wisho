/*import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wechou/widget/background3.dart';
import 'package:wechou/widget/background4.dart';
import 'package:wechou/widget/background7.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  String name = "";
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  String number ="";
  String error = "";
  String char = "char1";

  String profilename = "fahd";




  Widget build(BuildContext context) {
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
                  child: Form(
                    key : _formKeyValue,
                    child :

                    SafeArea(child :Column(
                        children:[ SizedBox(height: 30),

                          Container(margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[Container(width: 90,child :Image.asset("assets/images/tic.png",width: 20,height: 20,)),
                                Center(child: Container(width:150,child:Text("الصورة الشخصية",style:TextStyle(fontSize: 23,color:Colors.white)),)),
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
                          SizedBox(height:50),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(child :Image.asset("assets/images/char1.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char2.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char3.png",width: 80,height: 80,)),
                          ],),
                          SizedBox(height: 15,),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(child :Image.asset("assets/images/char4.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char5.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char6.png",width: 80,height: 80,)),
                          ],),

                          SizedBox(height: 15,),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(child :Image.asset("assets/images/char7.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char8.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char9.png",width: 80,height: 80,)),
                          ],),

                          SizedBox(height: 15,),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Container(child :Image.asset("assets/images/char10.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char11.png",width: 80,height: 80,)),
                            SizedBox(width: 20,),
                            Container(child :Image.asset("assets/images/char12.png",width: 80,height: 80,)),
                          ],),




                        ]
                    ),
                    ),

                  ),),


              ),),]),),);
  }



}*/
