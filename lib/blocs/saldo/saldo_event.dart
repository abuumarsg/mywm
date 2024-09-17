part of 'saldo_bloc.dart';

abstract class SaldoEvent extends Equatable {
  const SaldoEvent();

  // @override
  // List<Object> get props => [];
}
class LoadSaldo extends SaldoEvent{
  @override
  List<Object?> get props => [];
}
class RefreshSaldo extends SaldoEvent{
  @override
  List<Object?> get props => [];
}
//===================================
class LoadRekeningFavorit extends SaldoEvent{
  @override
  List<Object?> get props => [];
}
class LoadRekeningFavorit2 extends SaldoEvent{
  @override
  List<Object?> get props => [];
}
class LoadListBankLain extends SaldoEvent{
  @override
  List<Object?> get props => [];
}
class getVirtualAccount extends SaldoEvent {
  final String rekening;
  const getVirtualAccount(this.rekening);
  @override
  List<Object?> get props => [rekening];
}
