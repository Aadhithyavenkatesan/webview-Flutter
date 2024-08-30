import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,
  javascriptChannel,
}

class Menu extends StatefulWidget {
  const Menu({ required this.controller, super.key});

  final WebViewController controller;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (value) async{
        switch (value) {
          case _MenuOptions.navigationDelegate:
            await widget.controller.loadRequest(Uri.parse('https://youtube.com'));
          case _MenuOptions.userAgent:
            final userAgent = await widget.controller
            .runJavaScriptReturningResult('Navigator .userAgent');
            if(!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$userAgent')));
            case _MenuOptions.javascriptChannel:
              await widget.controller.runJavaScript('''
var req = new XMLHttpRequest();
req.open('GET' , "https://api.ipifg.org/?format=json");
req.onload = function(){
  if(req.status == 200){
  let response = JSON.parse(req.response.ip);
  SnackBar.postMessage("IP Address: " + response.ip);
  }else{
  SnackBar.postMessage("Error: " + req.status);}
}''');
            
          
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text('Navigate to YouTube')),
          const PopupMenuItem<_MenuOptions>(                
          value: _MenuOptions.userAgent,
          child: Text('Show user-agent'),
        ),    
        const PopupMenuItem<_MenuOptions>(                
          value: _MenuOptions.javascriptChannel,
          child: Text('Lookup IP Address'),
        ), 
      ],
    );
  }
}