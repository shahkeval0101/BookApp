import 'package:Book_club/screens/root/root.dart';
import 'package:Book_club/services/database.dart';
import 'package:Book_club/states/currentUser.dart';
import 'package:Book_club/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {
  void _createGroup(BuildContext context, String groupName) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase()
        .createGroup(groupName, _currentUser.getCurrentUser.uid);

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

  TextEditingController _groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Add Book",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        _createGroup(context, _groupNameController.text),
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
