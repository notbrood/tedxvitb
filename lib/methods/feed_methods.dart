import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getFeedDocs () async {
  var ref = await firestore.collection("feed").get();
  return ref;
}