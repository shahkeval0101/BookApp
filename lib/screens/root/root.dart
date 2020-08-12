import 'package:Book_club/screens/home.dart';
import 'package:Book_club/screens/login/login.dart';
import 'package:Book_club/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus { unknown, notLoggedIn, loggedIn }

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;
  // String currentUid;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // @override
  // void initState() {
  //   super.initState();

  //   if (Platform.isIOS) {
  //     _firebaseMessaging
  //         .requestNotificationPermissions(IosNotificationSettings());
  //     _firebaseMessaging.onIosSettingsRegistered.listen((event) {
  //       print("IOS Registered");
  //     });
  //   }

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //     },
  //   );
  // }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state, check current User, set AuthStatus based on state
    // AuthModel _authStream = Provider.of<AuthModel>(context);
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
        // currentUid = _authStream.uid;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
      // retVal = SplashScreen();
      // break;
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.loggedIn:
        // retVal = StreamProvider<UserModel>.value(
        //   value: DBStream().getCurrentUser(currentUid),
        //   child: LoggedIn(),
        // );
        retVal = HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}

// class LoggedIn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     UserModel _userStream = Provider.of<UserModel>(context);
//     Widget retVal;
//     if (_userStream != null) {
//       if (_userStream.groupId != null) {
//         retVal = StreamProvider<GroupModel>.value(
//           value: DBStream().getCurrentGroup(_userStream.groupId),
//           child: InGroup(),
//         );
//       } else {
//         retVal = NoGroup();
//       }
//     } else {
//       retVal = SplashScreen();
//     }

//     return retVal;
//   }
// }
