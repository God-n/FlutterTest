import 'package:flutter/material.dart';

class index extends StatefulWidget {
  @override
  _indexState createState() => _indexState();
}

class _indexState extends State<index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("index"),
      ),
      body: Center(
        child: Text("登录成功"),
      ),
    );
  }
}
