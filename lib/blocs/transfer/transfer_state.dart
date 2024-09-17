part of 'transfer_bloc.dart';

abstract class TransferState extends Equatable {
  const TransferState();
  
  // @override
  // List<Object> get props => [];
}

class TransferInitial extends TransferState {
  @override
  List<Object?> get props => [];
}
//====================================================================
class CekPenerimaLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class CekPenerimaFailed extends TransferState {
  final String e;
  const CekPenerimaFailed(this.e);
  @override
  List<Object> get props => [e];
}
class CekAutorFailed extends TransferState {
  final String e;
  const CekAutorFailed(this.e);
  @override
  List<Object> get props => [e];
}
class CekPenerimaSuccess extends TransferState {  
  final TransferSesamaModel datarek;
  const CekPenerimaSuccess(this.datarek);
  @override
  List<Object> get props => [datarek];
}
//====================================================================
class TfSesamaSendOTPLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class TfSesamaSendOTPFailed extends TransferState {
  final String e;
  const TfSesamaSendOTPFailed(this.e);
  @override
  List<Object> get props => [e];
}
class TfSesamaSendOTPSuccess extends TransferState { 
  final Map<String, dynamic> dataOTP;
  const TfSesamaSendOTPSuccess(this.dataOTP);
  @override
  List<Object> get props => [dataOTP];
}
//====================================================================
class TfSesamaSendOTPValidasiLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class TfSesamaSendOTPValidasiFailed extends TransferState {
  final String e;
  const TfSesamaSendOTPValidasiFailed(this.e);
  @override
  List<Object> get props => [e];
}
class TfSesamaSendOTPValidasiSuccess extends TransferState { 
  final Map<String, dynamic> dataPIN;
  const TfSesamaSendOTPValidasiSuccess(this.dataPIN);
  @override
  List<Object> get props => [dataPIN];
}
//====================================================================
class TfSesamaSendPINValidasiLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class TfSesamaSendPINValidasiFailed extends TransferState {
  final String e;
  const TfSesamaSendPINValidasiFailed(this.e);
  @override
  List<Object> get props => [e];
}
class TfSesamaSendPINValidasiSuccess extends TransferState { 
  final Map<String, dynamic> dataPIN;
  const TfSesamaSendPINValidasiSuccess(this.dataPIN);
  @override
  List<Object> get props => [dataPIN];
}
//=================================  TRANSFER BANK LAIN ===================================
class TransferBankLainCekPenerimaLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class TransferBankLainFailed extends TransferState {
  final String e;
  const TransferBankLainFailed(this.e);
  @override
  List<Object> get props => [e];
}
class TransferBankLainSuccess extends TransferState { 
  final Map<String, dynamic> dataResult;
  const TransferBankLainSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
//=================================  TRANSFER Rekening Kredit ===================================
class PengajuanRekeningKreditLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class PengajuanRekeningKreditSuccess extends TransferState { 
  final Map<String, dynamic> dataResult;
  const PengajuanRekeningKreditSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class PengajuanRekeningKreditFailed extends TransferState {
  final String e;
  const PengajuanRekeningKreditFailed(this.e);
  @override
  List<Object> get props => [e];
}
class KirimUlangOTPRekeningKreditLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class KirimUlangOTPRekeningKreditSuccess extends TransferState { 
  final Map<String, dynamic> dataResult;
  const KirimUlangOTPRekeningKreditSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class KirimUlangOTPRekeningKreditFailed extends TransferState {
  final String e;
  const KirimUlangOTPRekeningKreditFailed(this.e);
  @override
  List<Object> get props => [e];
}
class ValidasiOTPRekeningKreditLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class ValidasiOTPRekeningKreditSuccess extends TransferState { 
  final Map<String, dynamic> dataResult;
  const ValidasiOTPRekeningKreditSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class ValidasiOTPRekeningKreditFailed extends TransferState {
  final String e;
  const ValidasiOTPRekeningKreditFailed(this.e);
  @override
  List<Object> get props => [e];
}
//=====================================================================
class ValidasiPINRekeningKreditLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class ValidasiPINRekeningKreditSuccess extends TransferState { 
  final Map<String, dynamic> dataResult;
  const ValidasiPINRekeningKreditSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class ValidasiPINRekeningKreditFailed extends TransferState {
  final String e;
  const ValidasiPINRekeningKreditFailed(this.e);
  @override
  List<Object> get props => [e];
}
//=================================== MY WM ================================
class TransaksiTerakhirLoading extends TransferState {
  @override
  List<Object?> get props => [];
}
class TransaksiTerakhirSuccess extends TransferState{
  final Map<String, dynamic> dataResult;
  const TransaksiTerakhirSuccess(this.dataResult);
  @override
  List<Object> get props =>[dataResult];
}
class TransaksiTerakhirFailed extends TransferState {
  final String e;
  const TransaksiTerakhirFailed(this.e);
  @override
  List<Object?> get props => [e];
}