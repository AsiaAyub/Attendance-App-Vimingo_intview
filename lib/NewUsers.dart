import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// screen for adding new users
class AddUsersScreen extends StatefulWidget {
  const AddUsersScreen({super.key});

  @override
  State<AddUsersScreen> createState() => _AddUsersScreenState();
}

class _AddUsersScreenState extends State<AddUsersScreen> {
  // initialise all text controller for text-fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    nameController.text = ""; //set the initial value of text field
    phoneController.text = ""; //set the initial value of text field
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New User Information'),
      ),
      body:SingleChildScrollView(
        child:
          Container(
            height: 450,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(25, 70, 25, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black87,
            ),

            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(17),
                  child: Text(
                    'Add New User',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.lightGreen),
                          ),
                          labelText: 'name',
                          labelStyle: TextStyle(color: Colors.lightGreen),
                          hintText: 'Enter user Name'),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.lightGreen),
                          ),
                          labelText: 'phone Number',
                          labelStyle: TextStyle(color: Colors.lightGreen),
                          hintText: 'Enter User Phone Number'),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.lightGreen),
                          ),
                          labelText: 'checking Date',
                          labelStyle: TextStyle(color: Colors.lightGreen),

                        ),
                        readOnly:
                        true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          // take the date from the calender
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(pickedDate);
                            setState(() {
                              dateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        })),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen, // Background color
                    ),
                    onPressed: () {
                      // on press add data to the hive box to retrieve it later
                      var box2 = Hive.box('box2');
                      box2.put('name', nameController.text);
                      box2.put('phone', phoneController.text);
                      box2.put('date', DateTime.parse(dateController.text));

                      // Close the screen.
                      Navigator.pop(context, []);
                      showDialog(
                        context: context,

                        // alert dialog box to show feedback to the user on successful addition
                        builder: (cxt) => AlertDialog(
                          title: const Text('Alert message'),
                          content: const Text('successfully added a new user'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(cxt).pop();
                                },
                                child: const Text('ok'))
                          ],
                        ),
                      );
                    },
                    child: const Text('add to user list'),
                  ),
                )

              ],
            )
            ,)
        ,
      )

      ,

    );
  }
}
