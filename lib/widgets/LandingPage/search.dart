import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/widgets/LandingPage/send_button.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive_layout.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.0,
        right: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
        top: 10,
        bottom: 40,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(
                  flex: 8,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none, hintText: Strings.yourEmailAddress),
                  )),
              Expanded(
                flex: 2,
                child: SendBtn(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
