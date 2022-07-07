import 'package:devroninsemployees/constants/images.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:flutter/material.dart';

import 'search.dart';

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: .6,
            child: Image.asset(Images.devRoninsBg, scale: .85),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .6,
            child: Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(Strings.hello, style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                  RichText(
                    text: const TextSpan(text: Strings.welcomeTo, style: TextStyle(fontSize: 60, color: Color(0xFF8591B0)), children: [
                      TextSpan(text: Strings.appName, style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black87))
                    ]),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 20),
                    child: Text(Strings.letsExplore),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Search()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
