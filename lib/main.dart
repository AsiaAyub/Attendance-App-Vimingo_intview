import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share/share.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Introductory.dart';
import 'NewUsers.dart';
import 'Profile.dart';

// class for the addition of new users to the list
class User {
  String name;
  int phone_number;
  DateTime checking;

  User(this.name, this.phone_number, this.checking);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local storage to store needed data
  await Hive.initFlutter();
  var box = await Hive.openBox('introduction');
  var box2 = await Hive.openBox('box2');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightGreen,
          fontFamily: 'Georgia',
      ) ,
      darkTheme:ThemeData.dark(),
      title: 'Attendance App Home Page',
      home: const HomeScreen(),
    ),
  );
}

// a screen to control which page to display
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('introduction');

    // variable to check if the user loads the app for first time
    bool firstTimeState = box.get('introduction') ?? true;

    // conditional statement for which page to display
    return firstTimeState
        ? IntroductionPage()
        : const Scaffold(body: HomeScreenOverlay());
  }
}

// the screen that holds the home page
class HomeScreenOverlay extends StatefulWidget {
  const HomeScreenOverlay({super.key});

  @override
  State<HomeScreenOverlay> createState() => _HomeScreenOverlayState();
}

class _HomeScreenOverlayState extends State<HomeScreenOverlay> {
  // a list for the toggle button selection
  final List<bool> _selections = List.generate(1, (_) => false);

  // variable to check the opening of search page
  bool _searchBoolean = false;
  
  // users default dataset
  List<User> Students = [
    User('Chan Saw Lin', 0152131113, DateTime.parse('2020-06-30 16:10:05')),
    User('Lee Saw Loy', 0161231346, DateTime.parse('2020-07-11 15:39:59')),
    User('Khaw Tong Lin', 0158398109, DateTime.parse('2020-08-19 11:10:18')),
    User('Lim Kok Lin', 0168279101, DateTime.parse('2020-08-19 11:11:35')),
    User('Low Jun Wei', 0112731912, DateTime.parse('2020-08-15 13:00:05')),
    User('Yong Weng Kai', 0172332743, DateTime.parse('2020-07-31 18:10:11')),
    User('Jayden Lee', 0191236439, DateTime.parse('2020-08-22 08:10:38')),
    User('Kong Kah Yan', 0111931233, DateTime.parse('2020-07-11 12:00:00')),
    User('Jasmine Lau', 0162879190, DateTime.parse('2020-08-01 12:10:05')),
    User('Chan Saw Lin', 016783239, DateTime.parse('2020-08-23 11:59:05')),
  ];

  // list to collect searches
  List<int> _searchIndexList = [];

  // widget to open the text field of search and add names to search list based on what user keys in
  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < Students.length; i++) {
            if (Students[i].name.contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  // widget to display the possible names in listview
  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(child: ListTile(title: Text(Students[index].name)));
        });
  }

  // widget to display the default home page content when the search icon is not pressed
  Widget _defaultListView() {

    var box2 = Hive.box('box2');
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        // padding for the toggle button
        Padding(
            padding: const EdgeInsets.all(9),
            child: ListTile(
                title: const Text("Change time format"),
                trailing: ToggleButtons(
                  isSelected: _selections,
                  onPressed: (int index) {
                    setState(() {
                      _selections[index] = !_selections[index];

                      // set the checked variable based on the button click
                      if (index == 0 && _selections[index]) {
                       setState(() {
                         box2.put("toggle", 1);
                       });

                      } else if (index == 0 && !_selections[index]) {
                        setState(() {
                          box2.put("toggle", 0);
                        });

                      }
                    });
                  },
                  color: Colors.lightGreen,
                  fillColor: Colors.green,
                  borderColor: Colors.transparent,
                  children: const <Widget>[Icon(Icons.access_time_filled, color: Colors.lightGreen,)],
                ))),

        // column for the user list view
        Column(
          // iterate through the users list
          children: Students.map((student) {
            return Padding(
              padding: const EdgeInsets.all(9),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  color: Colors.black87,

                  // inkwell is used to detect the users tap to see profile page
                  child: InkWell(
                      onTap: () {
                        // open profile page with the respective user info
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              // all was joined into a single string to split later
                              builder: (context) => ProfilePage(
                                text: '${student.name},${student.phone_number},${student.checking}',
                              ),
                            ));
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.lightGreen,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(student.name),

                                    const Spacer(),

                                    // share data functionality using icon on pressed
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {
                                        _onShareData(context,
                                            "${student.name}\n${student.phone_number}\n${student.checking}");
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.lightGreen,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(student.phone_number.toString())
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      color: Colors.lightGreen,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),

                                    // check the toggle button state to change the date format
                                      if(box2.get('toggle')==0 || box2.get('toggle')==null)
                                      Text((DateFormat('dd MMM yyyy, h:mm a')
                                              .format(student.checking))
                                          .toString())
                                      else if(box2.get('toggle')==1)
                                      Text(timeago.format(student.checking))
                                                            ],
                                ),
                              ])))),
            );
          }).toList(),
        ),

        // indicator for the end of the list
        Container(
            height: 50,
            width: double.infinity,
            color: Colors.green,
            child: const Center(
                child: Text('end of user list',
                    style: TextStyle(color: Colors.white))))
      ])),
    );
  }

  // function for sharing data
  _onShareData(BuildContext context, String txt) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(txt,
        subject: "User Information",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    // sorting the student list based on date
    Students.sort((a, b) => b.checking.compareTo(a.checking));

    return Scaffold(
        appBar: AppBar(
          // change appbar title based on page displayed
          title: !_searchBoolean
              ? const Text('Attendance App Home Page')
              : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  // search icon
                  IconButton(
                      icon: const Icon(Icons.search, color: Colors.lightGreen,),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                          _searchIndexList = [];
                        });
                      })
                ]
              : [
                  // clear icon
                  IconButton(
                      icon: const Icon(Icons.clear, color: Colors.lightGreen),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      })
                ],
        ),

        // floating button for adding new users
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.black,
            child: const Icon(Icons.person_add_alt_1),
            onPressed: () {
              _navigateAndDisplayInput(context);
            }),
        body: !_searchBoolean ? _defaultListView() : _searchListView());
  }

  // A method that launches the addUsersScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplayInput(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddUsersScreen()),
    );

    if (!mounted) {
      return;
    }

    // add the new user to the students list
    setState(() {
      var box2 = Hive.box('box2');
      String name = box2.get('name');
      int phone = int.parse(box2.get('phone'));
      DateTime dte = box2.get('date');
      Students.add(User(name, phone, dte));
      Students.sort((a, b) => b.checking.compareTo(a.checking));
      box2.delete('name');
      box2.delete('phone');
      box2.delete('date');
    });
  }
}
