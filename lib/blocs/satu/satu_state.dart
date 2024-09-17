part of 'satu_bloc.dart';

abstract class SatuState extends Equatable {
  const SatuState();
}

class SatuInitial extends SatuState {
  @override
  List<Object> get props => [];
}

//================================= MY WM ======================================
class GetSaldoUtamaLoading extends SatuState {
  @override
  List<Object> get props => [];
}
class GetSaldoUtamaSuccess extends SatuState { 
  final List<SaldoUtamaModel> dataResult;
  const GetSaldoUtamaSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class GetSaldoUtamaFailed extends SatuState {
  final String e;
  const GetSaldoUtamaFailed(this.e);
  @override
  List<Object> get props => [e];
}