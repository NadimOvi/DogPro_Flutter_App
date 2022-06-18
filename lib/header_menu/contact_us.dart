import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
        backgroundColor: Color(0xff233f4b),
      ),
      body: Container(
        color: Color(0xff233f4b),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://genofax.com/contact",
        ),
      ),

    );
  }
}
