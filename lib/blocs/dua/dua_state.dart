part of 'dua_bloc.dart';

abstract class DuaState extends Equatable {
  const DuaState();
}

class DuaInitial extends DuaState {
  @override
  List<Object> get props => [];
}
class RekeningUtamaLoading extends DuaState {
  @override
  List<Object> get props => [];
}
class LoadRekeningUtamaSuccess extends DuaState { 
  final List rekening;
  const LoadRekeningUtamaSuccess(this.rekening);
  @override
  List<Object> get props =>[rekening];
}
class LoadRekeningUtamaFailed extends DuaState {
  final String e;
  const LoadRekeningUtamaFailed(this.e);
  @override
  List<Object> get props => [e];
}
