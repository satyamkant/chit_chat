import 'package:chit_chat/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:chit_chat/services/auth.dart';

class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);
  final Function? func;

  Register({this.func});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? username;
  String? error;
  bool? loading = false;

  @override
  Widget build(BuildContext context) {
    return loading!
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      //information text...
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 60, 30, 18),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter below details to register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      //email text input...
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            //username text input...
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 18),
                                validator: (val) => val!.length >= 2
                                    ? null
                                    : 'Provide a name with atlest 2 characters!',
                                decoration: InputDecoration(
                                  hintText: 'Name',
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
                                  setState(() => username = val);
                                },
                              ),
                            ),

                            //email text input...
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 18),
                                validator: (val) =>
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val!)
                                        ? null
                                        : 'Enter an email',
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
                              padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 18),
                                validator: (val) => val!.length < 6
                                    ? 'Enter password with atlest 6 characters!'
                                    : null,
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Sign in',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('tapped from register');
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
                              setState(() {
                                loading = true;
                              });
                              var result =
                                  await _auth.registerwithemailandpassword(
                                      email!, password!, username!);
                              if (result != null) {
                                print(result.uid);
                              } else {
                                setState(() {
                                  loading = false;
                                  error = 'Please provide a valid email!';
                                });
                              }
                              ;
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
                            'Sign Up',
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
