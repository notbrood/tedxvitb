import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:tedxvitb/methods/feed_likes.dart';
import 'package:tedxvitb/models/events_feed_item.dart';

class EventsFeedItem extends StatefulWidget {
  EventFeedItemModel feeditem;
  EventsFeedItem({super.key, required this.feeditem});
  @override
  State<EventsFeedItem> createState() => _EventsFeedItemState(
      date: feeditem.dateTime,
      id: feeditem.id,
      title: feeditem.title,
      desc: feeditem.desc,
      registeredPeople: feeditem.registeredPeople,
      imgUrl: feeditem.imgUrl,
      height: feeditem.height,
      width: feeditem.width);
}

class _EventsFeedItemState extends State<EventsFeedItem> {
  String title;
  String id;
  String desc;
  int registeredPeople;
  String imgUrl;
  DateTime date;
  double height;
  double width;
  _EventsFeedItemState(
      {required this.id,
      required this.date,
      required this.title,
      required this.desc,
      required this.registeredPeople,
      required this.imgUrl,
      required this.height,
      required this.width});
  @override
  Widget build(BuildContext context) {
    bool isRegistered = registeredEvents.contains(id);
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.8,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          imgUrl,
                          width: width * 0.8,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          title,
                          style: const TextStyle(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(desc),
                        const SizedBox(height: 5,),
                        Text(dateToStr(date)),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (registeredEvents.contains(id)) {
                                registeredEvents.remove(id);
                                registeredPeople--;
                              } else {
                                registeredEvents.add(id);
                                registeredPeople++;
                              }
                            });
                            if(registeredEvents.contains(id)){
                              SnackBar x = const SnackBar(content: Text("Registered!"));
                              ScaffoldMessenger.of(context).showSnackBar(x);
                              updateEventNumbers(id, 1);
                            }
                            else{
                              SnackBar x = const SnackBar(content: Text("Unregistered!"));
                              ScaffoldMessenger.of(context).showSnackBar(x);
                              updateEventNumbers(id, 0);
                            }
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: isRegistered
                                  ? Colors.transparent
                                  : Colors.red),
                          child: SizedBox(
                            width: width,
                            child: Center(
                              child: isRegistered
                                  ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.check),
                                        SizedBox(width: 5,),
                                        Text("Registered!")
                                      ],
                                    )
                                  : const Text("Register?"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            });
      },
      child: Padding(
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
                const SizedBox(
                  height: 5,
                ),
                Image.network(
                  imgUrl,
                  width: width,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                        "Number of people registered: ${registeredPeople.toString()}"),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: width * 0.6,
                  child: Text(title),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideCountdown(
                      duration: date.difference(DateTime.now()),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  String dateToStr(DateTime date){
    return (date.toString());
  }
}
