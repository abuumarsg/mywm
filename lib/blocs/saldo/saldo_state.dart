part of 'saldo_bloc.dart';

abstract class SaldoState extends Equatable {
  const SaldoState();
  
  // @override
  // List<Object> get props => [];
}

//=====================================================================
class SaldoInitial extends SaldoState {
  @override
  List<Object?> get props => [];
}
class Saldoloaded extends SaldoState{
  final List<SaldoModel> saldo;
  final List<DepositoModel> deposito;
  final List<KreditModel> kredit;
  const Saldoloaded(this.saldo, this.deposito, this.kredit);
  @override
  List<Object> get props =>[saldo,deposito,kredit];
}
class SaldoTabunganloaded extends SaldoState{
  final List<SaldoModel> saldo;
  const SaldoTabunganloaded(this.saldo);
  @override
  List<Object> get props =>[saldo];
}
class LoadSaldoFailed extends SaldoState {
  final String e;
  const LoadSaldoFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//=====================================================================
class RekFavoritloading extends SaldoState {
  @override
  List<Object?> get props => [];
}
class RekFavoritloaded extends SaldoState{
  final List<RekFavModel> rekeningfavorit;
  const RekFavoritloaded(this.rekeningfavorit);
  @override
  List<Object> get props =>[rekeningfavorit];
}
class LoadRekFavFailed extends SaldoState {
  final String e;
  const LoadRekFavFailed(this.e);
  @override
  List<Object?> get props => [e];
}
//=====================================================================
class ListBankLainloading extends SaldoState {
  @override
  List<Object?> get props => [];
}
class ListBankLainLoaded extends SaldoState{
  final List<ListBankModel> rekeningfavorit;
  const ListBankLainLoaded(this.rekeningfavorit);
  @override
  List<Object> get props =>[rekeningfavorit];
}
class LoadListBankLainFailed extends SaldoState {
  final String e;
  const LoadListBankLainFailed(this.e);
  @override
  List<Object?> get props => [e];
}

//=======================================================================
class GetVirtualAccountLoading extends SaldoState {
  @override
  List<Object> get props => [];
}
class GetVirtualAccountSuccess extends SaldoState { 
  final List<VAModel> dataResult;
  const GetVirtualAccountSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class GetVirtualAccountFailed extends SaldoState {
  final String e;
  const GetVirtualAccountFailed(this.e);
  @override
  List<Object> get props => [e];
}