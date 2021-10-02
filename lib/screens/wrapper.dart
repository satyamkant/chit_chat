import 'package:chit_chat/custom/user.dart';
import 'package:chit_chat/screens/authentication/authentication.dart';
import 'package:chit_chat/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home(
        userid: user.uid,
      );
    }
  }
}
