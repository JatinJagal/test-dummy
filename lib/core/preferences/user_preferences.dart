import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_projectt/core/preferences/session_keys.dart';

class AppSession {
  static GetStorage? sessionData;
  static GetStorage? introScreenData;

  static void init() {
    introScreenData = GetStorage();
    sessionData = GetStorage();
  }

  static void setAccessToken(String? value) {
    sessionData!.write(UserSessionDetail.kAccessToken, value);
  }

  static String getAccessToken() {
    return sessionData?.read(UserSessionDetail.kAccessToken) ?? "";
  }

  static void setFcmToken(String? value) {
    sessionData!.write(UserSessionDetail.fcmToken, value);
  }

  static String getFcmToken() {
    return sessionData?.read(UserSessionDetail.fcmToken) ?? "";
  }

  static Future<void> clearStorage() async {
    Get.offAllNamed("/login");
    sessionData!.erase();
    init();
    // InfrasyncRepository.init();
  }
}
