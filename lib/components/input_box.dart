import 'package:crodl/constants/colors.dart';
import 'package:flutter/material.dart';

class CrodlInputBox extends StatelessWidget {
  const CrodlInputBox(
      {Key key,
      this.hintText,
      this.labelText,
      this.secureText,
      this.readOnly,
      this.controller})
      : super(key: key);
  final String hintText;
  final String labelText;
  final bool secureText;
  final bool readOnly;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              labelText,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: readOnly != null ? inputReadOnlyColor : bgColor,
                  border: Border.all(color: lightGreyColor, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      readOnly: readOnly != null ? readOnly : false,
                      controller: controller,
                      obscureText: secureText,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                          hintText: hintText)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
