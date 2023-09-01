import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location location = Location();
  LocationData? currentLocation;
  StreamSubscription<LocationData>? locationSubscription;
  WebViewController? _mapController;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });

    // 위치 업데이트 구독 시작
    locationSubscription =
        location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        currentLocation = newLocation;
      });

      if (_mapController != null) {
        _mapController!.runJavascript('''
          var newPosition = new kakao.maps.LatLng(${currentLocation!.latitude}, ${currentLocation!.longitude});

          if (typeof(_currentMarker) !== 'undefined') {
            _currentMarker.setMap(null);
          }

          var _marker = new kakao.maps.Marker({position: newPosition});
          _marker.setMap(map);
          _currentMarker = _marker;

          map.setCenter(newPosition);
        ''');
      }
    });
  }

  @override
  void dispose() {
    locationSubscription?.cancel(); // 위치 업데이트 구독 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Kakao map webview test')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: currentLocation != null
                ? KakaoMapView(
                    customScript: '',
                    mapController: (controller) {
                      _mapController = controller;
                    },
                    width: size.width,
                    height: 400,
                    kakaoMapKey: '7c065c0d47fef30d97032868e247b68f',
                    lat: currentLocation!.latitude!,
                    lng: currentLocation!.longitude!,
                    showMapTypeControl: true,
                    showZoomControl: true,
                  )
                : const CircularProgressIndicator(), // 또는 로딩 화면을 표시할 수 있음
          ),
          currentLocation != null
              ? Text('lat = ${currentLocation!.latitude}')
              : const CircularProgressIndicator(),
          currentLocation != null
              ? Text('lat = ${currentLocation!.longitude}')
              : const CircularProgressIndicator(),
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
