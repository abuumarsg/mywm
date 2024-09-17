part of 'maintenance_bloc.dart';

abstract class MaintenanceState extends Equatable {
  const MaintenanceState();
  
  @override
  List<Object> get props => [];
}

class MaintenanceInitial extends MaintenanceState {}

//=====================================================================
class CekMaintenanceTransferBankLainLoading extends MaintenanceState {}
class CekMaintenanceTransferBankLainSuccess extends MaintenanceState { 
  final Map<String, dynamic> dataResult;
  const CekMaintenanceTransferBankLainSuccess(this.dataResult);
  @override
  List<Object> get props => [dataResult];
}
class CekMaintenanceTransferBankLainFailed extends MaintenanceState {
  final String e;
  const CekMaintenanceTransferBankLainFailed(this.e);
  @override
  List<Object> get props => [e];
}