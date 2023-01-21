import 'package:flutter/material.dart';
import 'package:tedxvitb/models/events_feed_item.dart';
import 'package:tedxvitb/screens/components/eventsfeed_item.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';

import 'feed_likes.dart';

Future<List<Widget>> getMyEventsFeed(double height, double width) async {
  List<Widget> res = [];
  var collection = await firestore.collection("events").get();
  var docs = collection.docs;
  for (var doc in docs) {
    if(!registeredEvents.contains(doc.id)){
      continue;
    }
    DateTime dt1 = doc.data()["Date"].toDate();
    if(dt1.compareTo(DateTime.now()) < 0){
      continue;
    }
    EventFeedItemModel feedItemData = EventFeedItemModel(
        id: doc.id,
        title: doc.data()["title"],
        desc: doc.data()["desc"],
        registeredPeople: doc.data()["registered_people"],
        dateTime: doc.data()["Date"].toDate(),
        imgUrl: doc.data()["img_url"],
        height: height,
        width: width);
    res.add(EventsFeedItem(feeditem: feedItemData,));
  }
  return res;
}
