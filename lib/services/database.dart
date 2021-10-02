import 'package:chit_chat/custom/chatinfo.dart';
import 'package:chit_chat/custom/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDatabaseService {
  // String? Chatid;

  // void setchatid(String chatid) {
  //   chatid = chatid;
  // }

  final CollectionReference chatcollection =
      FirebaseFirestore.instance.collection('chatroom');

  Future createchatroom(String chatid, String person1, String person2) async {
    try {
      return await chatcollection.doc(chatid).set({
        'person1': person1,
        'person2': person2,
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future createchatmessage(String chatid, String sendby, String message) async {
    try {
      return await chatcollection.doc(chatid).collection('chats').add({
        'message': message,
        'sendby': sendby,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  getchatmessage(String chatid) {
    return FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  // List<Chatinfo> _chatinfofromfirestoresnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Chatinfo(
  //       message: doc.get('message'),
  //       sendby: doc.get('sendby'),
  //     );
  //   }).toList();
  // }

  // Stream<List<Chatinfo>?>? get chatstream {
  //   try {
  //     return chatcollection
  //         .doc(Chatid)
  //         .collection('chats')
  //         .snapshots()
  //         .map(_chatinfofromfirestoresnapshot);
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }
}

//database service...

class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('users');

  List<userinfo> _userinfoFromFirestoreSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return userinfo(
          uid: doc.get('uid') ?? 'no uid',
          email: doc.get('email') ?? 'no email',
          username: doc.get('username') ?? 'no username');
    }).toList();
  }

  Future uploaduserinfo(String username, String email) async {
    try {
      return await usercollection
          .doc(uid)
          .set({'username': username, 'email': email, 'uid': uid});
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<DocumentSnapshot> getdocuments(String uid) async {
    return usercollection.doc(uid).get();
  }

  //stream database...
  Stream<List<userinfo>?>? get UserDatabaseStream {
    try {
      // print('database data is here!!!');
      //print(usercollection.snapshots());
      return usercollection.snapshots().map(_userinfoFromFirestoreSnapshot);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
