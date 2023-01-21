import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tedxvitb/methods/feed_likes.dart';
import 'package:tedxvitb/screens/components/drawer.dart';
import 'package:tedxvitb/screens/components/eventsfeed.dart';
import 'package:tedxvitb/screens/components/feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // getLikes();
    super.initState();
  }
  var eventOrHome = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        width: width * 0.6,
        child: drawer(context),
      ),
      appBar: AppBar(
        toolbarHeight: 0.075 * height,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "assets/images/tedxlogo.png",
          height: 0.055 * height,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: eventOrHome,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "events",
          ),
        ],
        onTap: (val) {
          setState(() {
            eventOrHome = val;
          });
        },
      ),
      body: eventOrHome == 0 ?
      FutureBuilder(
          future: getLikes(),
          builder: (context, snaps) {
            if(snaps.connectionState == ConnectionState.waiting){
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 200,
                  ));
            }
            else if(snaps.hasData){
              return const Feed();
            }
            else{
              return const Text("errr");
            }
          }
      ) :
      FutureBuilder(
          future: getEventsRegistered(),
          builder: (context, snaps) {
            if(snaps.connectionState == ConnectionState.waiting){
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 200,
                  ));
            }
            else if(snaps.hasData){
              return const EventsFeed();
            }
            else{
              return const Text("errr");
            }
          }
      )
    );
  }
}
