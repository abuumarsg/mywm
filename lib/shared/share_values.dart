import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:myWM/shared/global_data.dart';
import 'package:logger/logger.dart';
import '../service_locator.dart';
import '../ui/data_provider.dart';

final dataProvider = getIt.get<DataProvider>();
final dataURLAPI = dataProvider.dataUrl?.dataUrl ?? 'http://b8d00cafa2ab.sn.mynetname.net:8751';
String versionAPKOLD = '1.0.3';
String numberRevisi = '2';
String baseUrlWm = '$dataURLAPI/api-wm/proses';
String userIDWm = '@dminT51@abu:m4573rv1r7u0zz0';
String idUserWm = '@dminT51@abu';
DateTime dateNowWm = DateTime.now();
String encodedStringWm = base64.encode(utf8.encode(userIDWm));
String formattedDateWm = DateFormat('yyyyMMddHH').format(dateNowWm);
String accessApiWm = 'access-api-wm$formattedDateWm';
String sha1HashWm = sha1.convert(utf8.encode(accessApiWm)).toString();
String md5HashWm = md5.convert(utf8.encode(sha1HashWm+idUserWm)).toString();
DateTime futureDate = dateNowWm.add(Duration(minutes: 1));

var logger = Logger();

void refreshDateNowWm() {
  print('refreshDateNowWm === OK');
  dateNowWm = DateTime.now();
  formattedDateWm = DateFormat('yyyyMMddHH').format(dateNowWm);
  accessApiWm = 'access-api-wm$formattedDateWm';
  sha1HashWm = sha1.convert(utf8.encode(accessApiWm)).toString();
  md5HashWm = md5.convert(utf8.encode(sha1HashWm+idUserWm)).toString();
}

Future<void> fetchDataBanner() async {
  print('fetchDataBanner === OK');
  try {
    final response = await http.post(
      Uri.parse(
        '$baseUrlWm/klikwm_get_banner',
      ),
      body: {"banner":"5"},
      headers: {
        'Authorization': 'Basic $encodedStringWm',
        'X-Wm-Signature': md5HashWm,
      }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      imagesBanner = List<String>.from(jsonData['data']);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
      imagesBanner = [];
  }
}

Future<void>readFromStorage() async {
  const storage = FlutterSecureStorage();
  kodeBiodata = (await storage.read(key: 'kode'))!;
  localName = (await storage.read(key: 'name'))!;
  localEmail = (await storage.read(key: 'email'))!;
  localUsername = (await storage.read(key: 'username'))!;
  localNomorTelp = (await storage.read(key: 'nomorTelp'))!;
  localCreateDate = (await storage.read(key: 'createDate'))!;
  localPassword = (await storage.read(key: 'password'))!;
}

Future<void> tujuanPenggunaanKredit() async {
  print('tujuanPenggunaanKredit === OK');
  try {
    final response = await http.post(
      Uri.parse(
        '$baseUrlWm/myWM_tujuan_penggunaan_kredit',
      ),
      body: {"data":versionAPK},
      headers: {
        'Authorization': 'Basic $encodedStringWm',
        'X-Wm-Signature': md5HashWm,
      }
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> datay = jsonDecode(response.body)['data'];
      dataTujuanPenggunaan = datay.map((key, value) => MapEntry(key, List<String>.from(value)));

      var dataa = json.decode(response.body)['data'];
      List<String> keys = dataa.keys.toList();
      tujuanPenggunaan = List<String>.from(keys);
    } else {
      cekVersionApk = false;
    }
  } catch (e) {
      cekVersionApk = false;
  }
}


Future<void> fetchDataSyaratPendaftaran() async {
  print('fetchDataSyaratPendaftaran === OK');
  try {
    final response = await http.post(
      Uri.parse('https://tempfile.myWM.id/proses/develop_mobile.php?p=get_syarat_pendaftaran'),
      body: {"token":'aawer234235rawfsad'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      await Future.delayed(const Duration(seconds: 2));
      syaratPendaftaran = jsonData['data'];
    } else {
      throw Exception('Gagal mengambil data URL dari API');
    }
  } catch (e) {
    print('Error: $e');
  }
}