import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tedxvitb/methods/event_feed_methods.dart';
import 'package:tedxvitb/methods/feed_methods.dart';
import 'package:tedxvitb/models/events_feed_item.dart';
import 'package:tedxvitb/models/feed_item.dart';
import 'eventsfeed_item.dart';
import 'feed_item.dart';

class EventsFeed extends StatefulWidget {
  const EventsFeed({Key? key}) : super(key: key);

  @override
  State<EventsFeed> createState() => _EventsFeedState();
}

class _EventsFeedState extends State<EventsFeed> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getEventFeedDocs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 200,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                    snapshot.data!.docs;
                List<Widget> colList = [];
                for (var doc in docs) {
                  DateTime dt1 = doc.data()["Date"].toDate();
                  if(dt1.compareTo(DateTime.now()) < 0){
                    continue;
                  }
                  colList.add(
                    EventsFeedItem(
                      feeditem: EventFeedItemModel(
                        id: doc.id,
                        title: doc.data()["title"],
                        desc: doc.data()["desc"],
                        height: height,
                        dateTime: doc.data()["Date"].toDate(),
                        width: width,
                        imgUrl: doc.data()["img_url"],
                        registeredPeople: doc.data()["registered_people"],
                      ),
                    ),
                  );
                }
                return colList.isEmpty
                    ? const Center(
                        child: Text("No events!"),
                      )
                    : Column(
                        children: colList,
                      );
              } else {
                return const Text("Error");
              }
            }
            return const Text("Error");
          },
        ),
      ),
    );
  }
}
