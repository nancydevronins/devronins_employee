import 'package:devroninsemployees/widgets/LandingPage/body_landing_page.dart';
import 'package:flutter/material.dart';

import '../widgets/LandingPage/navbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFF8FBFF),
        Color(0xFFFCFDFD),
      ])),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(), BodyLandingPage()],
          ),
        ),
      ),
    );
  }
}
