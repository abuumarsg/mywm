import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myWM/models/kredit_model.dart';
import 'package:logger/logger.dart';

import '../../models/deposito_model.dart';
import '../../models/list_bank_model.dart';
import '../../models/login_form_model.dart';
import '../../models/rekening_favorit_model.dart';
import '../../models/saldo_model.dart';
// import '../../models/user_model.dart';
import '../../models/va_model.dart';
import '../../services/auth_service.dart';
import '../../services/saldo_service.dart';
// import '../../shared/global_data.dart';

part 'saldo_event.dart';
part 'saldo_state.dart';

class SaldoBloc extends Bloc<SaldoEvent, SaldoState> {
  var logger = Logger();
  SaldoBloc() : super(SaldoInitial()) {
    on<SaldoEvent>((event, emit) async {
      if(event is LoadSaldo){
        try {
          final SignInFormModel data = await AuthServices().getCredentialFromLocal();
          List<SaldoModel> saldo = await SaldoServices.getSaldo(data); 
          // List<DepositoModel> deposito = await SaldoServices.getSaldoDeposito(data); 
          // List<KreditModel> kredit = await SaldoServices.getSaldoKredit(data); 
          // emit (Saldoloaded(saldo, deposito, kredit));
          emit (SaldoTabunganloaded(saldo));
        } catch (e) {
          emit(LoadSaldoFailed(e.toString()));
        }
      }
      if(event is RefreshSaldo){
        try {
          emit (SaldoInitial());
        } catch (e) {
          emit(LoadSaldoFailed(e.toString()));
        }
      }
      if(event is LoadRekeningFavorit){
        try {
          emit (RekFavoritloading());
          final SignInFormModel data = await AuthServices().getCredentialFromLocal();
          List<RekFavModel> rekening = await SaldoServices.getRekeningFavorit(data);
          // globalListFavorit = rekening;
          emit (RekFavoritloaded(rekening));
        } catch (e) {
          emit(LoadRekFavFailed(e.toString()));
        }
      }
      if(event is LoadListBankLain){
        try {
          emit (ListBankLainloading());
          final SignInFormModel data = await AuthServices().getCredentialFromLocal();
          List<ListBankModel> listBank = await SaldoServices.getListBankLain(data);
          emit (ListBankLainLoaded(listBank));
        } catch (e) {
          emit(LoadListBankLainFailed(e.toString()));
        }
      }
      if(event is getVirtualAccount){
        try {
          emit (GetVirtualAccountLoading());
          List<VAModel> listva = await SaldoServices().userRequestVirtualAccount(event.rekening);
          emit (GetVirtualAccountSuccess(listva));
        } catch (e) {
          emit(GetVirtualAccountFailed(e.toString()));
        }
      }
    });
  }
}
