import 'package:app/core/widgets/atoms/app_bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewPage extends StatelessWidget {
  final String url;
  final String title;

  const AppWebViewPage(
      {Key? key, required this.url, this.title = 'NRNA Browser'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: title),
      body: WebView(
        initialUrl: url,
        backgroundColor: Colors.white,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: false,
      ),
    );
  }
}
