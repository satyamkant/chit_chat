import 'package:chit_chat/custom/userinfo.dart';
import 'package:chit_chat/screens/home/userlist.dart';
import 'package:flutter/material.dart';
import 'package:chit_chat/services/database.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  //const SearchPage({Key? key}) : super(key: key);
  String? username;
  SearchPage({this.username});
  @override
  _SearchPageState createState() => _SearchPageState(username: username);
}

class _SearchPageState extends State<SearchPage> {
  String? username;
  _SearchPageState({this.username});
  Icon actionIcon = Icon(
    Icons.search,
    size: 28,
  );
  Widget appBarTitle = Text(
    'Search User',
    style: TextStyle(
      color: Colors.brown[900],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<userinfo>?>.value(
      initialData: null,
      value: DatabaseService().UserDatabaseStream,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.brown[900],
          ),
          title: appBarTitle,
          //elevation: 0,
          backgroundColor: Colors.brown[300],
          actions: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                //9th a and 10th b
                icon: actionIcon,
                onPressed: () {
                  if (this.actionIcon.icon == Icons.search) {
                    setState(() {
                      this.actionIcon = Icon(Icons.close);
                      this.appBarTitle = TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.brown[900],
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.brown,
                              width: 2.5,
                            ),
                          ),
                          hintText: "Search...",
                          hintStyle: TextStyle(
                            color: Colors.brown[900],
                            fontSize: 20,
                          ),
                        ),
                      );
                    });
                  } else {
                    setState(() {
                      this.actionIcon = Icon(Icons.search);
                      this.appBarTitle = Text(
                        "Search User",
                        style: TextStyle(
                          color: Colors.brown[900],
                        ),
                      );
                    });
                  }
                },
              ),
            ),
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
