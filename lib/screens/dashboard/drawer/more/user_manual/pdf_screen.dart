import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
/* import 'package:pdfx/pdfx.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({
    Key? key,
    required this.path,
  }) : super(key: key);
  final String path;
  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  //late PdfControllerPinch _controller;
  @override
  void initState() {
    super.initState();
    // _controller =
    //     PdfControllerPinch(document: PdfDocument.openAsset(widget.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     // body: PdfViewPinch(controller: _controller),
    );
  }
} */

class PdfScreen extends StatefulWidget {
  const PdfScreen({
    Key? key,
    required this.file,
  }) : super(key: key);
  final File file;
  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  // late PdfControllerPinch _controller;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  @override
  void initState() {
    super.initState();
    // _controller =
    //     PdfControllerPinch(document: PdfDocument.openAsset(widget.path));
  }

    int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    print(widget.file);
    return Scaffold(
      backgroundColor: Colors.black,
      body: PDFView(
        filePath: widget.file.path,

        // filePath: widget.path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
        pageSnap: true,
        defaultPage: currentPage!,
        fitPolicy: FitPolicy.BOTH,
        onViewCreated: (controller) {
          _controller.complete(controller);
        },
        onError: (error) {
          log("pdfViewError", error: error);
        },
      ) /* PdfViewPinch(controller: _controller) */,
    );
  }
}
