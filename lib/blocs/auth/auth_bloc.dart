// import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myWM/models/login_form_model.dart';
import 'package:myWM/models/user_model.dart';
// import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
// import 'package:myWM/models/nasabah_model.dart';

import '../../services/auth_service.dart';
// import '../../ui/widgets/storage_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var logger = Logger();
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if(event is AuthCheckUsername) {
        try {
          emit(AuthLoading());
          final res = await AuthServices().checkUsername(event.username);
          if(res == 'success'){
            emit(AuthCheckUsernameSuccess());
          }else{
            emit(const AuthFailed('Username Tidak Terdaftar'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if(event is AuthCheckUsername2) {
        try {
          // logger.i(event.username);
          emit(AuthLoading());
          UserModel? users = await AuthServices().checkUsernameNew(event.username);
          emit (AuthCheckUsernameSuccess2(users));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      //================================== LOGIN =======================================
      if(event is AuthLogin) {
        try{
          emit(AuthLoading());
          final users = await AuthServices().login(event.data);
          emit (AuthLoginSuccess(users));
        }catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if(event is AuthGetCurrentUser){
        try {
          emit(AuthLoading());
          final SignInFormModel data = await AuthServices().getCredentialFromLocal();
          final UserModel user = await AuthServices().login(data);
          emit (AuthLoginSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if(event is getOTPLogin) {
        try {
          emit(AuthgetOtpLoginLoading());
          Map<String, dynamic> datax = await AuthServices().serviceGetOTPLogin(event.data);
          emit (AuthgetOtpLoginSuccess(datax));
        } catch (e) {
          emit(AuthgetOtpLoginFailed(e.toString()));
        }
      }
      if(event is ValidasiOTPLogin) {
        try {
          emit(AuthValidasiOTPLoginLoading());
          Map<String, dynamic> datax = await AuthServices().serviceValidasiOTPLogin(event.data);
          emit (AuthValidasiOTPLoginSuccess(datax));
        } catch (e) {
          emit(AuthValidasiOTPLoginFailed(e.toString()));
        }
      }
      //================================== LOGIN USERNAME DAN PASSWORD =======================================
      if(event is AuthLoginmyWM) {
        try {
          emit(AuthLoginmyWMLoading());
          UserModel? users = await AuthServices().checkUsernamePassword(event.username, event.password);
          emit (AuthLoginmyWMSuccess(users));
        } catch (e) {
          emit(AuthLoginmyWMFailed(e.toString()));
        }
      }
    });
  }
}
