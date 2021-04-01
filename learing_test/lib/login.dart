import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pswController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    icon: Icon(Icons.person)),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pswController,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登陆密码",
                    icon: Icon(Icons.lock)),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : " 密码不能为少于6为";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      child: Text("登录"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          //跳转
                          var _email = _nameController.text;
                          var _password = _pswController.text;
                          print('Email:$_email , Password:$_password');
                          loadDataByDio();
                          // Navigator.pushNamed(context, 'index');
                        }
                      },
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadDataByDio() async {
    try {
      Response response;
      Dio dio = new Dio();
      response =
          await dio.post("http://10.8.51.45:3050/api/pc/v1/users/login", data: {
        "email": _nameController.text,
        "password": _pswController.text,
      });

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, 'index');
      } else {
        Navigator.pushNamed(context, '/');
      }
    } catch (exception) {
      print('exc:$exception');
    }
    setState(() {});
  }
}
