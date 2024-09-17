part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  // @override
  // List<Object> get props => [];
  
}
class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthFailed extends AuthState {
  final String e;
  const AuthFailed(this.e);
  @override
  List<Object> get props => [e];
}
class AuthCheckUsernameSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthCheckUsernameSuccess2 extends AuthState {  
  final UserModel users;
  const AuthCheckUsernameSuccess2(this.users);
  @override
  List<Object> get props => [users];
}
//================================= LOGIN =============================
class AuthLoginSuccess extends AuthState {  
  final UserModel users;
  const AuthLoginSuccess(this.users);
  @override
  List<Object> get props => [users];
}
//===================================================================
class AuthgetOtpLoginLoading extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthgetOtpLoginSuccess extends AuthState{
  final Map<String, dynamic> dataResult;
  const AuthgetOtpLoginSuccess(this.dataResult);
  @override
  List<Object> get props =>[dataResult];
}
class AuthgetOtpLoginFailed extends AuthState {
  final String e;
  const AuthgetOtpLoginFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//===================================================================
class AuthValidasiOTPLoginLoading extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthValidasiOTPLoginSuccess extends AuthState{
  final Map<String, dynamic> dataResult;
  const AuthValidasiOTPLoginSuccess(this.dataResult);
  @override
  List<Object> get props =>[dataResult];
}
class AuthValidasiOTPLoginFailed extends AuthState {
  final String e;
  const AuthValidasiOTPLoginFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//================================== LOGIN USERNAME DAN PASSWORD =======================================

class AuthLoginmyWMLoading extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthLoginmyWMSuccess extends AuthState {  
  final UserModel users;
  const AuthLoginmyWMSuccess(this.users);
  @override
  List<Object> get props => [users];
}
class AuthLoginmyWMFailed extends AuthState {
  final String e;
  const AuthLoginmyWMFailed(this.e);
  @override
  List<Object?> get props => [e];
}