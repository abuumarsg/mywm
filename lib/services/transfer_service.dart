import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/form_transfer_sesama_model.dart';
import '../models/transfer_sesama_model.dart';
import '../shared/share_values.dart';

class TransferServices{
  var logger = Logger();
  //==========================================================================================================================
  Future<TransferSesamaModel> cekPenerimaSesama(FormTransferSesamaModel data) async {
    try{
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data.toJson();
      Map<String, dynamic> map2 = dataX;
      // Map<String, dynamic> map3 = {"kodeBankTujuan":'000', "namaBankTujuan":'BPR WELERI MAKMUR',"ip_address": getipAddress['ip']};
      Map<String, dynamic> map3 = {"kodeBankTujuan":'000', "namaBankTujuan":'BPR WELERI MAKMUR',"ip_address": ''};
      dataBody.addAll(map2);
      dataBody.addAll(map3);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_cek_rekening_penerima',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(res.statusCode);
      // logger.i(jsonDecode(res.body)['data']);
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        if(jsonDecode(res.body)['status'] == 'error'){
          throw jsonDecode(res.body)['msg'];
        }else{
          TransferSesamaModel user = TransferSesamaModel.fromJson(jsonDecode(res.body)['data']);
          return user;
        }
      }
    } catch(e){
      rethrow;
    }
  }
  
  Future<Map<String, dynamic>> transferSesamaSendOTP(Map<String, dynamic> data) async {
    try {
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      // Map<String, dynamic> dataIP = {"ip_address": getipAddress['ip']};
      Map<String, dynamic> dataIP = {"ip_address": ''};
      dataBody.addAll(dataX);
      dataBody.addAll(dataIP);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_minta_otp_transfer',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        if(jsonDecode(res.body)['status'] == 'error'){
          throw jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Map<String, dynamic>> transferSesamaSendValidasiOTP(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_validasi_otp_transfer',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(dataBody);
      // logger.i(res.statusCode);
      // logger.i(jsonDecode(res.body)['data']);
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        if(jsonDecode(res.body)['status'] == 'error'){
          throw jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Map<String, dynamic>> transferSesamaSendValidasiPIN(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_validasi_pin_transfer',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(dataBody);
      // logger.i(res.statusCode);
      // logger.i(jsonDecode(res.body));
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        if(jsonDecode(res.body)['status'] == 'error'){
          throw jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  //==========================================================================================================================

  Future<Map<String, dynamic>> transferBankLainCekPenerima(Map<String, dynamic> data) async {
    try {
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      Map<String, dynamic> dataIPAddress = {"ip_address": ''};
      // Map<String, dynamic> dataIPAddress = {"ip_address": getipAddress['ip']};
      dataBody.addAll(dataX);
      dataBody.addAll(dataIPAddress);
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_cek_rekening_penerima',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(respone.statusCode != 200){
        throw jsonDecode(respone.body)['msg'];
      }else{
        if(jsonDecode(respone.body)['status'] == 'error'){
          throw jsonDecode(respone.body)['msg'];
        }else{
          return jsonDecode(respone.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  //=================================================== REKENING KREDIT =======================================================================

  Future<Map<String, dynamic>> servicePengajuanRekeningKredit(Map<String, dynamic> data) async {
    try {
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      Map<String, dynamic> dataIPAddress = {
        "ip_address": '',//getipAddress['ip'],
        "user_id":dataX['id'],
        "kode_biodata":dataX['kode'],
        "token":dataX['token'],
      };
      dataBody.addAll(dataIPAddress);
      // logger.i(dataBody);
      try {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('https://tempfile.klikwm.id/proses/develop_mobile.php?p=upload_file_rk',),
        );
        if (dataBody['file'].isNotEmpty){
          for (File file in dataBody['file']) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'files[]',
                file.path,
              ),
            );
          }
        }
        request.fields['nominal'] = dataBody['nominal'];
        request.fields['tujuanPenggunaan'] = dataBody['tujuanPenggunaan'];
        request.fields['nomorRekeningKredit'] = dataBody['nomorRekeningKredit'];
        request.fields['nomorRekeningTujuan'] = dataBody['nomorRekeningTujuan'];
        request.fields['ip_address'] = dataBody['ip_address'];
        request.fields['user_id'] = dataBody['user_id'];
        request.fields['kode_biodata'] = dataBody['kode_biodata'];
        request.fields['token'] = dataBody['token'];

        final response = await request.send();
        final responseData = await response.stream.transform(utf8.decoder).join();
        final Map<String, dynamic> decodedResponse = jsonDecode(responseData);
        // logger.i(dataBody);
        // print(response.statusCode);
        // print(decodedResponse);
        if (response.statusCode == 200) {
          return decodedResponse['data'];
        } else {
          throw decodedResponse['msg'];
        }
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> serviceKirimUlangOTPRekeningKredit(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      Map<String, dynamic> dataTambah = {"kode_biodata": dataX['kode'], "token": dataX['token'], "user_id": dataX['id']};
      dataBody.addAll(dataTambah);
      // logger.i(dataBody);
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_resend_otp_rekening_kredit',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.e(respone.statusCode);
      // logger.i(jsonDecode(respone.body));
      if(respone.statusCode != 200){
        throw jsonDecode(respone.body)['msg'];
      }else{
        if(jsonDecode(respone.body)['status'] == 'error'){
          throw jsonDecode(respone.body)['msg'];
        }else{
          return jsonDecode(respone.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> serviceValidasiOTPRekeningKredit(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      Map<String, dynamic> dataTambah = {"kode_biodata": dataX['kode'], "token": dataX['token'], "user_id": dataX['id']};
      dataBody.addAll(dataTambah);
      // logger.i(dataBody);
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_insert_validasi_otp_rekening_kredit',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.e(respone.statusCode);
      // logger.i(jsonDecode(respone.body));
      if(respone.statusCode != 200){
        throw jsonDecode(respone.body)['msg'];
      }else{
        if(jsonDecode(respone.body)['status'] == 'error'){
          throw jsonDecode(respone.body)['msg'];
        }else{
          return jsonDecode(respone.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Map<String, dynamic>> serviceValidasiPINRekeningKredit(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      Map<String, dynamic> dataTambah = {"kode_biodata": dataX['kode'], "token": dataX['token'], "user_id": dataX['id']};
      dataBody.addAll(dataTambah);
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_insert_validasi_pin_rekening_kredit',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(respone.statusCode == 200){
          return jsonDecode(respone.body)['data'];
      }else{
        throw jsonDecode(respone.body)['msg'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> serviceCekMaintenanceTransferBankLain(String data) async {
    try {
      Map<String, dynamic> dataBody = {"data":data};
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_CekMaintenanceTransferBankLain',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(respone.statusCode == 200){
          return jsonDecode(respone.body)['data'];
      }else{
        throw jsonDecode(respone.body)['msg'];
      }
    } catch (e) {
      rethrow;
    }
  }
  //=====================================================================================================================
  
  Future<Map<String, dynamic>> loadDataRiwayatTransaksiTabUtama(String rekening) async {
    try{
      const storage = FlutterSecureStorage();
      String? userId = await storage.read(key: 'id');
      String? token = await storage.read(key: 'token');
      String? cif = await storage.read(key: 'cif');
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_get_data_transaksi_terakhir',
        ),
        body: {
          'userId': userId,
          'token': token,
          'cif': cif,
          'rekening': rekening,
        },
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(response.statusCode != 200){
        throw jsonDecode(response.body)['msg'];
      }else{
        if(jsonDecode(response.body)['status'] == 'error'){
          throw jsonDecode(response.body)['msg'];
        }else{
          return jsonDecode(response.body)['data'];
        }
      }
    } catch(e){
      rethrow;
    }
  }

}