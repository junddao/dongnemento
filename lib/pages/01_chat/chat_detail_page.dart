import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key, required this.id});
  final String id;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChatDetailPageView(id: widget.id);
  }
}

class ChatDetailPageView extends StatefulWidget {
  const ChatDetailPageView({super.key, required this.id});
  final String id;

  @override
  State<ChatDetailPageView> createState() => _ChatDetailPageViewState();
}

class _ChatDetailPageViewState extends State<ChatDetailPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Text('chat detail page : ${widget.id}'),
    );
  }
}
