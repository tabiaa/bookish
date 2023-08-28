import 'package:flutter/material.dart';
import 'package:flutter_app/screens/books_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';

class ReusableDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff795C4B),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Bookish Haven',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome to Bookish haven',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Color(0xff795C4B),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Color(0xff795C4B),
                fontSize: 16,
              ),
            ),
            onTap: () {
               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BooksScreen()));
            },
          ),
         
          Divider(
            color: Colors.white30,
            height: 20,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Color(0xff795C4B),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Color(0xff795C4B),
                fontSize: 16,
              ),
            ),
            onTap: () {
                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
