import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  static String UID="";
  String priflImage = "";
  String priflName = "";
  Authentication(this._firebaseAuth);


  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();
    User getUSer(){
       return _firebaseAuth.currentUser;
     }
     String getName(){
       if (_firebaseAuth.currentUser.isAnonymous) {
         priflName = "Guest";
       } else {
         priflName = _firebaseAuth.currentUser.displayName;
       }
       return priflName;
     }
  String getPrfoilpic(){
    if (_firebaseAuth.currentUser.isAnonymous || _firebaseAuth.currentUser.photoURL==null) {
      priflImage = "https://image.flaticon.com/icons/png/512/64/64572.png";
    } else {
      priflImage = _firebaseAuth.currentUser.photoURL;
    }
return priflImage;
  }
  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    if(_firebaseAuth.currentUser.isAnonymous){
      _firebaseAuth.currentUser.delete();
    }
    await _firebaseAuth.signOut();

  }
  Future<String> signInWithFacebook() async {
    final  result = await FacebookAuth.instance.login();
    User user;
    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.token);
    // Once signed in, return the UserCredential
    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      user = userCredential.user;
        if(!user.emailVerified){
          user.sendEmailVerification();
          signOut();
          return "Please confirm your email address";
        }else{
          UID=_firebaseAuth.currentUser.uid;
          return "true";
        }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
       return e.message;
      }
      else if (e.code == 'invalid-credential') {
     return e.message;
      }
    } catch (e) {
      print(e);
    }
  }

    Future<String> signInWithGoogle(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        if(!user.emailVerified){
          user.sendEmailVerification();
          signOut();
          return "Please confirm your email address";
        }else{
          UID=_firebaseAuth.currentUser.uid;
          return "true";
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return e.message;
        }
        else if (e.code == 'invalid-credential') {
         return e.message;
        }
       return e.message;
      } catch (e) {
       print(e);
      }
    }
  }
  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(!userCredential.user.emailVerified){
        signOut();
        return "Please confirm your email address";
      }else{
        UID=_firebaseAuth.currentUser.uid;
        return "true";
      }
    } on FirebaseAuthException catch (e) {
        print(e.message);
        return e.message;
    }
  }
  Future<String> signInAnonymus() async {
    try {
      UserCredential userCredential=await _firebaseAuth.signInAnonymously();
        UID= userCredential.user.uid;
        return "true";
    } on FirebaseAuthException catch (e) {
        print(e.message);
        return e.message;
    }
  }
  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password,String name}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
      _firebaseAuth.currentUser.sendEmailVerification();
      _firebaseAuth.currentUser.updateProfile(displayName: name,);
      return "Registration successful, Please check your email address";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  @override
  Future<String> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return "Please check your email address";
  }
}