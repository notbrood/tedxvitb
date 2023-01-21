import 'package:flutter/material.dart';
import 'package:tedxvitb/screens/my_events.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawer(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(auth.currentUser!.photoURL!),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  auth.currentUser!.displayName!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MyEvents()));
            },
            child: const Text(
              "My events",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse("https://www.ted.com/"),
                  mode: LaunchMode.externalApplication);
            },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text(
              "Follow TEDxVITB!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse('https://www.linkedin.com/company/tedx-tedx/'),
                      mode: LaunchMode.externalApplication);
                },
                icon: Image.asset(
                  "assets/images/linkedinlogo.png",
                  height: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse('https://www.instagram.com/tedx_official/'),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                icon: Image.asset(
                  "assets/images/iglogo.png",
                  height: 40,
                ),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://www.youtube.com/@TEDx'),
                      mode: LaunchMode.externalApplication);
                },
                icon: Image.asset(
                  "assets/images/ytlogo.png",
                  height: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://twitter.com/TEDx'),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                icon: Image.asset(
                  "assets/images/twitterlogo.png",
                  height: 30,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Team",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'logins', (Route<dynamic> route) => false);
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ],
      )
    ],
  );
}
