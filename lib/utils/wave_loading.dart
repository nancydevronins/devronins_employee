import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/colors.dart';

class WaveLoading extends StatelessWidget {
  const WaveLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitWave(
      color: AppColors.blueColor,
      size: 50.0,
    );
  }
}
