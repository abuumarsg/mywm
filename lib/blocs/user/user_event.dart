part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  // @override
  // List<Object> get props => [];
}
class LoadUser extends UserEvent{
  @override
  List<Object?> get props => [];
}
class UserLogout extends UserEvent{
  @override
  List<Object?> get props => [];
}
class UploadProfilePicture extends UserEvent {
  final Map<String, dynamic> data;
  const UploadProfilePicture(this.data);
  @override
  List<Object?> get props => [data];
}
class DeleteProfilePicture extends UserEvent {
  final String data;
  const DeleteProfilePicture(this.data);
  @override
  List<Object?> get props => [data];
}
class PerintahBlokirAkun extends UserEvent {
  final Map<String, dynamic> data;
  const PerintahBlokirAkun(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiPinBlokirAkun extends UserEvent {
  final Map<String, dynamic> data;
  const ValidasiPinBlokirAkun(this.data);
  @override
  List<Object?> get props => [data];
}
class GantiPassword extends UserEvent {
  final Map<String, dynamic> data;
  const GantiPassword(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiGantiPassword extends UserEvent {
  final Map<String, dynamic> data;
  const ValidasiGantiPassword(this.data);
  @override
  List<Object?> get props => [data];
}
class GantiPin extends UserEvent {
  final Map<String, dynamic> data;
  const GantiPin(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiGantiPin extends UserEvent {
  final Map<String, dynamic> data;
  const ValidasiGantiPin(this.data);
  @override
  List<Object?> get props => [data];
}
class LupaPinCekRekeningDanKtp extends UserEvent {
  final Map<String, dynamic> data;
  const LupaPinCekRekeningDanKtp(this.data);
  @override
  List<Object?> get props => [data];
}
class BuatPinBaru extends UserEvent {
  final Map<String, dynamic> data;
  const BuatPinBaru(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiBuatPinBaru extends UserEvent {
  final Map<String, dynamic> data;
  const ValidasiBuatPinBaru(this.data);
  @override
  List<Object?> get props => [data];
}
//====================================================================================================================
class DaftarCekKtpNama extends UserEvent {
  final Map<String, dynamic> data;
  const DaftarCekKtpNama(this.data);
  @override
  List<Object?> get props => [data];
}
class DaftarCekRekening extends UserEvent {
  final Map<String, dynamic> data;
  const DaftarCekRekening(this.data);
  @override
  List<Object?> get props => [data];
}
class DaftarUploadKTPSelfie extends UserEvent {
  final Map<String, dynamic> data;
  const DaftarUploadKTPSelfie(this.data);
  @override
  List<Object?> get props => [data];
}
class DaftarValidasiJam extends UserEvent {
  final Map<String, dynamic> data;
  const DaftarValidasiJam(this.data);
  @override
  List<Object?> get props => [data];
}
//====================================================================================================================
class LupaUsername extends UserEvent {
  final Map<String, dynamic> data;
  const LupaUsername(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiLupaUsername extends UserEvent {
  final Map<String, dynamic> data;
  const ValidasiLupaUsername(this.data);
  @override
  List<Object?> get props => [data];
}
//====================================================================================================================
class LupaPassword extends UserEvent {
  final Map<String, dynamic> data;
  const LupaPassword(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiLupaPassword extends UserEvent {
  final Map<String, dynamic> data;
  const ValidasiLupaPassword(this.data);
  @override
  List<Object?> get props => [data];
}
