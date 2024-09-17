import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/saldo_service.dart';
import '../../shared/global_data.dart';

part 'dua_event.dart';
part 'dua_state.dart';

class DuaBloc extends Bloc<DuaEvent, DuaState> {
  DuaBloc() : super(DuaInitial()) {
    on<DuaEvent>((event, emit) async {
      if(event is LoadRekeningUtama){
        try {
          emit(RekeningUtamaLoading());
          const storage = FlutterSecureStorage();
          String? cif = await storage.read(key: 'cif');
          List rekening = await SaldoServices.getRekening(cif);
          globalListRekening = rekening;
          emit (LoadRekeningUtamaSuccess(rekening));
        } catch (e) {
          var error = (e=='') ? 'Silahkan Muat Ulang Aplikasi Anda' : e;
          emit(LoadRekeningUtamaFailed(error.toString()));
        }
      }
    });
  }
}
