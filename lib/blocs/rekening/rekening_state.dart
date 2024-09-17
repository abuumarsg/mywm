part of 'rekening_bloc.dart';

abstract class RekeningState extends Equatable {
  const RekeningState();
  
}

class RekeningInitial extends RekeningState {
  @override
  List<Object?> get props => [];
}
//===================================================================
class RekeningLoading extends RekeningState {
  @override
  List<Object?> get props => [];
}
class Rekeningloaded extends RekeningState{
  final List rekening;
  const Rekeningloaded(this.rekening);
  @override
  List<Object> get props =>[rekening];
}
class LoadRekeningFailed extends RekeningState {
  final String e;
  const LoadRekeningFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//===================================================================
class HistoryMutasiLoading extends RekeningState {
  @override
  List<Object?> get props => [];
}
class DataHistoryMutasiLoad extends RekeningState{
  final List<DataMutasiModel> dataMutasi;
  const DataHistoryMutasiLoad(this.dataMutasi);
  @override
  List<Object> get props =>[dataMutasi];
}
class LoadHistoryMutasiFailed extends RekeningState {
  final String e;
  const LoadHistoryMutasiFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//======================================================================
class RekeningForTransferLoading extends RekeningState {
  @override
  List<Object?> get props => [];
}
class DataRekeningForTransfer extends RekeningState{
  final List<RekeningForTransferModel> dataRekening;
  const DataRekeningForTransfer(this.dataRekening);
  @override
  List<Object> get props =>[dataRekening];
}
class RekeningForTransferFailed extends RekeningState {
  final String e;
  const RekeningForTransferFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//===================================================================
class RiwayatTransaksiLoading extends RekeningState {
  @override
  List<Object?> get props => [];
}
class DataRiwayatTransaksiSuccess extends RekeningState{
  final List<DataRiwayatTransaksi> dataRiwayatTransaksi;
  const DataRiwayatTransaksiSuccess(this.dataRiwayatTransaksi);
  @override
  List<Object> get props =>[dataRiwayatTransaksi];
}
class LoadRiwayatTransaksiFailed extends RekeningState {
  final String e;
  const LoadRiwayatTransaksiFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//===================================================================
class DeleteRekeningFavoritLoading extends RekeningState {
  @override
  List<Object?> get props => [];
}
class DeleteRekeningFavoritSuccess extends RekeningState{
  final Map<String, dynamic> dataResult;
  const DeleteRekeningFavoritSuccess(this.dataResult);
  @override
  List<Object> get props =>[dataResult];
}
class DeleteRekeningFavoritFailed extends RekeningState {
  final String e;
  const DeleteRekeningFavoritFailed(this.e);
  @override
  List<Object?> get props => [e];
}