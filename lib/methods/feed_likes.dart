import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';
List<dynamic> likesList = [];
List<dynamic> registeredEvents = [];

Future<DocumentSnapshot<Map<String, dynamic>>> getLikes() async {
  var doc = await firestore.collection("userData").doc(auth.currentUser!.uid).get();
  likesList = doc.data()!["likedFeedItem"];
  return doc;
}

Future<DocumentSnapshot<Map<String, dynamic>>> getEventsRegistered() async {
  var doc = await firestore.collection("userData").doc(auth.currentUser!.uid).get();
  registeredEvents = doc.data()!["eventsRegisteredFor"];
  return doc;
}

updateLikes(String id, int remOrAdd) async{
  if (remOrAdd == 0) {
    await firestore
        .collection("userData")
        .doc(auth.currentUser!.uid)
        .update({
      'likedFeedItem': FieldValue.arrayRemove([id])
    });
    var likesdoc = await firestore.collection("feed").doc(id).get();
    var likecount = likesdoc.data()!["likes"];
    await firestore
        .collection("feed").doc(id).update({"likes": --likecount});
  }
  else{
    await firestore
        .collection("userData")
        .doc(auth.currentUser!.uid)
        .update({
      'likedFeedItem': FieldValue.arrayUnion([id])
    });
    var likesdoc = await firestore.collection("feed").doc(id).get();
    var likecount = likesdoc.data()!["likes"];
    await firestore
        .collection("feed").doc(id).update({"likes": ++likecount});
  }
}

updateEventNumbers(String id, int remOrAdd) async{
  if (remOrAdd == 0) {
    await firestore
        .collection("userData")
        .doc(auth.currentUser!.uid)
        .update({
      'eventsRegisteredFor': FieldValue.arrayRemove([id])
    });
    var likesdoc = await firestore.collection("events").doc(id).get();
    var likecount = likesdoc.data()!["registered_people"];
    await firestore
        .collection("events").doc(id).update({"registered_people": --likecount});
  }
  else{
    await firestore
        .collection("userData")
        .doc(auth.currentUser!.uid)
        .update({
      'eventsRegisteredFor': FieldValue.arrayUnion([id])
    });
    var likesdoc = await firestore.collection("events").doc(id).get();
    var likecount = likesdoc.data()!["registered_people"];
    await firestore
        .collection("events").doc(id).update({"registered_people": ++likecount});
  }
}