
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String ver="";

  // create user obj based on firebase user
  TheUser? _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }


  // sign in anon


// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /*Future signInWithPhoneNumber(String phoneNumber) async {
    try {
      var result = await _auth.signInWithPhoneNumber(phoneNumber);
      var ver = result.verificationId;
      result.confirm(verificationCode)
      
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }*/

  Future signInWithCredential(credential)  async {
    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password,String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


}

class TheUser {

  final String uid;

  TheUser({ required this.uid });

}