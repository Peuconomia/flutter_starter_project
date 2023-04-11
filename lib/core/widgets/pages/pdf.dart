import 'package:app/core/widgets/atoms/app_bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AppPDFViewPage extends StatelessWidget {
  final String url;
  final String title;

  const AppPDFViewPage(
      {Key? key, required this.url, this.title = 'NRNA PDF Reader'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: title),
      body: SfPdfViewer.network(
        url,
      ),
    );
  }
}
