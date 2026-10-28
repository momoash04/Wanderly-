import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DestinationWebScreen extends StatefulWidget {
  final String destinationName;

  const DestinationWebScreen({
    super.key,
    required this.destinationName,
  });

  @override
  State<DestinationWebScreen> createState() => _DestinationWebScreenState();
}

class _DestinationWebScreenState extends State<DestinationWebScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final url =
        'https://en.wikipedia.org/wiki/${Uri.encodeComponent(widget.destinationName)}';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destinationName),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
