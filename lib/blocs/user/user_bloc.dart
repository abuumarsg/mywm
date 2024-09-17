import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myWM/services/auth_service.dart';

import '../../models/login_form_model.dart';
import '../../models/user_model.dart';
// import '../../services/saldo_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      try {
        emit(UserLoading());
        final SignInFormModel data = await AuthServices().getCredentialFromLocal();
        final UserModel user = await AuthServices().login(data);
        emit (Userloaded(user));
      } catch (e) {
        emit(UserloadedFailed(e.toString()));
      }
    });
    on<UserEvent>((event, emit) async {
      if(event is UserLogout){
        try {
          emit(UserLoading());
          final SignInFormModel data = await AuthServices().getCredentialFromLocal();
          await AuthServices().logout(data);
          emit (UserLogOutSuccess());
          emit (UserInitial());
        } catch (e) {
          emit(UserloadedFailed(e.toString()));
        }
      }
      //================================================== UPLOAD FOTO PROFILE ======================================================
      if(event is UploadProfilePicture) {
        try{
          emit(UploadProfilePictureLoading());
          Map<String, dynamic> datax = await AuthServices().userUploadProfilePicture(event.data);
          emit (UploadProfilePictureSuccess(datax));
        }catch (e) {
          emit(UploadProfilePictureFailed(e.toString()));
        }
      }
      if(event is DeleteProfilePicture) {
        try{
          emit(DeleteProfilePictureLoading());
          String datax = await AuthServices().userDeleteProfilePicture(event.data);
          emit (DeleteProfilePictureSuccess(datax));
        }catch (e) {
          emit(DeleteProfilePictureFailed(e.toString()));
        }
      }
      //================================================== PERINTAH BLOKIR AKUN ======================================================
      if(event is PerintahBlokirAkun) {
        try{
          emit(PerintahBlokirAkunLoading());
          Map<String, dynamic> datax = await AuthServices().userPerintahBlokirAkun(event.data);
          emit (PerintahBlokirAkunSuccess(datax));
        }catch (e) {
          emit(PerintahBlokirAkunFailed(e.toString()));
        }
      }
      if(event is ValidasiPinBlokirAkun) {
        try{
          emit(ValidasiPinBlokirAkunLoading());
          Map<String, dynamic> datax = await AuthServices().userValidasiPinBlokirAkun(event.data);
          emit (ValidasiPinBlokirAkunSuccess(datax));
        }catch (e) {
          emit(ValidasiPinBlokirAkunFailed(e.toString()));
        }
      }
      //================================================== GANTI PASSWORD ======================================================
      if(event is GantiPassword) {
        try{
          emit(GantiPasswordLoading());
          Map<String, dynamic> datax = await AuthServices().userGantiPassword(event.data);
          emit (GantiPasswordSuccess(datax));
        }catch (e) {
          emit(GantiPasswordFailed(e.toString()));
        }
      }
      if(event is ValidasiGantiPassword) {
        try{
          emit(ValidasiGantiPasswordLoading());
          Map<String, dynamic> datax = await AuthServices().userValidasiGantiPassword(event.data);
          emit (ValidasiGantiPasswordSuccess(datax));
        }catch (e) {
          emit(ValidasiGantiPasswordFailed(e.toString()));
        }
      }
      //================================================== GANTI PIN ======================================================
      if(event is GantiPin) {
        try{
          emit(GantiPinLoading());
          Map<String, dynamic> datax = await AuthServices().userGantiPin(event.data);
          emit (GantiPinSuccess(datax));
        }catch (e) {
          emit(GantiPinFailed(e.toString()));
        }
      }
      if(event is ValidasiGantiPin) {
        try{
          emit(ValidasiGantiPinLoading());
          Map<String, dynamic> datax = await AuthServices().userValidasiGantiPin(event.data);
          emit (ValidasiGantiPinSuccess(datax));
        }catch (e) {
          emit(ValidasiGantiPinFailed(e.toString()));
        }
      }
      //================================================== LUPA PIN ======================================================
      if(event is LupaPinCekRekeningDanKtp) {
        try{
          emit(LupaPinCekRekeningDanKtpLoading());
          Map<String, dynamic> datax = await AuthServices().userLupaPinCekRekeningDanKtp(event.data);
          emit (LupaPinCekRekeningDanKtpSuccess(datax));
        }catch (e) {
          emit(LupaPinCekRekeningDanKtpFailed(e.toString()));
        }
      }
      if(event is BuatPinBaru) {
        try{
          emit(BuatPinBaruLoading());
          Map<String, dynamic> datax = await AuthServices().userBuatPinBaru(event.data);
          emit (BuatPinBaruSuccess(datax));
        }catch (e) {
          emit(BuatPinBaruFailed(e.toString()));
        }
      }
      if(event is ValidasiBuatPinBaru) {
        try{
          emit(ValidasiBuatPinBaruLoading());
          Map<String, dynamic> datax = await AuthServices().userValidasiBuatPinBaru(event.data);
          emit (ValidasiBuatPinBaruSuccess(datax));
        }catch (e) {
          emit(ValidasiBuatPinBaruFailed(e.toString()));
        }
      }
      //================================================== PENDAFTARAN AKUN ======================================================
      if(event is DaftarCekKtpNama) {
        try{
          emit(DaftarCekKtpNamaLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceDaftarCekKtpNama(event.data);
          emit (DaftarCekKtpNamaSuccess(datax));
        }catch (e) {
          emit(DaftarCekKtpNamaFailed(e.toString()));
          // emit(DaftarCekKtpNamaFailed(e));
        }
      }
      if(event is DaftarCekRekening) {
        try{
          emit(DaftarCekRekeningLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceDaftarCekRekening(event.data);
          emit (DaftarCekRekeningSuccess(datax));
        }catch (e) {
          emit(DaftarCekRekeningFailed(e.toString()));
          // emit(DaftarCekKtpNamaFailed(e));
        }
      }
      if(event is DaftarUploadKTPSelfie) {
        try{
          emit(DaftarUploadKTPSelfieLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceDaftarUploadKTPSelfie(event.data);
          emit (DaftarUploadKTPSelfieSuccess(datax));
        }catch (e) {
          emit(DaftarUploadKTPSelfieFailed(e.toString()));
          // emit(DaftarCekKtpNamaFailed(e));
        }
      }
      if(event is DaftarValidasiJam) {
        try{
          emit(DaftarValidasiJamLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceDaftarValidasiJam(event.data);
          emit (DaftarValidasiJamSuccess(datax));
        }catch (e) {
          emit(DaftarValidasiJamFailed(e.toString()));
          // emit(DaftarCekKtpNamaFailed(e));
        }
      }
      //==================================================== LUPA USERNAME =========================================================
      if(event is LupaUsername) {
        try{
          emit(LupaUsernameLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceLupaUsername(event.data);
          emit (LupaUsernameSuccess(datax));
        }catch (e) {
          emit(LupaUsernameFailed(e.toString()));
        }
      }
      if(event is ValidasiLupaUsername) {
        try{
          emit(ValidasiLupaUsernameLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceValidasiLupaUsername(event.data);
          emit (ValidasiLupaUsernameSuccess(datax));
        }catch (e) {
          emit(ValidasiLupaUsernameFailed(e.toString()));
        }
      }
      //==================================================== LUPA USERNAME =========================================================
      if(event is LupaPassword) {
        try{
          emit(LupaPasswordLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceLupaPassword(event.data);
          emit (LupaPasswordSuccess(datax));
        }catch (e) {
          emit(LupaPasswordFailed(e.toString()));
        }
      }
      if(event is ValidasiLupaPassword) {
        try{
          emit(ValidasiLupaPasswordLoading());
          Map<String, dynamic> datax = await AuthServices().authServiceValidasiLupaPassword(event.data);
          emit (ValidasiLupaPasswordSuccess(datax));
        }catch (e) {
          emit(ValidasiLupaPasswordFailed(e.toString()));
        }
      }
    });
  }
}
