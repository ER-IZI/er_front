import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    String id = idController.text;
    String password = passwordController.text;

    // 실제 서버 URL로 변경
    String local = 'http://localhost:5000/login';
    String emulator = 'http://10.0.2.2:5000/login';
    String device = 'http://192.168.144.213:5000/login';

    String url = device;
    Map<String, String> data = {'id': id, 'password': password};

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // print('로그인 성공');
        var jsonResponse = jsonDecode(response.body);
        var token = jsonResponse['access_token'];
        if (context.mounted) {
          Navigator.pushNamed(context, '/detail_screen');
        }
      } else {
        // print('로그인 실패');
      }
    } catch (error) {
      print('에러 발생: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인 화면'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text('로그인'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/join_screen');
                  },
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
