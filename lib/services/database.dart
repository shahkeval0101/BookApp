import 'package:Book_club/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class OurDatabase {
  final Firestore _firestore = Firestore.instance;
  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").document(user.uid).setData({
        'fullName': user.fullName.trim(),
        'email': user.email.trim(),
        'accountCreated': Timestamp.now(),
        'notifToken': user.notifToken,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> createGroup(String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    List<String> tokens = List();
    try {
      members.add(userUid);
      // tokens.add(user.notifToken);
      // DocumentReference _docRef;
      // if (user.notifToken != null) {
      //   _docRef = await _firestore.collection("groups").add({
      //     'name': groupName.trim(),
      //     'leader': userUid,
      //     'members': members,
      //     'tokens': tokens,
      //     'groupCreated': Timestamp.now(),
      //     'nextBookId': "waiting",
      //     'indexPickingBook': 0
      //   });
      // } else {
      //   _docRef = await _firestore.collection("groups").add({
      //     'name': groupName.trim(),
      //     'leader': userUid,
      //     'members': members,
      //     'groupCreated': Timestamp.now(),
      //     'nextBookId': "waiting",
      //     'indexPickingBook': 0
      //   });
      // }
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName.trim(),
        'leader': userUid,
        'members': members,
        'groupCreated': Timestamp.now(),
      });

      await _firestore.collection("users").document(userUid).updateData({
        'groupId': _docRef.documentID,
      });

      //add a book
      // addBook(_docRef.documentID, initialBook);

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    List<String> tokens = List();
    try {
      members.add(userUid);
//       tokens.add(userModel.notifToken);
      await _firestore.collection("groups").document(groupId).updateData({
        'members': FieldValue.arrayUnion(members),
        'tokens': FieldValue.arrayUnion(tokens),
      });

      await _firestore.collection("users").document(groupId).updateData({
        'groupId': groupId.trim(),
      });

      retVal = "success";
    } on PlatformException catch (e) {
      retVal = "Make sure you have the right group ID!";
      print(e);
    } catch (e) {
      print(e);
    }

    return retVal;
  }

//   Future<String> leaveGroup(String groupId, UserModel userModel) async {
//     String retVal = "error";
//     List<String> members = List();
//     List<String> tokens = List();
//     try {
//       members.add(userModel.uid);
//       tokens.add(userModel.notifToken);
//       await _firestore.collection("groups").document(groupId).updateData({
//         'members': FieldValue.arrayRemove(members),
//         'tokens': FieldValue.arrayRemove(tokens),
//       });

//       await _firestore.collection("users").document(userModel.uid).updateData({
//         'groupId': null,
//       });
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

//   Future<String> addBook(String groupId, BookModel book) async {
//     String retVal = "error";

//     try {
//       DocumentReference _docRef = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .add({
//         'name': book.name.trim(),
//         'author': book.author.trim(),
//         'length': book.length,
//         'dateCompleted': book.dateCompleted,
//       });

//       //add current book to group schedule
//       await _firestore.collection("groups").document(groupId).updateData({
//         "currentBookId": _docRef.documentID,
//         "currentBookDue": book.dateCompleted,
//       });

//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

//   Future<String> addNextBook(String groupId, BookModel book) async {
//     String retVal = "error";

//     try {
//       DocumentReference _docRef = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .add({
//         'name': book.name.trim(),
//         'author': book.author.trim(),
//         'length': book.length,
//         'dateCompleted': book.dateCompleted,
//       });

//       //add current book to group schedule
//       await _firestore.collection("groups").document(groupId).updateData({
//         "nextBookId": _docRef.documentID,
//         "nextBookDue": book.dateCompleted,
//       });

//       //adding a notification document
//       DocumentSnapshot doc =
//           await _firestore.collection("groups").document(groupId).get();
//       createNotifications(
//           List<String>.from(doc.data["tokens"]) ?? [], book.name, book.author);

//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

//   Future<String> addCurrentBook(String groupId, BookModel book) async {
//     String retVal = "error";

//     try {
//       DocumentReference _docRef = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .add({
//         'name': book.name.trim(),
//         'author': book.author.trim(),
//         'length': book.length,
//         'dateCompleted': book.dateCompleted,
//       });

//       //add current book to group schedule
//       await _firestore.collection("groups").document(groupId).updateData({
//         "currentBookId": _docRef.documentID,
//         "currentBookDue": book.dateCompleted,
//       });

//       //adding a notification document
//       DocumentSnapshot doc =
//           await _firestore.collection("groups").document(groupId).get();
//       createNotifications(
//           List<String>.from(doc.data["tokens"]) ?? [], book.name, book.author);

//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

//   Future<BookModel> getCurrentBook(String groupId, String bookId) async {
//     BookModel retVal;

//     try {
//       DocumentSnapshot _docSnapshot = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .document(bookId)
//           .get();
//       retVal = BookModel.fromDocumentSnapshot(doc: _docSnapshot);
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

//   Future<String> finishedBook(
//     String groupId,
//     String bookId,
//     String uid,
//     int rating,
//     String review,
//   ) async {
//     String retVal = "error";
//     try {
//       await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .document(bookId)
//           .collection("reviews")
//           .document(uid)
//           .setData({
//         'rating': rating,
//         'review': review,
//       });
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }

//   Future<bool> isUserDoneWithBook(
//       String groupId, String bookId, String uid) async {
//     bool retVal = false;
//     try {
//       DocumentSnapshot _docSnapshot = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .document(bookId)
//           .collection("reviews")
//           .document(uid)
//           .get();

//       if (_docSnapshot.exists) {
//         retVal = true;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }

//   Future<String> createUser(UserModel user) async {
//     String retVal = "error";

//     try {
//       await _firestore.collection("users").document(user.uid).setData({
//         'fullName': user.fullName.trim(),
//         'email': user.email.trim(),
//         'accountCreated': Timestamp.now(),
//         'notifToken': user.notifToken,
//       });
//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data['fullName'];
      retVal.email = _docSnapshot.data['email'];
      retVal.accountCreated = _docSnapshot.data['accountCreated'];
      retVal.email = _docSnapshot.data['email'];
      retVal.groupId = _docSnapshot.data['groupId'];
      // retVal = OurUser.fromDocumentSnapshot(doc: _docSnapshot);
    } catch (e) {
      print(e);
    }

    return retVal;
  }

//   Future<String> createNotifications(
//       List<String> tokens, String bookName, String author) async {
//     String retVal = "error";

//     try {
//       await _firestore.collection("notifications").add({
//         'bookName': bookName.trim(),
//         'author': author.trim(),
//         'tokens': tokens,
//       });
//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

//   Future<List<BookModel>> getBookHistory(String groupId) async {
//     List<BookModel> retVal = List();

//     try {
//       QuerySnapshot query = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .orderBy("dateCompleted", descending: true)
//           .getDocuments();

//       query.documents.forEach((element) {
//         retVal.add(BookModel.fromDocumentSnapshot(doc: element));
//       });
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }

//   Future<List<ReviewModel>> getReviewHistory(
//       String groupId, String bookId) async {
//     List<ReviewModel> retVal = List();

//     try {
//       QuerySnapshot query = await _firestore
//           .collection("groups")
//           .document(groupId)
//           .collection("books")
//           .document(bookId)
//           .collection("reviews")
//           .getDocuments();

//       query.documents.forEach((element) {
//         retVal.add(ReviewModel.fromDocumentSnapshot(doc: element));
//       });
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
}
