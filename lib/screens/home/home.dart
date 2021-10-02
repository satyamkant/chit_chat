import 'package:chit_chat/custom/userinfo.dart';
import 'package:chit_chat/screens/home/search.dart';
import 'package:chit_chat/screens/home/userlist.dart';
import 'package:chit_chat/screens/loading.dart';
import 'package:chit_chat/services/auth.dart';
import 'package:chit_chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String? userid;
  Home({this.userid});

  @override
  State<Home> createState() => _HomeState(userid: userid);
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final String? userid;
  _HomeState({this.userid});

  String? username = 'no username!';
  userinfo? curruserdata = userinfo(email: '1', uid: '1', username: '1');
  bool isloading = true;
  void usernameget() async {
    try {
      DatabaseService databaseService = DatabaseService();
      DocumentSnapshot documentSnapshot =
          await databaseService.getdocuments(userid!);
      //print(documentSnapshot.toString());
      setState(() {
        username = documentSnapshot.get('username');

        curruserdata!.email = documentSnapshot.get('email');

        curruserdata!.uid = documentSnapshot.get('uid');

        curruserdata!.username = documentSnapshot.get('username');

        isloading = false;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    usernameget();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Loading()
        : StreamProvider<List<userinfo>?>.value(
            initialData: null,
            value: DatabaseService().UserDatabaseStream,
            child: Scaffold(
              backgroundColor: Colors.brown[100],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  //not adding this feature.... :(
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SearchPage(
                  //               username: username,
                  //             )));
                },
                backgroundColor: Colors.brown[300],
                child: Icon(
                  Icons.perm_device_information_rounded,
                  size: 30,
                  color: Colors.brown[900],
                ),
              ),
              appBar: AppBar(
                title: Text(
                  'Hi $username',
                  style: TextStyle(
                    color: Colors.brown[900],
                  ),
                ),
                //elevation: 0,
                backgroundColor: Colors.brown[300],
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.brown[900],
                    ),
                    label: Text(
                      'logout',
                      style: TextStyle(
                        color: Colors.brown[900],
                      ),
                    ),
                  )
                ],
              ),
              body: UserList(
                username: username,
                curruserdata: curruserdata,
              ),
            ),
          );
  }
}
