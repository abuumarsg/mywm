part of 'rekening_bloc.dart';

abstract class RekeningEvent extends Equatable {
  const RekeningEvent();
  
}
class LoadRekening extends RekeningEvent{
  @override
  List<Object?> get props => [];
}
class RefreshRekening extends RekeningEvent{
  @override
  List<Object?> get props => [];
}
// ignore: camel_case_types
class getDataMutasi extends RekeningEvent{
  final String rekening;
  final String tanggal;
  const getDataMutasi(this.rekening, this.tanggal);
  @override
  List<Object?> get props => [rekening, tanggal];
}
class getRekeningTransfer extends RekeningEvent{
  const getRekeningTransfer();
  @override
  List<Object?> get props => [];
}
class getDataRiwayatTransaksi extends RekeningEvent{
  final String rekening;
  final String tanggal;
  const getDataRiwayatTransaksi(this.rekening, this.tanggal);
  @override
  List<Object?> get props => [rekening, tanggal];
}
class DeleteRekeningFavorit extends RekeningEvent{
  final Map<String, dynamic> data;
  const DeleteRekeningFavorit(this.data);
  @override
  List<Object?> get props => [data];
}
class ResetSaldoEvent extends RekeningEvent{
  @override
  List<Object?> get props => [];
}
