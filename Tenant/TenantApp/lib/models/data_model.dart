// import 'dart:async';
// import 'dart:core';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:tenantapp/helpers/constant.dart';
//
// class DataModel extends Model {
//   Map<String, Map<String, dynamic>> userData =
//       Map<String, Map<String, dynamic>>();
//
//   Map<String, Future> _messageStatus = Map<String, Future>();
//
//   _getMessageKey(String peerNo, int timestamp) => '$peerNo$timestamp';
//
//   getMessageStatus(String peerNo, int timestamp) {
//     final key = _getMessageKey(peerNo, timestamp);
//     return _messageStatus[key] ?? true;
//   }
//
//   bool _loaded = false;
//
//   LocalStorage _storage = LocalStorage('model');
//
//   addMessage(String peerNo, int timestamp, Future future) {
//     final key = _getMessageKey(peerNo, timestamp);
//     print(key);
//     future.then((_) {
//       _messageStatus.remove(key);
//       print("removed");
//     });
//     _messageStatus[key] = future;
//   }
//
//   addUser(DocumentSnapshot user) {
//     userData[user.data()[PHONE]] = user.data();
//     notifyListeners();
//   }
//
//
//   getDir() async {
//     return await getApplicationDocumentsDirectory();
//   }
//
//   updateItem(String key, Map<String, dynamic> value) {
//     Map<String, dynamic> old = _storage.getItem(key) ?? Map<String, dynamic>();
//     old.addAll(value);
//     _storage.setItem(key, old);
//   }
//
//   bool get loaded => _loaded;
//
//   Map<String, dynamic> get currentUser => _currentUser;
//
//   Map<String, dynamic> _currentUser;
//
//   Map<String, int> get lastSpokenAt => _lastSpokenAt;
//
//   Map<String, int> _lastSpokenAt = {};
//
//   Future<void> clearLocalStorage() {
//     _currentUser = userData = _lastSpokenAt = null;
//     _loaded = false;
//
//     return _storage.clear();
//   }
//
//   DataModel(String currentUserNo) {
//     if (currentUserNo?.isEmpty == true) return;
//     FirebaseFirestore.instance
//         .collection(USERS)
//         .doc(currentUserNo)
//         .snapshots()
//         .listen((user) {
//       _currentUser = user.data();
//       if (!_loaded) {
//         _loaded = true;
//         notifyListeners();
//       }
//     });
//   }
// }
