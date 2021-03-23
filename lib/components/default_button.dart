import 'package:crodl/constants/colors.dart';
import 'package:flutter/material.dart';

class CrodlDefaultButton extends StatelessWidget {
  const CrodlDefaultButton({Key key, this.text, this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;



  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            primary: primaryColor,
            onPrimary: darkColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
