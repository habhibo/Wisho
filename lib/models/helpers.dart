import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  static String sharedPreferenceRoomName = "RoomName";
  static String sharedPreferenceHeart = "Heart";
  static String sharedPreferenceCoins = "COINS";
  static String sharedPreferenceTrophy = "Trophy";
  static String sharedPreferenceNb = "nbTrophy";
  static String sharedPreferenceName = "name";
  static String sharedPreferenceOnlineRoomName = "onlineRoomname";
  static String sharedPreferenceChar = "char";
  static String sharedPreferenceSfxKey = "Sfx";
  static String sharedPreferenceMusicKey = "Music";
  static String sharedPreferencePhone = "Phone";
  static String sharedPreferenceUserExist = "UserExist";


  /// saving data to sharedpreference


  static Future<bool> saveRoom(String roomName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceRoomName, roomName);
  }



  static Future<String?> getRoom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceRoomName);
  }

  static Future<bool> saveHeart(String heart) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceHeart, heart);
  }



  static Future<String?> getHeart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceHeart);
  }

  static Future<bool> saveTrophy(String trophy) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceTrophy, trophy);
  }



  static Future<String?> getTrophy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceTrophy);
  }

  static Future<bool> savenb(String nb) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceNb, nb);
  }



  static Future<String?> getnb() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceNb);
  }

  static Future<bool> savename(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceName, name);
  }



  static Future<String?> getname() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceName);
  }

  static Future<bool> saveOnlineRoom(String roomname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceOnlineRoomName, roomname);
  }



  static Future<String?> getOnlineRoom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceOnlineRoomName);
  }


  static Future<bool> saveChar(String char) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceChar, char);
  }



  static Future<String?> getChar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceChar);
  }

  static Future<bool> saveSfx(bool Sfx) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceSfxKey, Sfx);
  }
  static Future<bool?> getSfx() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceSfxKey);
  }

  static Future<bool> saveMusic(bool Music) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceMusicKey, Music);
  }
  static Future<bool?> getMusic() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceMusicKey);
  }

  static Future<bool> savePhone(String Phone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencePhone, Phone);
  }



  static Future<String?> getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferencePhone);
  }

  static Future<bool> saveCoin(String Coin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceCoins, Coin);
  }



  static Future<String?> getCoin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceCoins);
  }

  static Future<bool> saveUserExist(bool exist) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserExist, exist);
  }



  static Future<bool?> getUserExist() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserExist);
  }





}