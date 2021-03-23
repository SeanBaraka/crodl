import 'package:flutter/material.dart';

class CrodlLoaderComponent extends StatelessWidget {
  const CrodlLoaderComponent({
    Key key,
    this.height,
    @required this.invalideKeysError,
  }) : super(key: key);

  final String invalideKeysError;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: Colors.white54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading... Please Wait",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 50,
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
