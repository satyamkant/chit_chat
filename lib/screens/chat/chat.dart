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

  Stream? chatMessageStream;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data == null
                ? 1
                : (snapshot.data! as QuerySnapshot).docs.length,
            itemBuilder: (context, index) {
              return chattile(
                message: snapshot.data == null
                    ? 'No messages!!!'
                    : (snapshot.data! as QuerySnapshot).docs[index]["message"],
                sentby: snapshot.data == null
                    ? 'no user'
                    : (snapshot.data! as QuerySnapshot).docs[index]["sendby"],
                currusr: widget.currusername,
              );
            });
      },
    );
  }

  @override
  void initState() {
    chatMessageStream = chatDatabaseService.getchatmessage(widget.chatid!);
    //print(chatmessagestream.toString());
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
            Container(
                height: MediaQuery.of(context).size.height - 160,
                child: ChatMessageList()),
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

class chattile extends StatelessWidget {
  //const chattile({Key? key}) : super(key: key);
  final String? message;
  final String? sentby;
  final String? currusr;
  chattile(
      {required this.message, required this.sentby, required this.currusr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10),
      alignment: sentby == null
          ? Alignment.center
          : sentby == currusr
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width - 150,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            title: Text(message ?? ''),
            subtitle: Text(sentby == null
                ? ''
                : sentby == currusr
                    ? 'sent by you'
                    : 'sent by $sentby'),
          ),
        ),
      ),
    );
  }
}
