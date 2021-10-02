import 'package:chit_chat/screens/loading.dart';
import 'package:chit_chat/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);

  final Function? func;

  SignIn({this.func});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? error;
  bool? loading = false;

  @override
  Widget build(BuildContext context) {
    return loading!
        ? Loading()
        : Scaffold(
            //resizeToAvoidBottomInset: false,
            backgroundColor: Colors.brown[100],
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 60, 30, 18),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter your email and password to get started',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            //email text input...
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 18),
                                validator: (val) =>
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val!)
                                        ? null
                                        : 'Enter a valid email',
                                decoration: InputDecoration(
                                  hintText: 'Email',
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
                                  fillColor: Colors.brown[200],
                                  filled: true,
                                ),
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                            ),
                            //password text input...
                            Container(
                              //alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 18),
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter password' : null,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
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
                                  fillColor: Colors.brown[200],
                                  filled: true,
                                ),
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //forgot password...implement the logic for this ....
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(0, 8, 35, 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Forgot Password?',
                                style:
                                    const TextStyle(color: Colors.blueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO...
                                    //print('tapped from sign in');
                                    //widget.func!();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      //sign up click...
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'SignUp!',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('tapped from sign in');
                                    widget.func!();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      //sign in button...
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(
                                () {
                                  loading = true;
                                },
                              );
                              var result = await _auth.signwithemailandpassword(
                                  email!, password!);
                              if (result != null) {
                                print(result.uid);
                              } else {
                                setState(
                                  () {
                                    loading = false;
                                    error = 'Wrong email or password!';
                                  },
                                );
                              }
                            }

                            // var result = await _auth.SignInAnon();

                            // if (result != null) {
                            //   print('signed in');
                            //   print(result.uid);
                            //   ScaffoldMessenger.of(context)
                            //     ..removeCurrentSnackBar()
                            //     ..showSnackBar(
                            //       SnackBar(
                            //         content: const Text('Signed in'),
                            //         behavior: SnackBarBehavior.floating,
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(30),
                            //         ),
                            //         duration: const Duration(seconds: 2),
                            //         width: 85,
                            //       ),
                            //     );
                            // } else
                            //   print('failed');
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(110, 50),
                            primary: Colors.brown[300],
                            onPrimary: Colors.white70,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                        child: Text(
                          error ?? '',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
