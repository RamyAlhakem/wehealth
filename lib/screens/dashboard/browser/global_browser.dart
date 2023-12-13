import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef UrlCallback = void Function(String url, WebViewController controller);

class GlobalBrowser extends StatefulWidget {
  const GlobalBrowser(
      {Key? key, required this.url, this.onPageFinished, this.onPageStarted})
      : super(key: key);
  final String url;
  final UrlCallback? onPageFinished;
  final UrlCallback? onPageStarted;

  @override
  State<GlobalBrowser> createState() => _GlobalBrowserState();
}

class _GlobalBrowserState extends State<GlobalBrowser> {
  late WebViewController controller;
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
              log(widget.url);
              if (widget.onPageStarted != null) {
                widget.onPageFinished!(url, controller);
              }
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
                log(progress.toString());
              });
            },
            onPageFinished: (url) => (url) {
              // here i will run the javascript code to perform something like scrapping and automation
              log(widget.url);
              setState(() {
                loadingPercentage = 100;
              });
              if (widget.onPageFinished != null) {
                widget.onPageFinished!(url, controller);
              }
            },
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              minHeight: 2.5,
            ),
        ],
      ),
    );
  }
}
