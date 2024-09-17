import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../models/form_transfer_sesama_model.dart';
import '../../models/transfer_sesama_model.dart';
import '../../services/transfer_service.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  var logger = Logger();
  TransferBloc() : super(TransferInitial()) {
    on<TransferEvent>((event, emit) async {
      if(event is TransferSesamaCekPenerima) {
        try{
          emit(CekPenerimaLoading());
          TransferSesamaModel users = await TransferServices().cekPenerimaSesama(event.data);
          emit (CekPenerimaSuccess(users));
        }catch (e) {
          emit(CekPenerimaFailed(e.toString()));
        }
      }
      if(event is TransferSesamaOTP) {
        try{
          emit(TfSesamaSendOTPLoading());
          Map<String, dynamic> datax = await TransferServices().transferSesamaSendOTP(event.data);
          emit (TfSesamaSendOTPSuccess(datax));
        }catch (e) {
          emit(TfSesamaSendOTPFailed(e.toString()));
        }
      }
      if(event is TransferSesamaSendValidasiOTP) {
        try{
          emit(TfSesamaSendOTPValidasiLoading());
          Map<String, dynamic> datax = await TransferServices().transferSesamaSendValidasiOTP(event.data);
          emit (TfSesamaSendOTPValidasiSuccess(datax));
        }catch (e) {
          emit(TfSesamaSendOTPValidasiFailed(e.toString()));
        }
      }
      if(event is TransferSesamaSendValidasiPIN) {
        try{
          emit(TfSesamaSendPINValidasiLoading());
          Map<String, dynamic> datax = await TransferServices().transferSesamaSendValidasiPIN(event.data);
          emit (TfSesamaSendPINValidasiSuccess(datax));
        }catch (e) {
          emit(TfSesamaSendPINValidasiFailed(e.toString()));
        }
      }
      //================================================== TRANSFER LAIN BANK ======================================================
      if(event is TransferBankLainCekPenerima) {
        try{
          emit(TransferBankLainCekPenerimaLoading());
          Map<String, dynamic> datax = await TransferServices().transferBankLainCekPenerima(event.data);
          emit (TransferBankLainSuccess(datax));
        }catch (e) {
          emit(TransferBankLainFailed(e.toString()));
        }
      }
      //================================================== REKENING KREDIT ======================================================
      if(event is PengajuanRekeningKredit) {
        try{
          emit(PengajuanRekeningKreditLoading());
          Map<String, dynamic> datax = await TransferServices().servicePengajuanRekeningKredit(event.data);
          emit (PengajuanRekeningKreditSuccess(datax));
        }catch (e) {
          emit(PengajuanRekeningKreditFailed(e.toString()));
        }
      }
      if(event is KirimUlangOTPRekeningKredit) {
        try{
          emit(KirimUlangOTPRekeningKreditLoading());
          Map<String, dynamic> datax = await TransferServices().serviceKirimUlangOTPRekeningKredit(event.data);
          emit (KirimUlangOTPRekeningKreditSuccess(datax));
        }catch (e) {
          emit(KirimUlangOTPRekeningKreditFailed(e.toString()));
        }
      }
      if(event is ValidasiOTPRekeningKredit) {
        try{
          emit(ValidasiOTPRekeningKreditLoading());
          Map<String, dynamic> datax = await TransferServices().serviceValidasiOTPRekeningKredit(event.data);
          emit (ValidasiOTPRekeningKreditSuccess(datax));
        }catch (e) {
          emit(ValidasiOTPRekeningKreditFailed(e.toString()));
        }
      }
      if(event is ValidasiPINRekeningKredit) {
        try{
          emit(ValidasiPINRekeningKreditLoading());
          Map<String, dynamic> datax = await TransferServices().serviceValidasiPINRekeningKredit(event.data);
          emit (ValidasiPINRekeningKreditSuccess(datax));
        }catch (e) {
          emit(ValidasiPINRekeningKreditFailed(e.toString()));
        }
      }
      //====================================================== MY WM ===============================================================================
      if(event is GetDataTransaksiTerakhir){
        try {
          emit(TransaksiTerakhirLoading());
          Map<String, dynamic> riwayat = await TransferServices().loadDataRiwayatTransaksiTabUtama(event.rekening);
          emit (TransaksiTerakhirSuccess(riwayat));
        } catch (e) {
          var error = (e=='') ? 'Silahkan Muat Ulang Aplikasi Anda' : e;
          emit(TransaksiTerakhirFailed(error.toString()));
        }
      }
    });
  }
}
