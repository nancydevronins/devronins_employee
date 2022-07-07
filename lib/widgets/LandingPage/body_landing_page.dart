import 'package:devroninsemployees/widgets/LandingPage/large_child.dart';
import 'package:devroninsemployees/widgets/LandingPage/small_child.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive_layout.dart';

class BodyLandingPage extends StatelessWidget {
  const BodyLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(),
      smallScreen: SmallChild(),
    );
  }
}
