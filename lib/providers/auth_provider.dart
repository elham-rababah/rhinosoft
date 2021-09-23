import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_data.dart';
enum APP_STATUS { LOADING, UNAUTHENTICATED, AUTHENTICATED, VERIFIED_AUTHENTICATED }

class AuthProvider with ChangeNotifier {
  FirebaseUser user;
  UserData userData;
  StreamSubscription userAuthentication;

  bool loading = true;
  FirebaseMessaging _fcm = FirebaseMessaging();

  bool sendingCode = false;
  bool codeSent = false;
  bool verifying = false;
  bool verified = false;
  String verificationId;
  String error;

  AuthProvider() {
    loadAuthInfo();
  }

  loadAuthInfo(){
    userAuthentication = FirebaseAuth.instance.onAuthStateChanged
        .listen((newUser) async {
      String fcmToken = await _fcm.getToken();
      user = newUser;
      if (user!=null) {
        final DocumentSnapshot doc = await Firestore.instance.collection('users').document(user.uid).get();
        if (doc.exists) {
          UserData res = UserData.fromJson(doc.data);
          userData = res;
          if(fcmToken != null)
            await  Firestore.instance.collection('fcmTokens').document(user.uid).setData({'currentToken':fcmToken},merge: true);
        } else {
          UserData res = new UserData(
            uid: user.uid,
            displayName: user.displayName!=null && user.displayName.isNotEmpty ? user.displayName.split(" ")[0] : "",
            email: user.email,
            photoURL:  user.photoUrl ?? "",

          );
          await Firestore.instance.collection('users').document(user.uid).setData(res.toJson(), merge: true);
          userData = res;
          if(fcmToken != null)
            await  Firestore.instance.collection('fcmTokens').document(user.uid).setData({'currentToken':fcmToken},merge: true);
        }
      } else {
        userData=null;
        user=null;
      }
      loading=false;
      notifyListeners();
    },
        onError: (e) {
          print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
        });
  }
  @override
  void dispose() {
    if (userAuthentication != null) {
      userAuthentication.cancel();
      userAuthentication = null;
    }
  }

  bool get isLoading {
    return loading;
  }
  bool get isExpert {
    if (userData!=null &&userData.roles!=null)
      return userData.roles.user;
    else
      return false;
  }

  String get name {
    if (userData!=null)
      return userData.displayName;
    else
      return "";
  }

  String get email {
    if (userData!=null)
      return userData.email;
    else
      return "";
  }

  String get profilePicture {
    if (userData!=null)
      return userData.photoURL;
    else
      return null;
  }

  bool get isAuthenticated {
    return user!=null && userData!=null;
  }


  bool get isVerified {
    bool isVerified = false;
    if (user==null)
      return isVerified;
    else {
      for (UserInfo info in user.providerData) {
        if (info.providerId == "facebook.com" ||
            info.providerId == "google.com") {
          isVerified = true;
          break;
        } else if (info.providerId == "password") {
          isVerified = user.isEmailVerified;
          break;
        }
      }
      return isVerified;
    }
  }

  APP_STATUS get status {
    if (loading) {
      return APP_STATUS.LOADING;
    } else{
        if (this.isAuthenticated) {
        return APP_STATUS.AUTHENTICATED;
      } else {
        return APP_STATUS.UNAUTHENTICATED;
      }
    }
  }


  signOut() async{
    user=null;userData=null;
    await FirebaseAuth.instance.signOut();
  }

  Future googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email", "profile"]);
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount!=null) {
        GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        throw PlatformException(code: "CANCELLED", message: "User cancelled Google Sign In.");
      }
    } catch (error) {
      _googleSignIn.disconnect();
      if (error.code=="ERROR_INVALID_CREDENTIAL") {
        _googleSignIn.disconnect();
      }
      print(error);
      throw error;
    }
  }


  Future updateUserData(Map<String, dynamic> newUserData) async {
    await Firestore.instance.collection('users').document(user.uid).setData(newUserData, merge: true);
    final DocumentSnapshot doc = await Firestore.instance.collection('users').document(user.uid).get();
    if (doc.exists) {
      UserData res = UserData.fromJson(doc.data);
      userData = res;
    }
    notifyListeners();
  }

}

