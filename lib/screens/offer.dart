import 'package:flutter/material.dart';
import 'package:wechou/widget/background3.dart';

class offer extends StatefulWidget {


  @override
  _offerState createState() => _offerState();

}

class _offerState extends State<offer> {
  String name = "";
  String room = "";
  String nbtrophy = "150";
  String imagenb = "1";
  String char =  "char1";
  List<String> names = ["شعارات جهات",'عشوائي',"شعارات مطاعم",'شعارات منتجات','شعارات سيارات','شعارات أندية','شعارات تقنية',"شعارات تطبيقات",'ألوان شعارات','شعارات ماركات','ترفيه عربي','ترفيه أجنبي','سيارات','مشاهير','كلمات',"ايموجيز",'معلومات عامة','جغرافيا','رياضيات'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage3(),

          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(

                child:  SafeArea(child :Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(height: 30),
                        Container(child:Text("في " +name+room+" يتحداك",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w700),)),
                        SizedBox(height: 120,),
                        Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          CircleAvatar(
                            radius: 40,foregroundColor: Colors.white.withOpacity(0.1),
                            backgroundColor:Colors.white ,backgroundImage: AssetImage('assets/images/'+imagenb+'.png'),




                          ),
                          SizedBox(width:40),
    Stack(alignment: Alignment.center,
      children: [CircleAvatar(
      radius: 40,foregroundColor: Colors.white.withOpacity(0.1),
      backgroundColor:Colors.white ,backgroundImage: AssetImage('assets/images/'+char+'.png',),),
        Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[ SizedBox(height:80),Center(
              child: Container(padding: EdgeInsets.all(1),width:50,height:20,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),topRight:Radius.circular(15) ),color: Colors.indigo),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Container(child:Text(nbtrophy,style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.w800),)),
                Container(child: Image.asset(
                  'assets/images/Trophy.png',
                  width: 20,
                  height: 20,
                ),
                  width: 20,
                  height: 20,

                ),
              ],)),
            ),]),
    ]






    ),SizedBox(height: 50),],),),

                        SizedBox(height: 50,),
                        Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          InkWell(
                            child: CircleAvatar(
                              radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                              backgroundColor:Colors.white.withOpacity(0.2) ,
                              child:Center(child:Container(child:Text("أرفض  ",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),)
                              ),
                            ),onTap: () {
                            print("Tapped on container");
                          },
                          ),
                          SizedBox(width:40),
                          InkWell(
                            child: CircleAvatar(
                              radius: 60,foregroundColor: Colors.white.withOpacity(0.1),
                              backgroundColor:Colors.white ,
                              child:Center(child:Container(child:Text("إلعب  ",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w600),),)
                              ),
                            ),onTap: () {
                            print("Tapped on container");
                          },
                          )
                        ],)),
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