import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  String id ;
   ChatScreen({super.key , required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text('Chat Screen ${widget.id}'),),
    );
  }
}