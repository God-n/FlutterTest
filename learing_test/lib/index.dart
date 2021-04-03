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
        body: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, "course");
            },
            child: Center(
              child: Text(
                "我的课程",
                style: TextStyle(color: Colors.blue),
              ),
            )));
  }
}
