// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wechou/models/helpers.dart';
import 'package:wechou/models/user.dart';
import 'package:wechou/models/users.dart';
import 'package:wechou/screens/choice.dart';
import 'package:wechou/screens/startgame.dart';
import 'package:wechou/widget/background7.dart';
import 'package:wechou/widget/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';

class FilterLocalListPage extends StatefulWidget {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  AudioPlayer audioPlayer2;
  AudioCache audioCache2;
  FilterLocalListPage(this.audioPlayer,this.audioCache,this.audioPlayer2,this.audioCache2);
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
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

class FilterLocalListPageState extends State<FilterLocalListPage> with TickerProviderStateMixin  ,WidgetsBindingObserver{
  List<User> books;
  List<String> players = [];
  String query = '';
  var gamerequests = new Map();
  String myUsername = "";
  String room = "";
  String aa = "";
  bool clickbar = true;
  bool click = false;
  bool condition =false;
  int top = 130;
  int counter = 0;

  bool Sfx ;

  var newgamerequests = new Map();

  String roomname = "";
  bool visibleVar = false;
  List<String> names = ["شعارات جهات",'عشوائي',"شعارات مطاعم",'شعارات منتجات','شعارات سيارات','شعارات أندية','شعارات تقنية',"شعارات تطبيقات",'ألوان شعارات','شعارات ماركات','ترفيه عربي','ترفيه أجنبي','سيارات','مشاهير','كلمات',"ايموجيز",'معلومات عامة','جغرافيا','رياضيات'];
  String opTrophy = "";
  String opChar = "";

  var list = [];
  var mobilenum =[];
  bool  contacttest =  false;
  Iterable<Contact> _contacts;

  @override
  void initState() {
    fn();
    initPlayer();
    WidgetsBinding.instance.addObserver(this);



    super.initState();
    ln();

  }

  Future<void> ln() async {
    await allUsersfn();
    setState(() {
      books = allUsers;
    });
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
    list =_contacts.toList();

    for(int i =0;i<list.length;i++){
      if(_contacts.elementAt(i).phones.isNotEmpty){
        mobilenum.add(_contacts.elementAt(i).phones.first.value.toString());}}

    for(int i=0;i<allUsers.length;i++){
      for(int j=0;j<mobilenum.length;j++){
        if(allUsers[i].number==mobilenum[j]){
          contacttest=true;
          print('cest true');

        }


      }
      if(contacttest==false){
        allUsers.removeAt(i);
        setState(() {
          books = allUsers;
        });
        i--;


      }
      contacttest=false;

    }




    setState(() {
      books = allUsers;
    });


    print(books);
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



  Future<void> fn() async {
    myUsername=await HelperFunctions.getname();
    room =  (await HelperFunctions.getRoom());
    room ="1";
    gamerequests['id']='yes';
    gamerequests['room']=room;
    gamerequests['roomname']=myUsername;




    print("done");

  }
  double x =0.5;

  @override
  Widget build(BuildContext context) => Directionality(textDirection:TextDirection.rtl ,child: Stack(
      children: [
      BackgroundImage7(),
    Center(
      child:

                SafeArea(
                  child: Scaffold(
                    bottomNavigationBar: condition? InkWell(
                      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),color:Colors.tealAccent),
                          alignment: Alignment.center,
                          height: 70,child:Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.arrow_back_outlined,size: 25,),
                              Text(' إبدأ اللعب',style: TextStyle(fontSize: 25),),


                            ],
                          )

                      ),onTap: () async {
                      allUsersfn2();
                        print(players.length);
                        await FirebaseFirestore.instance.collection(myUsername).doc("entry").set({

                          "identifier" : "nah",

                        }).catchError((e) {
                          print(e.toString());
                        });

                        for(int i=0;i<players.length;i++){
                          await FirebaseFirestore.instance.collection("users").doc(players[i]).update({
                            "game requests" : gamerequests,
                          }).catchError((e) {
                            print(e.toString());
                          });

                          await FirebaseFirestore.instance.collection(myUsername).doc(players[i]).set({
                            "username" : players[i],
                            "emoji" : "-1",
                            "gif" : "-1",
                            "identifier" : "player",
                            "statut" : "1",
                            "points"  : "0",
                          }).catchError((e) {
                            print(e.toString());
                          });
                          await FirebaseFirestore.instance.collection(myUsername).doc("entry").update({
                            players[i]:"-1",


                          }).catchError((e) {
                            print(e.toString());
                          });


                        }

                        await FirebaseFirestore.instance.collection(myUsername).doc(myUsername).set({
                          "username" : myUsername,
                          "emoji" : "-1",
                          "gif" : "-1",
                          "identifier" : "host",
                          "statut" : "1",
                          "points"  : "0",
                        }).catchError((e) {
                          print(e.toString());
                        });

                        allUsersfn2();

                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => StartGame(audioPlayer,audioCache,audioPlayer2,audioCache2)));




                    }


                    ): null,

