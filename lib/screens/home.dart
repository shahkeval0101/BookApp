import 'dart:math';

import 'package:Book_club/screens/noGroup/noGroup.dart';
import 'package:Book_club/screens/root/root.dart';
import 'package:Book_club/states/currentUser.dart';
import 'package:Book_club/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  void _goToNoGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurNoGroup(),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  Text(
                    "Harry Potter and the sorcerer stone",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[600],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Due in',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          " 8 days",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Finished book",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Next Book revealed in',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      " 22 hours",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: RaisedButton(
              child: Text(
                "Book Club History",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _goToNoGroup(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RaisedButton(
              child: Text("SignOut"),
              onPressed: () => _signOut(context),
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                    color: Theme.of(context).secondaryHeaderColor, width: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}
