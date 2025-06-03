import 'package:flutter/material.dart';
import 'package:fe_hotel/Authentication/auth.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 187, 99, 146),
        elevation: 0.0,
        title: Text('Đăng nhập vào ')
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(onPressed: () async {
          dynamic result = await _auth.signInAnon();
          if (result == null){
            print('ERROR LOGINING IN');
          }
          else
          {
            print('LOGIN SUCCESSFULLY!');
            print(result);
          }
        }, child: Text('Login'))
      ),
    );
  }
}