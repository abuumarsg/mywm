part of 'maintenance_bloc.dart';

abstract class MaintenanceEvent extends Equatable {
  const MaintenanceEvent();
}

class ResetMaintenanceState extends MaintenanceEvent {
  @override
  List<Object?> get props => [];
}
class CekMaintenanceTransferBankLain extends MaintenanceEvent {
  final String data;
  const CekMaintenanceTransferBankLain(this.data);
  @override
  List<Object?> get props => [data];
}
