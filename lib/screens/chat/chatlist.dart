import 'package:chit_chat/custom/chatinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chatlist extends StatefulWidget {
  const Chatlist({Key? key}) : super(key: key);

  @override
  _ChatlistState createState() => _ChatlistState();
}

class _ChatlistState extends State<Chatlist> {
  @override
  Widget build(BuildContext context) {
    final chatdata = Provider.of<List<Chatinfo>?>(context);
    if (chatdata != null) {
      print('here is the message');
      print(chatdata[0].message);
    }
    ;
    return ListView.builder(
        itemCount: chatdata == null ? 1 : chatdata.length,
        itemBuilder: (context, index) {
          return chattile(
              message: chatdata == null ? null : chatdata[index].message);
        });
  }
}

class chattile extends StatelessWidget {
  //const chattile({Key? key}) : super(key: key);
  final String? message;
  chattile({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message ?? 'no data!',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