                      backgroundColor: Colors.transparent,
                      body:Stack(children: [



      Column(
        children: <Widget>[
      SizedBox(height: 30),

                    Container(margin: EdgeInsets.symmetric(horizontal: 20),width: 350,
                      child: Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[Container(width: 60,),
                          Center(child: Container(alignment: Alignment.centerRight,width:170,child:Text("حدد جهة الإتصال",textAlign: TextAlign.right,style:TextStyle(fontSize: 23,color:Colors.white,)),)),
                          InkWell(
                            child: Container(alignment: Alignment.centerRight,width: 80,height: 25,decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/backb.png",),alignment: Alignment. bottomLeft),),),
                            onTap: () {
                              allUsersfn2();
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => choice(audioPlayer,audioCache,audioPlayer,audioCache)));
                            },

                          ),
                        ]

                        ),),
                    ),
          SizedBox(height: 30,),
          buildSearch(),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return buildUser(book);
              },
            ),
          ),
        ],
      ),

                      Container(decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.1,
                              0.5,
                              1,
                            ],
                            colors: [
                              Color.fromARGB(255, 51, 15, 169),

                              Color.fromARGB(140, 51, 15, 169),
                              Color.fromARGB(0, 51, 15, 169),
                            ],

                          ),),height: 130,margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height-top,))])
    ),
                  ),
                ),

    ]
  ),
  );

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'بحث',
    onChanged: searchBook,


  );

  Widget buildUser(User user) => InkWell(
    child: Container(width: double.infinity, height: 80,color: Colors.white.withOpacity(user.container),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Container(width:60,child:Image.asset("assets/images/char"+user.char+".png",width: 80,height: 80,)),
        SizedBox(width: 10,),
        Container(width:120,child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(margin: EdgeInsets.fromLTRB(5, 5, 25, 5),alignment: Alignment.centerRight,child:Text(user.name,textAlign: TextAlign.right,style: TextStyle(fontSize: 17,color:Colors.white),),),
          Container(margin: EdgeInsets.fromLTRB(5, 5, 0, 5),child:Text(user.number,textAlign: TextAlign.right,style: TextStyle(fontSize: 17,color:Colors.white.withOpacity(0.3)))),


        ],)),
        SizedBox(width: 10,),
        Container(alignment: Alignment.center,padding: EdgeInsets.all(1),width:70,height:30,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8),topLeft: Radius.circular(8),topRight:Radius.circular(8) ),color: Colors.white.withOpacity(0.2)),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(child: Image.asset(
            'assets/images/Trophy.png',
            width: 29,
            height: 29,
          ),
            width: 29,
            height: 29,

          ),
          Container(child:Text(user.trophy?? '',style: TextStyle(color: Colors.white,fontSize:15,fontWeight: FontWeight.w800),)),

        ],)),
        SizedBox(width: 15,),
        Container(child:Stack(alignment: Alignment.center,children: [


          Visibility(
            child: Container(width:30,height: 30,decoration : BoxDecoration(color:Colors.transparent.withOpacity(0),
                image: DecorationImage(
                  image: AssetImage('assets/images/realtic.png'),

                  fit: BoxFit.cover,

                ),border: Border.all(color: Colors.white),borderRadius: BorderRadius.only(topRight: Radius.circular(100),topLeft: Radius.circular(100),bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100)))),
          visible:user.click ,),
          Visibility(child :Container(decoration : BoxDecoration(color:Colors.white.withOpacity(0.2),
              border: Border.all(color: Colors.white),borderRadius: BorderRadius.only(topRight: Radius.circular(100),topLeft: Radius.circular(100),bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100))),width:30,height: 30),visible: user.clickbar,)

        ],)),
      ],),



    ),onTap: () async {
      print(user.clickbar);
      print(user.click);
      setState(() {
        if(user.clickbar==true){
          counter++;
          players.add(user.name);
        user.clickbar=false;
        user.click=true;}
        else{user.clickbar=true;
        counter--;
        players.remove(user.name);
        user.click=false;}
        if(user.container==0){user.container=0.2;}
        else{user.container=0;}
      });
      print(user.name);
      if(counter>0){setState(() {
        condition=true;
        top=200;

      });}
      else{setState(() {
        condition=false;
        top=130;
      });}







    print("aaaaaaaaaaa");

    },
  );



  void searchBook(String query) {
    final books = allUsers.where((book) {
      final titleLower = book.name.toLowerCase();
      final authorLower = book.number.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.books = books;
    });
  }
}