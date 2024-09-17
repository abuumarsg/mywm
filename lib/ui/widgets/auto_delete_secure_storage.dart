import 'dart:async';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../../models/login_form_model.dart';
// import '../../services/auth_service.dart';

class AutoDeleteSecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Timer? _deleteTimer;
  DateTime _lastInteractionTime = DateTime.now();
  late VoidCallback onTimeout;

  AutoDeleteSecureStorage({required this.onTimeout}) {
    // Start a timer to check for inactivity and delete data if necessary
    _startTimer();
  }

  // Save data with a timestamp
  Future<void> saveData(String key, String value) async {
    await _secureStorage.write(
      key: key,
      value: '$value-${DateTime.now().millisecondsSinceEpoch}',
    );
    // Record the interaction time when data is saved
    _lastInteractionTime = DateTime.now();
  }

  // Retrieve data and delete if it's older than the specified duration
  Future<String?> getData(String key, Duration maxInactivityDuration) async {
    String? storedData = await _secureStorage.read(key: key);

    // Check and delete data if it's older than the specified duration
    if (storedData != null) {
      List<String> parts = storedData.split('-');
      if (parts.length == 2) {
        int timestamp = int.tryParse(parts[1]) ?? 0;
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        if (currentTime - timestamp > maxInactivityDuration.inMilliseconds) {
          // Data is older than the specified duration, delete it
          // await _secureStorage.delete(key: key);
          print('Data dihapus: $key');
          onTimeout(); 
          return null;
        }
      }
    }
    _lastInteractionTime = DateTime.now();
    return storedData;
  }

  // Start a timer to periodically check for inactivity and delete data
  void _startTimer() {
    const checkInterval = Duration(minutes: 1);
    _deleteTimer = Timer.periodic(checkInterval, (timer) {
      // Check if there has been no interaction for a certain duration
      Duration inactivityDuration = DateTime.now().difference(_lastInteractionTime);
      print('Durasi tidak aktif: $inactivityDuration');
      if (inactivityDuration >= checkInterval) {
        // _deleteOldData();
      }
    });
  }

  Future<void> _deleteOldData() async {
    // final SignInFormModel data = await AuthServices().getCredentialFromLocal();
    // await AuthServices().logout(data);
    print('Menghapus data lama...');
    // await _secureStorage.delete(key: 'session');
    // await _secureStorage.deleteAll();
    print('Data lama dihapus.');
    onTimeout();
  }

  // Dispose the timer when the object is no longer needed
  void dispose() {
    _deleteTimer?.cancel();
  }
}
