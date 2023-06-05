import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const ChatPageView();
  }
}

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      centerTitle: false,
      title: const Text('채팅'),
    );
  }

  Widget _body() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // context.replaceNamed('chatDetailPage', params: {'index': '1', 'id': 'aaaa'});

          context.go(
            '/chat/details/aaaa',
          );
        },
        child: const Text('채팅채팅'),
      ),
    );
  }
}
