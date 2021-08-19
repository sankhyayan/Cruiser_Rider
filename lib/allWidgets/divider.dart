import 'package:flutter/material.dart';
class DividerWidget extends StatelessWidget {
  final double defaultSize;
  DividerWidget({required this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 3,
      color: Colors.black45,
      thickness: 0.52,
    );
  }
}
