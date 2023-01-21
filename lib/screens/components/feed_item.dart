import 'package:flutter/material.dart';
import 'package:tedxvitb/methods/feed_likes.dart';
import 'package:tedxvitb/models/feed_item.dart';

class FeedItem extends StatefulWidget {
  FeedItemModel feeditem;
  FeedItem({super.key, required this.feeditem});
  @override
  State<FeedItem> createState() => _FeedItemState(
      id: feeditem.id,
      authorName: feeditem.authorName,
      caption: feeditem.caption,
      likes: feeditem.likes,
      imgUrl: feeditem.imgUrl,
      height: feeditem.height,
      width: feeditem.width);
}

class _FeedItemState extends State<FeedItem> {
  String authorName;
  String id;
  String caption;
  int likes;
  String imgUrl;
  double height;
  double width;
  _FeedItemState(
      {required this.id,
      required this.authorName,
      required this.caption,
      required this.likes,
      required this.imgUrl,
      required this.height,
      required this.width});
  @override
  Widget build(BuildContext context) {
    bool isLiked = likesList.contains(id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.black,
        margin: EdgeInsets.all(0.01 * height),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(authorName),
              const SizedBox(
                height: 5,
              ),
              Image.network(
                imgUrl,
                width: width,
                fit: BoxFit.fill,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (likesList.contains(id)) {
                            likesList.remove(id);
                            likes--;
                          } else {
                            likesList.add(id);
                            likes++;
                          }
                        });
                        if(likesList.contains(id)){
                          updateLikes(id, 1);
                        }
                        else{
                          updateLikes(id, 0);
                        }
                      },
                      icon: Icon(
                        !isLiked
                            ? Icons.arrow_circle_up_outlined
                            : Icons.arrow_circle_up,
                        color: !isLiked ? Colors.black : Colors.red,
                      )),
                  Text(likes.toString()),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: Text(caption),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
