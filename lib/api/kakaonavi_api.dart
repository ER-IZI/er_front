import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_navi/kakao_flutter_sdk_navi.dart';

class KakaoNaviApi {
  static init(String nativeAppKey, String javaScriptAppKey) {
    WidgetsFlutterBinding.ensureInitialized();
    KakaoSdk.init(
      nativeAppKey: nativeAppKey,
      javaScriptAppKey: javaScriptAppKey,
    );
  }

  static navi(String name, String x, String y) async {
    if (await NaviApi.instance.isKakaoNaviInstalled()) {
      // 카카오내비 앱으로 길 안내하기, WGS84 좌표계 사용
      await NaviApi.instance.navigate(
        option: NaviOption(coordType: CoordType.wgs84),
        destination: Location(name: name, x: x, y: y),
      );
    } else {
      // 카카오내비 설치 페이지로 이동
      launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
    }
  }
}
