// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewFlutter extends StatefulWidget {
//   String title;
//   String url;
//   WebViewFlutter({Key? key, required this.title, required this.url}) : super(key: key);
//
//   @override
//   WebViewFlutterState createState() => WebViewFlutterState();
// }
//
// class WebViewFlutterState extends State<WebViewFlutter> {
//   @override
//   void initState() {
//     super.initState();
//     print("webview Url");
//     print(widget.url);
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: WebView(
//         initialUrl:widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }