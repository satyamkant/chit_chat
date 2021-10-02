import 'package:chit_chat/screens/authentication/register.dart';
import 'package:chit_chat/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';
//this file is use to direct people either in sign in or in register...

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signin = true;
  void reverse() {
    setState(() => signin = !signin);
  }

  @override
  Widget build(BuildContext context) {
    //this is working as a wrapper for sign in and register...
    return (signin) ? SignIn(func: reverse) : Register(func: reverse);
  }
}
