import 'package:cloud_firestore/cloud_firestore.dart';


class UserData {
  String displayName;
  String firstName;
  String lastName;
  String email;
  String id;
  String photoURL;
  Roles roles;
  String uid;
  DateTime dateOfBirth;
  String gender;
  String country;


  UserData({this.displayName,
    this.firstName, this.lastName,
    this.email,
    this.id,
    this.photoURL,
    this.roles,
    this.dateOfBirth,
    this.gender, this.country,
    this.uid,

  });

  UserData.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    id = json['id'];
    photoURL = json['photoURL'];
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
    uid = json['uid'];
    gender = json['gender'];
    country = json['country'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;

    data['id'] = this.id;
    data['photoURL'] = this.photoURL;
    if (this.roles != null) {
      data['roles'] = this.roles.toJson();
    }
    data['uid'] = this.uid;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['country ']= this.country;
    return data;
  }
}



class Roles {
  bool admin;
  bool user;

  Roles({this.admin, this.user});

  Roles.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    user = json['expert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['expert'] = this.user;
    return data;
  }
}