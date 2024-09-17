import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myWM/models/kredit_model.dart';
import 'package:myWM/models/login_form_model.dart';
import 'package:myWM/models/va_model.dart';
import 'package:myWM/shared/global_data.dart';
// import 'package:logger/logger.dart';
import '../models/data_mutasi_model.dart';
import '../models/data_riyawat_transaksi.dart';
import '../models/deposito_model.dart';
import '../models/list_bank_model.dart';
import '../models/rekening_favorit_model.dart';
import '../models/rekening_transfer_model.dart';
import '../models/saldo_model.dart';
import '../shared/share_values.dart';
class SaldoServices{
  // var logger = Logger();
  //==========================================================================================================================
  Future<List<SaldoModel?>> tesAPI(SignInFormModel data) async {
    try{
      const url = "https://api.themoviedb.org/3/discover/movie?api_key=3e059cc1608b96aa6616239237a37661&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate";
      // client ??= http.Client();
      var response = await http.get(Uri.parse(url));
      if(response.statusCode != 200){
        throw jsonDecode(response.body)['msg'];
      }else{
        var data = jsonDecode(response.body);
        List result = data['LIST_TABUNGAN'];
        return result.map((e) => SaldoModel.fromJson(e)).toList();
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  static Future<List<SaldoModel>> getSaldo(SignInFormModel data) async {
    // var logger = Logger();
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/reload_saldo_klikwm',
        ),
        body: data.toJson(),
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(response.statusCode);
      // logger.i(response.body);
      if(response.statusCode != 200){
        throw jsonDecode(response.body)['msg'];
      }else{
        if(jsonDecode(response.body)['status'] == 'error'){
          // logger.i(jsonDecode(response.body)['status']);
          throw jsonDecode(response.body)['msg'];
        }else{
          var data = jsonDecode(response.body);
          List result = data['LIST_TABUNGAN'];
          return result.map((e) => SaldoModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  static Future<List<DepositoModel>> getSaldoDeposito(SignInFormModel data) async {
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/reload_saldo_deposito_klikwm',
        ),
        body: data.toJson(),
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
          var data = jsonDecode(response.body);
          List result = data['LIST_DEPOSITO'];
          return result.map((e) => DepositoModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  static Future<List<KreditModel>> getSaldoKredit(SignInFormModel data) async {
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/reload_saldo_kredit_klikwm',
        ),
        body: data.toJson(),
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(response.statusCode);
      // logger.i(jsonDecode(response.body));
      if(response.statusCode != 200){
        throw jsonDecode(response.body)['msg'];
      }else{
        if(jsonDecode(response.body)['status'] == 'error'){
          throw jsonDecode(response.body)['msg'];
        }else{
          var data = jsonDecode(response.body);
          List result = data['LIST_KREDIT'];
          return result.map((e) => KreditModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  static Future<List<RekFavModel>> getRekeningFavorit(SignInFormModel data) async {
    // var logger = Logger();
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_rekening_favorit',
        ),
        body: data.toJson(),
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
          var data = jsonDecode(response.body);
          List result = data['data'];
          globalListFavorit = result.map((e) => RekFavModel.fromJson(e)).toList();
          List resultWM = data['dataFavWM'];
          globalListFavoritWM = resultWM.map((e) => RekFavModel.fromJson(e)).toList();
          List resultOther = data['dataFavOt'];
          globalListFavoritOther = resultOther.map((e) => RekFavModel.fromJson(e)).toList();
          // logger.i(globalListFavorit);
          return result.map((e) => RekFavModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  static Future<List> getRekening(cif) async {
    // var logger = Logger();
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_list_rekening_by_cif',
        ),
        body: {
          'cif': cif,
        },
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(response.statusCode);
      // logger.i(response.body);
      if(response.statusCode != 200){
        throw jsonDecode(response.body)['msg'];
      }else{
        if(jsonDecode(response.body)['status'] == 'error'){
          throw jsonDecode(response.body)['msg'];
        }else{
          var data = jsonDecode(response.body);
          // logger.i(data);
          return data['data'];
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  Future<List<DataMutasiModel>> loadDataMutasiRekening(String rekening, String tanggal) async {
    try{
      const storage = FlutterSecureStorage();
      String? userId = await storage.read(key: 'id');
      String? token = await storage.read(key: 'token');
      String? cif = await storage.read(key: 'cif');
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_get_data_mutasi_rekening',
        ),
        body: {
          'userId': userId,
          'token': token,
          'cif': cif,
          'rekening': rekening,
          'tanggal': tanggal,
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
          var data = jsonDecode(response.body);
          List result = data['data'];
          return result.map((e) => DataMutasiModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  static Future<List<RekeningForTransferModel>> loadDataRekeningTransfer() async {
    // var logger = Logger();
    try{
      const storage = FlutterSecureStorage();
      String? cif = await storage.read(key: 'cif');
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_get_rekening_for_transfer',
        ),
        body: {
          'cif': cif,
        },
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(response.statusCode);
      if(response.statusCode != 200){
        throw jsonDecode(response.body)['msg'];
      }else{
        if(jsonDecode(response.body)['status'] == 'error'){
          throw jsonDecode(response.body)['msg'];
        }else{
          // logger.i(jsonDecode(response.body)['data']);
          var data = jsonDecode(response.body);
          // return data;
          List result = data['data'];
          return result.map((e) => RekeningForTransferModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //==========================================================================================================================
  Future<List<DataRiwayatTransaksi>> loadDataRiwayatTransaksi(String rekening, String tanggal) async {
    try{
      const storage = FlutterSecureStorage();
      String? userId = await storage.read(key: 'id');
      String? token = await storage.read(key: 'token');
      String? cif = await storage.read(key: 'cif');
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_get_data_riwayat_transaksi',
        ),
        body: {
          'userId': userId,
          'token': token,
          'cif': cif,
          'rekening': rekening,
          'tanggal': tanggal,
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
          var data = jsonDecode(response.body);
          List result = data['data'];
          return result.map((e) => DataRiwayatTransaksi.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
  //===================================================================================================================================
  static Future<List<ListBankModel>> getListBankLain(SignInFormModel data) async {
    // var logger = Logger();
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_list_bank',
        ),
        body: data.toJson(),
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
          var data = jsonDecode(response.body);
          List result = data['data'];
          // logger.i(result);
          globalListBankLain = result.map((e) => ListBankModel.fromJson(e)).toList();
          return result.map((e) => ListBankModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }

  Future<List<VAModel>> userRequestVirtualAccount(String rekening) async {
    try {
      const storage = FlutterSecureStorage();
      final kode = (await storage.read(key: 'kode'))!;
      final token = (await storage.read(key: 'token'))!;
      final userId = (await storage.read(key: 'id'))!;
      Map<String, dynamic> dataBody = {"kodeBiodata":kode, "token":token, "user_id":userId, "nomorRekening":rekening};
      // Map<String, dynamic> dataBody = data;
      // dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_nomor_va',
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
          var data = jsonDecode(res.body);
          List result = data['data'];
          return result.map((e) => VAModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteRekeningFavorit(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final kode = (await storage.read(key: 'kode'))!;
      final token = (await storage.read(key: 'token'))!;
      final userId = (await storage.read(key: 'id'))!;
      Map<String, dynamic> dataX = {"kodeBiodata":kode, "token":token, "user_id":userId};
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_hapus_rekening_favorit',
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
  static Future<List<SaldoUtamaModel>> getSaldoUtama(SignInFormModel data) async {
    try{
      final response = await http.post(
        Uri.parse(
          '$baseUrlWm/reload_saldo_klikwm',
        ),
        body: data.toJson(),
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
          var data = jsonDecode(response.body);
          List result = data['LIST_TABUNGAN'];
          return result.map((e) => SaldoUtamaModel.fromJson(e)).toList();
        }
      }
    } catch(e){
      rethrow;
    }
  }
}