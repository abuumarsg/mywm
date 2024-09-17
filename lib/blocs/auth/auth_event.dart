part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  // @override
  // List<Object> get props => [];
}

class AuthCheckUsername extends AuthEvent {
  final String username;
  const AuthCheckUsername(this.username);
  @override
  List<Object?> get props => [username];
}
class AuthCheckUsername2 extends AuthEvent {
  // final SignInFormModel data;
  // const AuthCheckUsername2(this.data);
  // @override
  // List<Object?> get props => [data];
  
  final String username;
  const AuthCheckUsername2(this.username);
  @override
  List<Object?> get props => [username];
}
//========================== LOGIN ===============================
class AuthLogin extends AuthEvent {
  final SignInFormModel data;
  const AuthLogin(this.data);
  @override
  List<Object?> get props => [data];
}
class AuthGetCurrentUser extends AuthEvent{
  @override
  List<Object?> get props => [];
}
class getOTPLogin extends AuthEvent{
  final Map<String, dynamic> data;
  const getOTPLogin(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiOTPLogin extends AuthEvent{
  final Map<String, dynamic> data;
  const ValidasiOTPLogin(this.data);
  @override
  List<Object?> get props => [data];
}
      //================================== LOGIN USERNAME DAN PASSWORD =======================================
class AuthLoginmyWM extends AuthEvent {
  final String username;
  final String password;
  const AuthLoginmyWM(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}