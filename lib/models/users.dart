import 'package:wechou/models/user.dart';
import'package:cloud_firestore/cloud_firestore.dart';

var allUsers = <User>[];

Future<void> allUsersfn() async {
  await FirebaseFirestore.instance
      .collection("users")
      .get()
      .then((value) {

        if (value != null) {
          for(int i =0;i<value.size;i++) {

            allUsers.add(User(
              id: allUsers.length+1,
              name: value.docs[i].data()["username"],
              number: value.docs[i].data()["phone"],
              char: value.docs[i].data()["char"],
              trophy : value.docs[i].data()["trophy"],
              clickbar:true,
              click:false,
              container:0,
            ));

          }



        }
      });

}

allUsersfn2(){

  allUsers=[];
}





