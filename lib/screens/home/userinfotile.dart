import 'package:chit_chat/custom/userinfo.dart';
import 'package:chit_chat/screens/chat/chat.dart';
import 'package:chit_chat/services/database.dart';
import 'package:flutter/material.dart';

class userInfoTile extends StatelessWidget {
  //const userInfoTile({ Key? key }) : super(key: key);
  ChatDatabaseService chatDatabaseService = ChatDatabaseService();
  final userinfo? userdata;
  final userinfo? curruserdata;
  userInfoTile({this.userdata, this.curruserdata});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[200],
            child: Icon(Icons.person),
          ),
          title: Text(userdata == null ? '' : userdata!.username.toString()),
          subtitle: Text(userdata == null ? '' : userdata!.email.toString()),
          onTap: () async {
            String? chatid;
            if (userdata!.uid!.compareTo(curruserdata!.uid!) > 0) {
              chatid = userdata!.uid! + curruserdata!.uid!;
            } else {
              chatid = curruserdata!.uid! + userdata!.uid!;
            }
            await chatDatabaseService.createchatroom(
                chatid, userdata!.username!, curruserdata!.username!);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          chatid: chatid,
                          currusername: curruserdata!.username,
                          username: userdata!.username,
                        )));
          },
        ),
      ),
    );
  }
}
