part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  // @override
  // List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}
class UserloadedFailed extends UserState {
  final String e;
  const UserloadedFailed(this.e);
  @override
  List<Object?> get props => [e];
}
class Userloaded extends UserState{
  final UserModel user;
  const Userloaded(this.user);
  @override
  List<Object> get props =>[user];
}
class UserLogOutSuccess extends UserState {
  @override
  List<Object> get props => [];
}
//=================================  TRANSFER BANK LAIN ===================================
class UploadProfilePictureLoading extends UserState {
  @override
  List<Object> get props => [];
}
class UploadProfilePictureFailed extends UserState {
  final String e;
  const UploadProfilePictureFailed(this.e);
  @override
  List<Object> get props => [e];
}
class UploadProfilePictureSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const UploadProfilePictureSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class DeleteProfilePictureLoading extends UserState {
  @override
  List<Object> get props => [];
}
class DeleteProfilePictureFailed extends UserState {
  final String e;
  const DeleteProfilePictureFailed(this.e);
  @override
  List<Object> get props => [e];
}
class DeleteProfilePictureSuccess extends UserState { 
  final String dataResult;
  const DeleteProfilePictureSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class PerintahBlokirAkunLoading extends UserState {
  @override
  List<Object> get props => [];
}
class PerintahBlokirAkunFailed extends UserState {
  final String e;
  const PerintahBlokirAkunFailed(this.e);
  @override
  List<Object> get props => [e];
}
class PerintahBlokirAkunSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const PerintahBlokirAkunSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class ValidasiPinBlokirAkunLoading extends UserState {
  @override
  List<Object> get props => [];
}
class ValidasiPinBlokirAkunFailed extends UserState {
  final String e;
  const ValidasiPinBlokirAkunFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiPinBlokirAkunSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const ValidasiPinBlokirAkunSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class GantiPasswordLoading extends UserState {
  @override
  List<Object> get props => [];
}
class GantiPasswordFailed extends UserState {
  final String e;
  const GantiPasswordFailed(this.e);
  @override
  List<Object> get props => [e];
}
class GantiPasswordSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const GantiPasswordSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class ValidasiGantiPasswordLoading extends UserState {
  @override
  List<Object> get props => [];
}
class ValidasiGantiPasswordFailed extends UserState {
  final String e;
  const ValidasiGantiPasswordFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiGantiPasswordSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const ValidasiGantiPasswordSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class GantiPinLoading extends UserState {
  @override
  List<Object> get props => [];
}
class GantiPinFailed extends UserState {
  final String e;
  const GantiPinFailed(this.e);
  @override
  List<Object> get props => [e];
}
class GantiPinSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const GantiPinSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class ValidasiGantiPinLoading extends UserState {
  @override
  List<Object> get props => [];
}
class ValidasiGantiPinFailed extends UserState {
  final String e;
  const ValidasiGantiPinFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiGantiPinSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const ValidasiGantiPinSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class LupaPinCekRekeningDanKtpLoading extends UserState {
  @override
  List<Object> get props => [];
}
class LupaPinCekRekeningDanKtpFailed extends UserState {
  final String e;
  const LupaPinCekRekeningDanKtpFailed(this.e);
  @override
  List<Object> get props => [e];
}
class LupaPinCekRekeningDanKtpSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const LupaPinCekRekeningDanKtpSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class BuatPinBaruLoading extends UserState {
  @override
  List<Object> get props => [];
}
class BuatPinBaruFailed extends UserState {
  final String e;
  const BuatPinBaruFailed(this.e);
  @override
  List<Object> get props => [e];
}
class BuatPinBaruSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const BuatPinBaruSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class ValidasiBuatPinBaruLoading extends UserState {
  @override
  List<Object> get props => [];
}
class ValidasiBuatPinBaruFailed extends UserState {
  final String e;
  const ValidasiBuatPinBaruFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiBuatPinBaruSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const ValidasiBuatPinBaruSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class DaftarCekKtpNamaLoading extends UserState {
  @override
  List<Object> get props => [];
}
class DaftarCekKtpNamaFailed extends UserState {
  final String e;
  const DaftarCekKtpNamaFailed(this.e);
  @override
  List<Object> get props => [e];
  // final Map<String, dynamic> dataError;
  // const DaftarCekKtpNamaFailed(this.dataError);
  // @override
  // List<Object> get props => [dataError];
}
class DaftarCekKtpNamaSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const DaftarCekKtpNamaSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class DaftarCekRekeningLoading extends UserState {
  @override
  List<Object> get props => [];
}
class DaftarCekRekeningFailed extends UserState {
  final String e;
  const DaftarCekRekeningFailed(this.e);
  @override
  List<Object> get props => [e];
}
class DaftarCekRekeningSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const DaftarCekRekeningSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class DaftarUploadKTPSelfieLoading extends UserState {
  @override
  List<Object> get props => [];
}
class DaftarUploadKTPSelfieFailed extends UserState {
  final String e;
  const DaftarUploadKTPSelfieFailed(this.e);
  @override
  List<Object> get props => [e];
}
class DaftarUploadKTPSelfieSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const DaftarUploadKTPSelfieSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class DaftarValidasiJamLoading extends UserState {
  @override
  List<Object> get props => [];
}
class DaftarValidasiJamFailed extends UserState {
  final String e;
  const DaftarValidasiJamFailed(this.e);
  @override
  List<Object> get props => [e];
}
class DaftarValidasiJamSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const DaftarValidasiJamSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class LupaUsernameLoading extends UserState {
  @override
  List<Object> get props => [];
}
class LupaUsernameFailed extends UserState {
  final String e;
  const LupaUsernameFailed(this.e);
  @override
  List<Object> get props => [e];
}
class LupaUsernameSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const LupaUsernameSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class ValidasiLupaUsernameLoading extends UserState {
  @override
  List<Object> get props => [];
}
class ValidasiLupaUsernameFailed extends UserState {
  final String e;
  const ValidasiLupaUsernameFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiLupaUsernameSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const ValidasiLupaUsernameSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class LupaPasswordLoading extends UserState {
  @override
  List<Object> get props => [];
}
class LupaPasswordFailed extends UserState {
  final String e;
  const LupaPasswordFailed(this.e);
  @override
  List<Object> get props => [e];
}
class LupaPasswordSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const LupaPasswordSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=======================================================================
class ValidasiLupaPasswordLoading extends UserState {
  @override
  List<Object> get props => [];
}
class ValidasiLupaPasswordFailed extends UserState {
  final String e;
  const ValidasiLupaPasswordFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiLupaPasswordSuccess extends UserState { 
  final Map<String, dynamic> dataResult;
  const ValidasiLupaPasswordSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}