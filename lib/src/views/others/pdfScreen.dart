import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});
  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String? pdfPath;
  File? file;
  @override
  void initState() {
    setState(() {
      pdfPath = Get.arguments[0];
      file = Get.arguments[1];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slip'),
        actions: [
          IconButton(
              onPressed: () {
                Share.shareXFiles([
                  XFile.fromData(
                    file!.readAsBytesSync(),
                    mimeType: 'application/pdf',
                    name: '$pdfPath.pdf',
                  )
                ]);
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
