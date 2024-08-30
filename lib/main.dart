import 'package:flutter/material.dart';
import 'package:webview/src/navigation_controls.dart';
import 'package:webview/src/web_view_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'src/menu.dart'; 

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true
    ),
    home: const WebViewApp(),
  ));
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
    ..loadRequest(Uri.parse('https://flutter.dev'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        actions: [
          NavigationControls(controller: controller),
          Menu(controller: controller),
        ],
      ),
      body:  WebViewStack(controller: controller,),
    );
  }
}