import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TopicPdfViewer extends StatefulWidget {
  const TopicPdfViewer({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<TopicPdfViewer> createState() => _TopicPdfViewerState();
}

class _TopicPdfViewerState extends State<TopicPdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 20,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ),
      body: Center(
        child: SfPdfViewer.network(
          widget.url,
          canShowScrollHead: false,
          canShowScrollStatus: false,
        ),
      ),
    );
  }
}
