import 'package:crodl/constants/colors.dart';
import 'package:flutter/material.dart';

class CrodlLinkLabel extends StatelessWidget {
  const CrodlLinkLabel({Key key, this.labelText, this.linkText, this.onPressed})
      : super(key: key);
  final String labelText, linkText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 20),
          ),
          TextButton(
              onPressed: onPressed,
              child: Text(linkText,
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }
}
