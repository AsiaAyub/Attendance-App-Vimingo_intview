import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main.dart';

class IntroductionPage extends StatelessWidget {
  // the box to store the state if user is using for fist time
  final box = Hive.box('introduction');

  IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Onboard Page'),
        ),
        body: IntroductionScreen(
            scrollPhysics: const BouncingScrollPhysics(),
            pages: [
              PageViewModel(
                title: 'Attendance App usage tips',
                body:
                    'This attendance app allows you to view all users list. Tap on any user name to '
                    'view their profile page',
                decoration: const PageDecoration(
                    bodyTextStyle: TextStyle(
                  fontSize: 16,
                )),
                image: Image.asset('assets/images/pvm1.jpg'),
                reverse: true,
              ),
              PageViewModel(
                title: 'Attendance App usage tips',
                body:
                    "Tap on share icon to share the user's information on other apps",
                decoration: const PageDecoration(
                    bodyTextStyle: TextStyle(
                  fontSize: 16,
                )),
                image: Center(
                  child: Image.asset('assets/images/pvm2.png'),
                ),
                reverse: true,
              ),
              PageViewModel(
                title: 'Attendance App usage tips',
                body:
                    'Tap on add user button at the bottom of the page to add new user information to the list',
                decoration: const PageDecoration(
                    bodyTextStyle: TextStyle(
                  fontSize: 16,
                )),
                image: Center(
                  child: Image.asset('assets/images/pvm3.png'),
                ),
                reverse: true,
              ),
              PageViewModel(
                title: 'Attendance App usage tips',
                body:
                    "Tap on search icon at the appbar to search through the user's information",
                decoration: const PageDecoration(
                    bodyTextStyle: TextStyle(
                  fontSize: 16,
                )),
                image: Center(
                  child: Image.asset('assets/images/pvm2.png'),  ),
                reverse: true,
              ),
            ],
            onDone: () {
              box.put('introduction', false);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const HomeScreen();
                  },
                ),
              );
            },
            showSkipButton: true, //the skip button to be display
            skip: const Icon(Icons.skip_next, color: Colors.lightGreen,),
            next: const Icon(Icons.forward, color: Colors.lightGreen,),
            done: const Text("Done",
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)))));
  }
}
