import 'package:flutter/material.dart';
import 'package:er_front/api/kakaonavi_api.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 화면'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                KakaoNaviApi.init('088c012b4f8b5229d733155271d85e6b',
                    '7c065c0d47fef30d97032868e247b68f');
                KakaoNaviApi.navi('카카오 판교오피스', '127.108640', '37.402111');
              },
              child: const Text('응급실 예약'),
            ),
          ],
        ),
      ),
    );
  }
}
