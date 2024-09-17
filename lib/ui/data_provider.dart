import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class APIPusat {
  final String dataUrl;
  APIPusat(this.dataUrl);
}
class VersionAPK {
  final String versi;
  final bool responseReturn;
  final bool maintenanceAPK;
  final String ketMaintenance;
  VersionAPK(this.versi, this.responseReturn, this.maintenanceAPK, this.ketMaintenance);
}
String versionAPK = '2.0.1';
String numberRevisi = '21';
String userIDWm = '@dminT51@abu:m4573rv1r7u0zz0';
String idUserWm = '@dminT51@abu';
DateTime dateNowWm = DateTime.now();
String encodedStringWm = base64.encode(utf8.encode(userIDWm));
String formattedDateWm = DateFormat('yyyyMMddHH').format(dateNowWm);
String accessApiWm = 'access-api-wm$formattedDateWm';
String sha1HashWm = sha1.convert(utf8.encode(accessApiWm)).toString();
String md5HashWm = md5.convert(utf8.encode(sha1HashWm+idUserWm)).toString();
String dataURL = '';

class DataProvider {
  var logger = Logger();
  static final DataProvider _instance = DataProvider._internal();
  factory DataProvider() {
    return _instance;
  }
  DataProvider._internal() {
    fetchData();
    cekVersionAPK();
  }
  APIPusat? _data;
  APIPusat? get dataUrl => _data;
  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('https://klikwm.id/api-wm/develop-mobile/get_url'),
        body: {"token":'aawer234235rawfsad'},
      );
      // logger.i(response.statusCode);
      // logger.i(jsonDecode(response.body));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        String fetchedData = jsonData['data'];
        dataURL = jsonData['data'];
        await Future.delayed(Duration(seconds: 2));
        _data = APIPusat(fetchedData);
      } else {
        throw Exception('Gagal mengambil data URL dari API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  VersionAPK? _dataVersi;
  VersionAPK? get dataVERSI => _dataVersi;
  Future<void> cekVersionAPK() async {
    try {
      final response = await http.post(
        Uri.parse(
          '$dataURL/api-wm/proses/cek_version_apk',
        ),
        body: {"version":versionAPK, "numberRevisi":numberRevisi},
        headers: {
          'Authorization': 'Basic $encodedStringWm',
          'X-Wm-Signature': md5HashWm,
        }
      );
      if (response.statusCode == 200) {
        String versi = json.decode(response.body)['version'];
        bool responseReturn = json.decode(response.body)['data'];
        bool maintenanceAPK = json.decode(response.body)['maintenance'];
        String ketMaintenance = json.decode(response.body)['ketMaintenance'];
        _dataVersi = VersionAPK(versi, responseReturn, maintenanceAPK, ketMaintenance);
      } else {
        throw Exception('Gagal mengambil data URL dari API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}