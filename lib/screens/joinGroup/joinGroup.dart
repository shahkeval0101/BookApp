import 'package:Book_club/screens/root/root.dart';
import 'package:Book_club/services/database.dart';
import 'package:Book_club/states/currentUser.dart';
import 'package:Book_club/widgets/ourContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurJoinGroup extends StatefulWidget {
  // final UserModel userModel;

  // JoinGroup({this.userModel});
  @override
  _OurJoinGroupState createState() => _OurJoinGroupState();
}

class _OurJoinGroupState extends State<OurJoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    //   String _returnString = await DBFuture().joinGroup(groupId, _currentUser);
    //   if (_returnString == "success") {
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => OurRoot(),
    //         ),
    //         (route) => false);
    //   } else {
    //     _scaffoldKey.currentState.showSnackBar(
    //       SnackBar(
    //         content: Text(_returnString),
    //         duration: Duration(seconds: 2),
    //       ),
    //     );
    //   }
    String _returnString = await OurDatabase()
        .createGroup(groupId, _currentUser.getCurrentUser.uid);

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(
                // onGroupCreation: true,
                // onError: false,
                // groupName: groupName,
                ),
          ),
          (route) => false);
    }
  }

  TextEditingController _groupIdController = TextEditingController();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _joinGroup(context, _groupIdController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
