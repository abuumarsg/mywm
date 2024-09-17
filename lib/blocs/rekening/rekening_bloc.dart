import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:myWM/models/rekening_transfer_model.dart';
import '../../models/data_mutasi_model.dart';
import '../../models/data_riyawat_transaksi.dart';
import '../../services/saldo_service.dart';
import '../../shared/global_data.dart';

part 'rekening_event.dart';
part 'rekening_state.dart';

class RekeningBloc extends Bloc<RekeningEvent, RekeningState> {
  var logger = Logger();
  RekeningBloc() : super(RekeningInitial()) {
    on<RekeningEvent>((event, emit) async {
      // logger.i('Event diterima: $event');
      if(event is LoadRekening){
        try {
          emit(RekeningLoading());
          const storage = FlutterSecureStorage();
          String? cif = await storage.read(key: 'cif');
          List rekening = await SaldoServices.getRekening(cif);
          globalListRekening = rekening;
          emit (Rekeningloaded(rekening));
        } catch (e) {
          var error = (e=='') ? 'Silahkan Muat Ulang Aplikasi Anda' : e;
          emit(LoadRekeningFailed(error.toString()));
        }
      }
      if(event is getDataMutasi){
        try {
          emit(HistoryMutasiLoading());
          List<DataMutasiModel> mutasi = await SaldoServices().loadDataMutasiRekening(event.rekening, event.tanggal);
          emit (DataHistoryMutasiLoad(mutasi));
        } catch (e) {
          var error = (e=='') ? 'Silahkan Muat Ulang Aplikasi Anda' : e;
          emit(LoadHistoryMutasiFailed(error.toString()));
        }
      }
      if(event is getRekeningTransfer){
        try {
          emit(RekeningForTransferLoading());
          List<RekeningForTransferModel> rekeningTransfer = await SaldoServices.loadDataRekeningTransfer();
          globalListRekeningTransfer = rekeningTransfer;
          emit (DataRekeningForTransfer(rekeningTransfer));
        } catch (e) {
          var error = (e=='') ? 'Silahkan Muat Ulang Aplikasi Anda' : e;
          emit(RekeningForTransferFailed(error.toString()));
        }
      }
      if(event is getDataRiwayatTransaksi){
        try {
          emit(RiwayatTransaksiLoading());
          List<DataRiwayatTransaksi> mutasi = await SaldoServices().loadDataRiwayatTransaksi(event.rekening, event.tanggal);
          emit (DataRiwayatTransaksiSuccess(mutasi));
        } catch (e) {
          var error = (e=='') ? 'Silahkan Muat Ulang Aplikasi Anda' : e;
          emit(LoadRiwayatTransaksiFailed(error.toString()));
        }
      }
      if(event is DeleteRekeningFavorit) {
        try{
          emit(DeleteRekeningFavoritLoading());
          Map<String, dynamic> datax = await SaldoServices().deleteRekeningFavorit(event.data);
          emit (DeleteRekeningFavoritSuccess(datax));
        }catch (e) {
          emit(DeleteRekeningFavoritFailed(e.toString()));
        }
      }
      if (event is ResetSaldoEvent) {
        // logger.i('kembali');
        emit (RekeningInitial());
      }
    });
  }
}
