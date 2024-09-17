part of 'satu_bloc.dart';

abstract class SatuEvent extends Equatable {
  const SatuEvent();
}
//========================================================================= MY WM =======================================================
class LoadSaldoMyWm extends SatuEvent{
  @override
  List<Object?> get props => [];
}
class ResetSaldoState extends SatuEvent{
  @override
  List<Object?> get props => [];
}
