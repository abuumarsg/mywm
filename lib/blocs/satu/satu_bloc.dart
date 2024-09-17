import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myWM/models/login_form_model.dart';
import 'package:myWM/models/saldo_model.dart';
import 'package:myWM/services/auth_service.dart';

import '../../services/saldo_service.dart';

part 'satu_event.dart';
part 'satu_state.dart';

class SatuBloc extends Bloc<SatuEvent, SatuState> {
  SatuBloc() : super(SatuInitial()) {
    on<SatuEvent>((event, emit) async {
      //=========================================== MY WM =======================================================================
      if(event is LoadSaldoMyWm){
        try {
          emit (GetSaldoUtamaLoading());
          final SignInFormModel data = await AuthServices().getCredentialFromLocal();
          List<SaldoUtamaModel> saldo = await SaldoServices.getSaldoUtama(data); 
          emit (GetSaldoUtamaSuccess(saldo));
        } catch (e) {
          emit(GetSaldoUtamaFailed(e.toString()));
        }
      }
    });
  }
}
