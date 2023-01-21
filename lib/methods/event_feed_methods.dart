import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getEventFeedDocs () async {
  var ref = await firestore.collection("events").get();
  return ref;
}