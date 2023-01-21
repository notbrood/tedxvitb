import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tedxvitb/methods/feed_likes.dart';
import 'package:tedxvitb/methods/my_events_methods.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.075 * height,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "assets/images/tedxlogo.png",
          height: 0.055 * height,
        ),
      ),
      body: FutureBuilder(
        future: getEventsRegistered(),
        builder: (context, snap) {
          return FutureBuilder(
              future: getMyEventsFeed(height, width),
              builder: (context, snaps) {
                if(snaps.connectionState == ConnectionState.waiting){
                  return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 200,
                      ));
                }
                else if(snaps.hasData){
                  return snaps.data!.isNotEmpty ? SingleChildScrollView(
                    child: Column(
                      children: snaps.data!,
                    ),
                  ) : const Center(child: Text("No events registered!"),);
                }
                else{
                  return const Text("errr");
                }
              }
          );
        }
      ),
    );
  }
}
//getEventsRegistered();