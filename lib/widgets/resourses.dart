import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {required this.text,
      required this.textColor,
      required this.fontSize,
      required this.fontWeight});

  final String text;
  final Color textColor;

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.textInputType,
    this.focusNodeCurrent,
    this.focusNodeNext,
    this.suffixIcon,
    required this.functionValidate,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?) functionValidate;
  final TextInputType textInputType;
  final FocusNode? focusNodeCurrent;
  final FocusNode? focusNodeNext;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: functionValidate,
      focusNode: focusNodeCurrent,
      keyboardType: textInputType,
      obscureText: obscureText,
      onFieldSubmitted: (value) {
        focusNodeCurrent?.unfocus();
        FocusScope.of(context).autofocus(focusNodeNext!);
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffix: suffixIcon,
        hintStyle: const TextStyle(fontSize: 14, fontStyle: FontStyle.normal),
        enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xFF707070), width: 1)),
        focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xFFff8dbb55), width: 1)),
        errorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}

class SideBarMenuItems {
  String title;
  IconData icon;
  String route;

  SideBarMenuItems(
      {required this.title, required this.icon, required this.route});
}

class TextButtonWidget extends StatelessWidget {
  TextButtonWidget({Key? key, required this.text, required this.route})
      : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: Text(text));
  }
}
