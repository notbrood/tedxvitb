import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tedxvitb/screens/home_screen.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';

Future<void> logIn(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null &&
      googleSignInAccount.email.contains('@vitbhopal.ac.in')) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await auth.signInWithCredential(authCredential);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    try {
      await firestore
          .collection("userData")
          .doc(auth.currentUser!.uid)
          .update({'eventsRegisteredFor': FieldValue.arrayUnion([]), 'likedFeedItem': FieldValue.arrayUnion([]),});
    } catch (e) {
      await firestore.collection("userData").doc(auth.currentUser!.uid).set(
        {'eventsRegisteredFor': [], 'likedFeedItem': []},
      );
    }

  } else if (googleSignInAccount != null) {
    await googleSignIn.signOut();
    final x = const SnackBar(
      content: Text("Please login using VITB email id!"),
      backgroundColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(x);
  } else {
    final x = const SnackBar(
      content: Text("There was an error!"),
      backgroundColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(x);
  }
}
