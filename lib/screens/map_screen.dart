import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Kakao map webview test')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KakaoMapView(
            width: size.width,
            height: 400,
            kakaoMapKey: '7c065c0d47fef30d97032868e247b68f',
            lat: 33.450701,
            lng: 126.570667,
            showMapTypeControl: true,
            showZoomControl: true,
            markerImageURL:
                'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
            onTapMarker: (message) async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Marker is clicked'),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('주변 응급실 추가 탐색'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reservation_screen');
                  },
                  child: const Text('병원 예약'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
