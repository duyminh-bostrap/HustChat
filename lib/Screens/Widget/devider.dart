import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: size.height * 0.04,
      thickness: 3,
      indent: 30,
      endIndent: 30,
      color: Color(0xffff8a84),
    );
  }
}