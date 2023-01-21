import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tedxvitb/methods/feed_methods.dart';
import 'package:tedxvitb/models/feed_item.dart';
import 'feed_item.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getFeedDocs(),
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
                  colList.add(
                    FeedItem(
                      feeditem: FeedItemModel(
                        id: doc.id,
                        authorName: doc.data()["author_name"],
                        caption: doc.data()["caption"],
                        height: height,
                        width: width,
                        imgUrl: doc.data()["img_url"],
                        likes: doc.data()["likes"],
                      ),
                    ),
                  );
                }
                return colList.isEmpty
                    ? const Center(
                        child: Text("No posts!"),
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
