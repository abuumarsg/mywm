import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/transfer_service.dart';

part 'maintenance_event.dart';
part 'maintenance_state.dart';

class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  MaintenanceBloc() : super(MaintenanceInitial()) {
    on<MaintenanceEvent>((event, emit) async {
      if(event is CekMaintenanceTransferBankLain) {
        try{
          emit(CekMaintenanceTransferBankLainLoading());
          Map<String, dynamic> datax = await TransferServices().serviceCekMaintenanceTransferBankLain(event.data);
          emit (CekMaintenanceTransferBankLainSuccess(datax));
        }catch (e) {
          emit(CekMaintenanceTransferBankLainFailed(e.toString()));
        }
      }
    });
  }
}
