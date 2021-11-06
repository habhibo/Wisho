import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wechou/widget/background1.dart';
import 'package:wechou/widget/background5.dart';

class QuitGame extends StatelessWidget {





  @override
  Widget build(BuildContext context) {

    return
      Stack(
        children: [
          BackgroundImage5(),
          Center(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body:Center(
                child: SafeArea(child :Column(mainAxisAlignment: MainAxisAlignment.center,
                        children:[Container(child:Text("متأكد تبي تطلع؟",style: TextStyle(fontSize: 33,color: Colors.white,fontWeight: FontWeight.w700),)),
                          SizedBox(height: 20,),
                          Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            InkWell(
                              child: CircleAvatar(
                                radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                                backgroundColor:Colors.white.withOpacity(0.2) ,
                                child:Center(child:Container(child:Text("كمل",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),)
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
                              child:Center(child:Container(child:Text("اطلع",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w600),),)
                              ),
                            ),onTap: () {
                            print("Tapped on container");
                          },
                          )
                        ],)),]
                    ),
                    ),
              )
              ),

            ),

        ],
      );
  }
}
