import 'package:chit_chat/custom/userinfo.dart';
import 'package:chit_chat/screens/home/userinfotile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  //const UserList({Key? key}) : super(key: key);
  String? username;
  userinfo? curruserdata;
  UserList({this.username, this.curruserdata});
  @override
  _UserListState createState() =>
      _UserListState(username: username, curruserdata: curruserdata);
}

class _UserListState extends State<UserList> {
  String? username;
  userinfo? curruserdata;
  _UserListState({this.username, this.curruserdata});
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<List<userinfo>?>(context);
    // if (userdata != null) {
    //   userdata.forEach((element) {
    //     print(element.email);
    //     print(element.username);
    //   });
    // }
    return ListView.builder(
      itemCount: userdata == null ? null : userdata.length,
      itemBuilder: (context, index) {
        if (userdata != null && userdata[index].username == username) {
          return SizedBox.shrink();
        }
        return userInfoTile(
          userdata: userdata == null
              ? null
              : userdata[index].username == username
                  ? null
                  : userdata[index],
          curruserdata: curruserdata,
        );
      },
    );
  }
}
