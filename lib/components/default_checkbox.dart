import 'package:flutter/material.dart';

class CrodlCheckBox extends StatelessWidget {
  const CrodlCheckBox({
    Key key,
    this.labelText,
    this.onCheck,
    this.value
  }) : super(key: key);
  final String labelText;
  final Function onCheck;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onCheck),
        SizedBox(width: 10,),
        Container(
          child: Text(labelText, style: TextStyle(fontSize: 20,), softWrap: true,),
        )
      ],
    );
  }
}