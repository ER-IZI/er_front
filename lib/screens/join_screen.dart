import 'package:flutter/material.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 화면'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/patient_join_screen');
                  },
                  child: const Text('환자'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/hospital_join_screen');
                  },
                  child: const Text('병원'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
