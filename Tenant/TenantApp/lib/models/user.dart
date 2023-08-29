// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tenantapp/helpers/constant.dart';
//
//
// class User {
//   final String aboutMe;
//   final String id;
//   final String phone;
//   final String username;
//   final String email;
//   final String displayName;
//   final String photoUrl;
//   final String bio;
//   final Map<String, dynamic> mapData;
//
//   User(
//       {this.id,
//       this.aboutMe,
//       this.phone,
//       this.username,
//       this.photoUrl,
//       this.email,
//       this.displayName,
//       this.bio,
//       this.mapData});
//
//   factory User.fromDocument(DocumentSnapshot doc) {
//     return User(
//         phone: doc[PHONE],
//         id: doc[ID],
//         username: doc['username'],
//         email: doc['email'],
//         displayName: doc['displayName'],
//         photoUrl: doc['photoUrl'],
//         bio: doc['bio'],
//         mapData: doc.data());
//   }
//
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//         phone: map[PHONE],
//         id: map[ID],
//         username: map['username'],
//         email: map['email'],
//         displayName: map['displayName'],
//         photoUrl: map['photoUrl'],
//         bio: map['bio'],
//         mapData: map);
//   }
// }
