import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class MenuDrawer extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> logout() async {
    FirebaseUser user = auth.signOut() as FirebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: null,
            accountName: null,
            accountEmail: null,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage("assets/image/drawerbg.jpg"),
                  fit: BoxFit.fill),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onTap: () => Navigator.pop(context),
            title: Text('Home'),
          ),

          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text('Login'),
            onTap: () {
              logout();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),

          //Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
