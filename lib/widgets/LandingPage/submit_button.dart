import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/responsive_layout.dart';

class Btn extends StatelessWidget {
  final Function() onTap;
  final bool isEnableIcon;
  final String title;
  Btn({required this.onTap, required this.isEnableIcon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            AppColors.greenColor,
            AppColors.blueColor,
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: const Offset(0.0, 8.0), blurRadius: 8.0)]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
              child: isEnableIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(Strings.notify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveLayout.isSmallScreen(context)
                                    ? 12
                                    : ResponsiveLayout.isMediumScreen(context)
                                        ? 12
                                        : 16,
                                letterSpacing: 1.0)),
                        SizedBox(
                          width: ResponsiveLayout.isSmallScreen(context)
                              ? 4
                              : ResponsiveLayout.isMediumScreen(context)
                                  ? 6
                                  : 8,
                        ),
                        Icon(
                          Icons.send,
                          color: Colors.white,
                          size: ResponsiveLayout.isSmallScreen(context)
                              ? 12
                              : ResponsiveLayout.isMediumScreen(context)
                                  ? 12
                                  : 20,
                        )
                      ],
                    )
                  : Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveLayout.isSmallScreen(context)
                              ? 12
                              : ResponsiveLayout.isMediumScreen(context)
                                  ? 12
                                  : 16,
                          letterSpacing: 1.0))),
        ),
      ),
    );
  }
}
