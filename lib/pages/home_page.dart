import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text('Homepage'),
          ),
          ElevatedButton(
              onPressed: () {
                AuthController.instance.logout();
              },
              child: Text('Log'))
        ],
      ),
    );
  }
}
