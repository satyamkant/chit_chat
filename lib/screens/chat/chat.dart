import 'package:chit_chat/custom/chatinfo.dart';
import 'package:chit_chat/screens/chat/chatlist.dart';
import 'package:chit_chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  //const ChatScreen({Key? key}) : super(key: key);
  String? chatid;
  String? username;
  String? currusername;
  ChatScreen({this.chatid, this.currusername, this.username});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatDatabaseService chatDatabaseService = ChatDatabaseService();
  Stream<QuerySnapshot>? chatmessagestream;

  final _formkey = GlobalKey<FormState>();
  String? messages;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.brown[900],
        ),
        backgroundColor: Colors.brown[300],
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.brown[200],
              child: Icon(
                Icons.person,
                color: Colors.brown[900],
              ),
              radius: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${widget.username}',
              style: TextStyle(
                color: Colors.brown[900],
              ),
            ),
          ],
        ),
      ),

      ////////////...............................body starts here...........................................\\\\\\\\\
      body: Container(
        child: Stack(
          children: [
            //Chatlist(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Form(
                      key: _formkey,
                      child: TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Write a message!!!' : null,
                        onChanged: (val) {
                          setState(() => messages = val);
                        },
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.brown[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.message,
                            color: Colors.brown[900],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.brown,
                              width: 2.5,
                            ),
                          ),
                          hintText: "Write a message...",
                          hintStyle: TextStyle(
                            color: Colors.brown[900],
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await ChatDatabaseService().createchatmessage(
                              widget.chatid!, widget.currusername!, messages!);
                        }
                      },
                      child: Icon(Icons.send),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(110, 50),
                        primary: Colors.brown[300],
                        onPrimary: Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
