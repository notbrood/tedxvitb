import 'package:flutter/material.dart';
import 'package:tedxvitb/methods/login.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginOrSignup = 0;
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -width * 0.125,
            child: Container(
              height: height * 0.35,
              width: width * 1.25,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(width * 0.3),
                    bottomLeft: Radius.circular(width * 0.3)),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: width * 0.26,
            child: Image.asset(
              "assets/images/tedxlogo.png",
              width: width * 0.5,
            ),
          ),
          Positioned(
            top: height * 0.25,
            left: width * 0.05,
            child: SizedBox(
              width: width * 0.9,
              height: height * 0.5,
              child: Card(
                elevation: 15,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/tedxbanner.png",
                      width: width,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          logIn(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),),
                        child: const Text("Login with Google!"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.85,
            left: width * 0.2,
            child: SizedBox(
              width: width * 0.6,
              height: height * 0.05,
              child: Card(
                elevation: 15,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.009, vertical: height * .005),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                    child: const Text("Visit us at our website!"),
                    onPressed: () {
                      launchUrl(
                          Uri.parse('https://www.ted.com/'),
                          mode: LaunchMode.externalApplication
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
