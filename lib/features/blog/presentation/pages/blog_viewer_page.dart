import 'package:flutter/material.dart';

class BlogViewerPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const BlogViewerPage());
  const BlogViewerPage({super.key});

  @override
  State<BlogViewerPage> createState() => _BlogViewerPageState();
}

class _BlogViewerPageState extends State<BlogViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [Text("hello")],
      ),
    );
  }
}
