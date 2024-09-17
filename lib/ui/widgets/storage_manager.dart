import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../../shared/share_values.dart';
import 'auto_delete_secure_storage.dart';
import 'navigator_without_context.dart';

AutoDeleteSecureStorage autoDeleteStorage = AutoDeleteSecureStorage(
  onTimeout: () async {
    // const storage = FlutterSecureStorage();
    // await storage.delete(key: 'session');
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.clear, 
    );
    NavigationService.redirectToYourTimeoutPage();
  },
);
// ignore: unused_element
void holdSession(time) async {
  // final timex = (time == '') ? 1 : time;
  // await autoDeleteStorage.saveData("session", "your_value");
  // String? data = await autoDeleteStorage.getData("session", Duration(minutes: timex));
  // print('session $data');
}
void setSession() async {
  // await autoDeleteStorage.saveData("session", formattedDateWm);
  // print('session $formattedDateWm');
}