part of 'transfer_bloc.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();
}
class TransferSesamaCekPenerima extends TransferEvent {
  final FormTransferSesamaModel data;
  const TransferSesamaCekPenerima(this.data);
  @override
  List<Object?> get props => [data];
}
class TransferSesamaOTP extends TransferEvent {
  final Map<String, dynamic> data;
  const TransferSesamaOTP(this.data);
  @override
  List<Object?> get props => [data];
}
class TransferSesamaSendValidasiOTP extends TransferEvent {
  final Map<String, dynamic> data;
  const TransferSesamaSendValidasiOTP(this.data);
  @override
  List<Object?> get props => [data];
}
class TransferSesamaSendValidasiPIN extends TransferEvent {
  final Map<String, dynamic> data;
  const TransferSesamaSendValidasiPIN(this.data);
  @override
  List<Object?> get props => [data];
}
//===============================================================================
class TransferBankLainCekPenerima extends TransferEvent {
  final Map<String, dynamic> data;
  const TransferBankLainCekPenerima(this.data);
  @override
  List<Object?> get props => [data];
}
class PengajuanRekeningKredit extends TransferEvent {
  final Map<String, dynamic> data;
  const PengajuanRekeningKredit(this.data);
  @override
  List<Object?> get props => [data];
}
class KirimUlangOTPRekeningKredit extends TransferEvent {
  final Map<String, dynamic> data;
  const KirimUlangOTPRekeningKredit(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiOTPRekeningKredit extends TransferEvent {
  final Map<String, dynamic> data;
  const ValidasiOTPRekeningKredit(this.data);
  @override
  List<Object?> get props => [data];
}
class ValidasiPINRekeningKredit extends TransferEvent {
  final Map<String, dynamic> data;
  const ValidasiPINRekeningKredit(this.data);
  @override
  List<Object?> get props => [data];
}

class GetDataTransaksiTerakhir extends TransferEvent{
  final String rekening;
  const GetDataTransaksiTerakhir(this.rekening);
  @override
  List<Object?> get props => [rekening];
}
