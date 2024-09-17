import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myWM/ui/pages/need_username.dart';
import '../../shared/share_values.dart';
import '../pages/main/home.dart';
import '../pages/main/rekening.dart';
// import '../pages/notifikasi_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/pendaftaran_akun_kelengkapan.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  static Future<void> redirectToYourTimeoutPage() async {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const OnBoardingPage()),
    );
    // final SignInFormModel data = await AuthServices().getCredentialFromLocal();
    // await AuthServices().logout(data);
    EasyLoading.dismiss();
  }
  static Future<void> redirectToRekeningPage() async {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const RekeningPage()),
    );
  }
  static Future<void> redirectToNeedUsername() async {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const NeedUsernamePage()),
    );
  }
  static Future<void> redirectToBeranda() async {
    EasyLoading.dismiss();
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'session');
    await storage.write(key: 'session', value: futureDate.toString());
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
  static Future<void> redirectToPendaftaranAkunKelengkapan(datax) async {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => PendaftaranAkunKelengkapan(dataKelengkapan: datax)),
    );
  }
}