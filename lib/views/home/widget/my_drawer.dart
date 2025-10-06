import 'package:english_learning/helper/widget/alerts.dart';
import 'package:english_learning/helper/widget/neu_box_image.dart';
import 'package:english_learning/views/about/about_screen.dart';
import 'package:english_learning/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../setting/settings_view.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  NeuBoxImage(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/about_image.jpg'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style:  TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: const Text('S E T T I N G S'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: const Text('A B O U T'),
              leading: const Icon(Icons.perm_device_info),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min, // Makes it wrap the content height
                      children: [
                        AboutScreen(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                // add a confirmation dialog
                Alerts().confirmationAlert(
                    context: context,
                    title: 'Are you sure?',
                    buttonText: 'Logout',
                    description: 'Do you want to logout?',
                    onConfirm: () async {
                      // user logout
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(context, LoginView.route(), (route) => false);
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                      }
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
