import 'package:cloud_firestore/cloud_firestore.dart';


class UserData {
  String displayName;
  String firstName;
  String lastName;
  String email;
  bool exists;
  String id;
  bool isAnonymous;
  String photoURL;
  Roles roles;
  String uid;
  DateTime dateOfBirth;
  String gender;
  String country;
  DateTime createdAt;
  List<String> savedNews;
  List<String> myNews;
  List<String> myValidatedNews;

  UserData({this.displayName,
    this.firstName, this.lastName,
    this.email,
    this.exists,
    this.id,
    this.isAnonymous,
    this.photoURL,
    this.roles,
    this.dateOfBirth,
    this.gender, this.country,
    this.uid,
    this.savedNews,
    this.myNews,
    this.myValidatedNews
  });

  UserData.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    exists = json['exists'];
    id = json['id'];
    isAnonymous = json['isAnonymous'];
    photoURL = json['photoURL'];
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
    uid = json['uid'];
    dateOfBirth = ( json["dateOfBirth"] as Timestamp).toDate() ;
    gender = json['gender'];
    country = json['country'];
    savedNews = json['savedNews']!= null?json['savedNews'].cast<String>():null;
    myNews = json['myNews']!= null?json['myNews'].cast<String>():null;
    myValidatedNews = json['myValidatedNews']!= null?json['myValidatedNews'].cast<String>():null;;
    createdAt = json['createdAt']!=null?json['createdAt'] is  DateTime?json['createdAt'] :
    json['createdAt'] is String ? DateTime.parse(json['createdAt']) : DateTime
        .parse(json['createdAt'].toDate().toString()):DateTime.now();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['exists'] = this.exists;

    data['id'] = this.id;
    data['isAnonymous'] = this.isAnonymous;
    data['photoURL'] = this.photoURL;
    if (this.roles != null) {
      data['roles'] = this.roles.toJson();
    }
    data['uid'] = this.uid;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['country ']= this.country;
    data['savedNews'] = this.savedNews;
    data['myValidatedNews'] = this.myValidatedNews;
    data['myNews'] = this.myNews;
    data['createdAt'] = this.createdAt ?? DateTime.now();
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