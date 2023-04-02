import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // string to get the data from the navigator push
  final String text;

  // receive data from the otherScreen as a parameter
  const ProfilePage({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    // list for user info
    List user = text.split(',');
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: Text(user[0]),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: Text(user[1]),
            ),
            ListTile(
              leading: const Icon(Icons.date_range, color: Colors.green),
              title: Text(user[2]),
            ),
          ],
        ));
  }
}
