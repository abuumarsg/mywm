import 'dart:convert';
import 'package:client_information/client_information.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:myWM/models/login_form_model.dart';
import 'package:myWM/models/user_model.dart';
import 'package:logger/logger.dart';
import 'package:myWM/shared/global_data.dart';
import '../shared/share_values.dart';

class AuthServices{
  var logger = Logger();
  Future<String> checkUsername(String username) async {
    try{
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_username_klikwm',
        ),
        body: {
          'username': username,
        },
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        return jsonDecode(res.body)['status'];
      }
    } catch(e){
      rethrow;
    }
  }
  
  //================================================ CHECK USERNAME ===========================================================
  Future<UserModel> checkUsernameNew(String username) async {
    var info = await ClientInformation.fetch();
    try{
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_username_klikwm',
        ),
        body: {
          'username': username,
          'deviceId': info.deviceId,
          'deviceName': info.deviceName,
          'osName': info.osName,
          'ip_address': '',//getipAddress['ip'],
        },
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
          UserModel user = UserModel.fromJson(jsonDecode(res.body)['data']);
          return user;
        }
      }
    } catch(e){
      rethrow;
    }
  }
  
  //================================================ LOGIN ===================================================================
  Future<UserModel> login(SignInFormModel data) async {
    try{
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_login_klikwm',
        ),
        body: data.toJson(),
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(dataBody);
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        // UserModel users = UserModel.fromJson(data.toJson());
        UserModel users = UserModel.fromJson(jsonDecode(res.body)['data']);
        await storeCredentialToLocal(users);        
        return users;
      }
    } catch(e){
      rethrow;
    }
  }
  
  Future<UserModel> loginUlang(SignInFormModel data) async {
    try{
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_login_klikwm',
        ),
        body: data.toJson(),
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        UserModel users = UserModel.fromJson(data.toJson());
        const storage = FlutterSecureStorage();
        await storage.write(key: 'session', value: formattedDateWm); 
        return users;
      }
    } catch(e){
      rethrow;
    }
  }
  
  //================================================ LOGOUT ==================================================================
  Future<void> logout(SignInFormModel data) async {
    try{
      // final token = await getToken();
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_logout_klikwm',
        ),
        body: data.toJson(),
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        await clearLocalStorage();
      }
    } catch(e){
      rethrow;
    }
  }

  // ======================= SAVE DATA TO LOCAL ==============================================================================
  Future<void> storeCredentialToLocal (UserModel user) async {
    try{
      const storage = FlutterSecureStorage();
      await storage.write(key: 'id', value: user.id);
      await storage.write(key: 'username', value: user.username);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'nomorTelp', value: user.nomorTelp);
      await storage.write(key: 'createDate', value: user.createDate);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'cif', value: user.cif);
      await storage.write(key: 'name', value: user.name);
      await storage.write(key: 'kode', value: user.kode);
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'session', value: futureDate.toString());
      await storage.write(key: 'verificationOTP', value: user.verificationOTP);
    }catch (e){
      rethrow;
    }
  }
  
  Future<SignInFormModel> getCredentialFromLocal() async{
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();
      if(values['username'] == null || values['password'] == null){
        throw 'authentication';
      }else{
        final SignInFormModel data = SignInFormModel(
          username: values['username'],
          password: values['password'],
          id: values['id'],
          cif: values['cif'],
          name: values['name'],
          kode: values['kode'],
          token: values['token'],
          verificationOTP: values['verificationOTP'],
        );
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<String> getToken() async{
    String token = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');
    if(value != null){
      token = 'WMers_$value';
    }
    return token;
  }

  Future<void> clearLocalStorage() async{
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  //==========================================================================================================================
  Future<Map<String, dynamic>> userUploadProfilePicture(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      // logger.i(dataBody);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_upload_profile_picture',
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

  Future<String> userDeleteProfilePicture(String data) async {
    try {
      const storage = FlutterSecureStorage();
      final dataX = await storage.readAll();
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_delete_profile_picture',
        ),
        body: dataX,
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
          return jsonDecode(res.body)['status'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  //==========================================================================================================================
  Future<Map<String, dynamic>> userPerintahBlokirAkun(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final kode = (await storage.read(key: 'kode'))!;
      Map<String, dynamic> dataX = {"kode":kode};
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_permintaan_blokir_akun_step1',
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

  Future<Map<String, dynamic>> userValidasiPinBlokirAkun(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> dataBody = data;
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_permintaan_blokir_akun_step2',
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

  Future<Map<String, dynamic>> userGantiPassword(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final kode = (await storage.read(key: 'kode'))!;
      final token = (await storage.read(key: 'token'))!;
      Map<String, dynamic> dataX = {"kodeBiodata":kode, "token":token};
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_minta_otp_ganti_password',
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

  Future<Map<String, dynamic>> userValidasiGantiPassword(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final userId = (await storage.read(key: 'id'))!;
      Map<String, dynamic> dataX = {"user_id":userId};
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_ubah_password',
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
  
  Future<Map<String, dynamic>> userGantiPin(Map<String, dynamic> data) async {
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
          '$baseUrlWm/klikwm_minta_otp_ubah_pin',
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
  
  Future<Map<String, dynamic>> userValidasiGantiPin(Map<String, dynamic> data) async {
    try {
      const storage = FlutterSecureStorage();
      final userId = (await storage.read(key: 'id'))!;
      Map<String, dynamic> dataX = {"user_id":userId};
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_ubah_pin',
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
  
  Future<Map<String, dynamic>> userLupaPinCekRekeningDanKtp(Map<String, dynamic> data) async {
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
          '$baseUrlWm/klikwm_lupa_pin_step1',
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
  
  Future<Map<String, dynamic>> userBuatPinBaru(Map<String, dynamic> data) async {
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
          '$baseUrlWm/klikwm_minta_otp_lupa_pin',
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

  Future<Map<String, dynamic>> userValidasiBuatPinBaru(Map<String, dynamic> data) async {
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
          '$baseUrlWm/klikwm_buat_pin_baru',
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

  //===========================================================================================================================
  
  Future<Map<String, dynamic>> authServiceDaftarCekKtpNama(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      Map<String, dynamic> dataX = {
        "ip_address": '',//getipAddress['ip'],
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_pendaftaran_validasi_ktp',
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
          return jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> authServiceDaftarCekRekening(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      Map<String, dynamic> dataX = {
        "ip_address": '',//getipAddress['ip'],
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_pendaftaran_validasi_data_diri',
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
  
  Future<Map<String, dynamic>> authServiceDaftarUploadKTPSelfie(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      Map<String, dynamic> dataX = {
        "ip_address": '',//getipAddress['ip'],
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_pendaftaran_upload_ktp_selfie',
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
  
  Future<Map<String, dynamic>> authServiceDaftarValidasiJam(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      // var ipAddress = IpAddress(type: RequestType.json);
      // dynamic getipAddress = await ipAddress.getIpAddress();
      Map<String, dynamic> dataX = {
        "ip_address": '',//getipAddress['ip'],
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_pendaftaran_validasi_jam',
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
  
  //===========================================================================================================================
  
  Future<Map<String, dynamic>> authServiceLupaUsername(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      Map<String, dynamic> dataX = {
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_lupa_username',
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
          return jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Map<String, dynamic>> authServiceValidasiLupaUsername(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      Map<String, dynamic> dataX = {
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_validasi_lupa_username',
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
          return jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> authServiceLupaPassword(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      Map<String, dynamic> dataX = {
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_lupa_password',
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
          return jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<Map<String, dynamic>> authServiceValidasiLupaPassword(Map<String, dynamic> data) async {
    try {
      var info = await ClientInformation.fetch();
      Map<String, dynamic> dataX = {
        'deviceId': info.deviceId,
        'deviceName': info.deviceName,
        'osName': info.osName,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/klikwm_validasi_lupa_password',
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
          return jsonDecode(res.body)['msg'];
        }else{
          return jsonDecode(res.body)['data'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> serviceGetOTPLogin(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> dataBody = data;
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_send_otp_klikwm',
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

  Future<Map<String, dynamic>> serviceValidasiOTPLogin(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> dataX = {
        'tokenUser':tokenUser,
      };
      Map<String, dynamic> dataBody = data;
      dataBody.addAll(dataX);
      final respone = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_validasi_otp_klikwm',
        ),
        body: dataBody,
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      if(respone.statusCode == 200){
          const storage = FlutterSecureStorage();
          await storage.write(key: 'verificationOTP', value: 'true');
          return jsonDecode(respone.body)['data'];
      }else{
        throw jsonDecode(respone.body)['msg'];
      }
    } catch (e) {
      rethrow;
    }
  }


  //================================================ CHECK LOGIN USERNAME PASSWORD MYWM ===========================================================
  Future<UserModel> checkUsernamePassword(String username, String password) async {
    var info = await ClientInformation.fetch();
    try{
      final res = await http.post(
        Uri.parse(
          '$baseUrlWm/auth_login_myWM',
        ),
        body: {
          'username': username,
          'password': password,
          'deviceId': info.deviceId,
          'deviceName': info.deviceName,
          'osName': info.osName,
          'ip_address': '',
          'tokenUser':tokenUser,
        },
        headers: {
					'Authorization': 'Basic $encodedStringWm',
					'X-Wm-Signature': md5HashWm,
        }
      );
      // logger.i(res.statusCode);
      // logger.i(jsonDecode(res.body));
      if(res.statusCode != 200){
        throw jsonDecode(res.body)['msg'];
      }else{
        if(jsonDecode(res.body)['status'] == 'error'){
          throw jsonDecode(res.body)['msg'];
        }else{
          UserModel user = UserModel.fromJson(jsonDecode(res.body)['data']);
          await storeCredentialToLocal(user);        
          return user;
        }
      }
    } catch(e){
      rethrow;
    }
  }


}