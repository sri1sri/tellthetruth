import 'dart:io' show Platform;
import 'package:firebase_admob/firebase_admob.dart';



MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['games'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd createBannerAd() {
  return BannerAd(
    adUnitId: getBannerAdUnitId(),
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event $event");
    },
  );
}

String getAppId() {
  if (Platform.isIOS) {
    return IOS_APP_ID;
  } else if (Platform.isAndroid) {
    return ANDROID_APP_ID;
  }
  return null;
}
String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return IOS_AD_UNIT_BANNER;
  } else if (Platform.isAndroid) {
    return ANDROID_AD_UNIT_BANNER;
  }
  return null;
}

String IOS_APP_ID = 'ca-app-pub-9543395526409232~1075008136';
String ANDROID_APP_ID = 'ca-app-pub-9543395526409232~7748868325';

String IOS_AD_UNIT_BANNER = 'ca-app-pub-9543395526409232/1973797468';
String ANDROID_AD_UNIT_BANNER = 'ca-app-pub-9543395526409232/9656205735';
