import 'package:flutter/material.dart';

class DashBoardDrawer extends StatelessWidget {
  const DashBoardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(decoration: BoxDecoration(color: Colors.blue), child: Text('Header')),
          ListTile(
            title: Text('Home'),
          ),
          ListTile(
            title: Text('Settings'),
          )
        ],
      ),
    );
  }
}
