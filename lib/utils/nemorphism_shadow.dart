import 'package:flutter/material.dart';

class NeomorphismShape {
  static List<BoxShadow> boxShape = [
    BoxShadow(
      color: Colors.white.withOpacity(0.8),
      offset: Offset(-6.0, -6.0),
      blurRadius: 16.0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: Offset(6.0, 6.0),
      blurRadius: 16.0,
    ),
  ];
}
