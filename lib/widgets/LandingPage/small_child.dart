import 'package:flutter/material.dart';

import '../../constants/images.dart';
import '../../constants/strings.dart';
import 'search.dart';

class SmallChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              Strings.hello,
              style: TextStyle(
                fontSize: 40,
                color: Color(0xFF8591B0),
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              text: const TextSpan(
                text: Strings.welcomeTo,
                style: TextStyle(fontSize: 40, color: Color(0xFF8591B0)),
                children: <TextSpan>[
                  TextSpan(text: Strings.appName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black87)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 20),
              child: Text(Strings.letsExplore),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(child: Image.asset(Images.devRoninsBg, scale: .85)),
            const SizedBox(
              height: 32,
            ),
            Search(),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
