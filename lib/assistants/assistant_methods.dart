import 'package:firebase_database/firebase_database.dart';
import 'package:tripmo/global/global.dart';
import 'package:tripmo/models/user_model.dart';

class AssistantMethods {
  //get current online user
  static void getCurrentOnlineUser() async {
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users/${currentUser!.uid}');

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        User userData = User.fromSnapshot(snap.snapshot);
      }
    });
  }
}
