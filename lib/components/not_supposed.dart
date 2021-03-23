import 'package:flutter/material.dart';

class NotSupposedTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        print(snapshot.data);

        return Container(
          child: Text("${snapshot.data}"),
        );
      },
      future: getSMS(),
    );
  }

  Future<int> getSMS() async {
    // var sms = new SmsQuery();
    // var smses = await sms.getAllThreads;

    // return smses.length;
  }
}
