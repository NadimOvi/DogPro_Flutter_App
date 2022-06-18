import 'package:flutter/material.dart';

class ShareApp extends StatelessWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share App'),
        centerTitle: true,
        backgroundColor: Color(0xff233f4b),
      ),
      body: Container(
        color: Color(0xff233f4b),
        child: Center(
          child: Text("Share App Screen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              )),
        ),
      ),

    );
  }
}
