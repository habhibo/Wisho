import 'package:flutter/material.dart';
import 'package:wechou/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return

      MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter LoginPage',

          theme: ThemeData(
            fontFamily: 'Almarai',
//textTheme:
//GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
//home: LoginPage(),
//onGenerateRoute: (settings){
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,




      );
    //}

// Otherwise, show something whilst waiting for initialization to complete
    //return Loading();
  }}
//}
