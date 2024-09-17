import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/maintenance/maintenance_bloc.dart';
import '../../../blocs/rekening/rekening_bloc.dart';
import '../../../blocs/saldo/saldo_bloc.dart';
import '../../../blocs/transfer/transfer_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
class PerintahTransferPage extends StatefulWidget {
  PerintahTransferPage({super.key});

  @override
  State<PerintahTransferPage> createState() => _PerintahTransferPageState();
}

class _PerintahTransferPageState extends State<PerintahTransferPage> {
  final blocRekening = RekeningBloc();
  final blocSaldo = SaldoBloc();
  final blocTransfer = TransferBloc();
  final blocMaintenance = MaintenanceBloc();

  @override
  void initState() {
    super.initState();
    refreshDateNowWm();
  }

  bool stopState = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // refreshDateNowWm();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Perintah Transfer',
            style: whiteTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
          ),
          backgroundColor: blueBackgroundColor,
          // toolbarHeight: 45.sp,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
        ),
        backgroundColor: blueBackgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<MaintenanceBloc, MaintenanceState>(
              listener: (context, state) {
                // logger.i(state);
                if (state is CekMaintenanceTransferBankLainFailed) {
                  hideLoadingIndicator();
                  showCustomSnackBarTime(context, state.e, detik: 20);
                  setState(() => _isLoading = false);
                } else if (state is CekMaintenanceTransferBankLainLoading) {
                  setState(() => _isLoading = true);
                } else if (state is CekMaintenanceTransferBankLainSuccess) {
                  setState(() => _isLoading = false);
                  _proceedToTransfer(context);
                }
              },
            ),
            BlocListener<RekeningBloc, RekeningState>(
              listener: (context, state) {
                // logger.i(state);
                if (state is RekeningForTransferFailed) {
                  hideLoadingIndicator();
                  showCustomSnackBar(context, 'Gagal Memuat Rekening Transfer, ${state.e}');
                  setState(() => _isLoading = false);
                } else if (state is RekeningForTransferLoading) {
                  setState(() => _isLoading = true);
                } else if (state is DataRekeningForTransfer) {
                  setState(() => _isLoading = false);
                  hideLoadingIndicator();
                  Navigator.pushNamed(context, '/transfer_bank_lain').then((_) {
                    // context.read<MaintenanceBloc>().add(ResetMaintenanceState());
                    // context.read<RekeningBloc>().add(LoadRekening());
                  });
                }
              },
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: (){
                    // Navigator.pushNamed(context, '/transfer_sesama_wm');
                    blocSaldo.add(LoadRekeningFavorit());
                    blocRekening.add(const getRekeningTransfer());
                    blocRekening.stream.listen((stateR) {
                      if (stateR is RekeningForTransferFailed) {
                        Future.delayed(Duration.zero,(){
                          showCustomSnackBar(context, 'Gagal Memuat Rekening Transfer, ${stateR.e}');
                        });
                      }
                      if (stateR is RekeningForTransferLoading) {
                        showLoadingIndicator();
                      }
                      if (stateR is DataRekeningForTransfer) {
                        hideLoadingIndicator();
                        Navigator.pushNamed(context, '/transfer_sesama_wm');
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:40.sp, left:50.sp, bottom: 20.sp),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ke Sesama Rekening Bank WM',
                                style: darkBlueTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:5.sp),
                                child: Text(
                                  'Perintah transfer dana ke sesama rekening Bank WM',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: regular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60.sp,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 21.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    showLoadingIndicator();
                    if (!_isLoading) {
                      context.read<MaintenanceBloc>().add(const CekMaintenanceTransferBankLain('cek'));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:20.sp, left:50.sp, bottom: 20.sp),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ke Rekening Bank Lain',
                                style: darkBlueTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:5.sp),
                                child: Text(
                                  'Perintah transfer dana ke rekening Bank lain',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: regular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60.sp,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 21.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite');
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:20.sp, left:50.sp, bottom: 20.sp),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ke Rekening Favorit',
                                style: darkBlueTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:5.sp),
                                child: Text(
                                  'Perintah transfer ke rekening yang disimpan sebagai rekening favorit',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: regular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60.sp,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 21.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                // GestureDetector(
                //   onTap: (){
                //     // Navigator.pushNamed(context, '/transfer_sesama_wm');
                //     blocSaldo.add(LoadRekeningFavorit());
                //     blocRekening.add(const getRekeningTransfer());
                //     blocRekening.stream.listen((stateR) {
                //       if (stateR is RekeningForTransferFailed) {
                //         Future.delayed(Duration.zero,(){
                //           showCustomSnackBar(context, 'Gagal Memuat Rekening Transfer, ${stateR.e}');
                //         });
                //       }
                //       if (stateR is RekeningForTransferLoading) {
                //         showLoadingIndicator();
                //       }
                //       if (stateR is DataRekeningForTransfer) {
                //         hideLoadingIndicator();
                //         Navigator.pushNamed(context, '/transfer_sesama_wm');
                //       }
                //     });
                //   },
                //   child: Container(
                //     height: 60.sp,
                //     margin: EdgeInsets.only(
                //       left: 20.sp,
                //       right: 20.sp,
                //       top: 10.sp,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       image: const DecorationImage(
                //         image: AssetImage("asset/transfer-wm.png"),
                //       ),
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     showLoadingIndicator();
                //     if (!_isLoading) {
                //       context.read<MaintenanceBloc>().add(const CekMaintenanceTransferBankLain('cek'));
                //     }
                //   },
                //   child: Container(
                //     height: 60.sp,
                //     margin: EdgeInsets.only(
                //       left: 20.sp,
                //       right: 20.sp,
                //       top: 10.sp,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       image: const DecorationImage(
                //         image: AssetImage("asset/transfer-lain.png"),
                //       ),
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: (){
                //     blocRekening.add(LoadRekening());
                //     blocRekening.stream.listen((stateR) {
                //       if (stateR is LoadRekeningFailed) {
                //         Future.delayed(Duration.zero,(){
                //           showCustomSnackBar(context, 'Gagal Memuat Rekening, ${stateR.e}');
                //         });
                //       }
                //       if (stateR is RekeningLoading) {
                //         showLoadingIndicator();
                //       }
                //       if (stateR is Rekeningloaded) {
                //         hideLoadingIndicator();
                //         Future.delayed(Duration.zero,(){
                //           Navigator.pushNamed(context, '/riwayat_transaksi');
                //         });
                //       }
                //     });
                //   },
                //   child: Container(
                //     height: 60.sp,
                //     margin: EdgeInsets.only(
                //       left: 20.sp,
                //       right: 20.sp,
                //       top: 10.sp,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       image: const DecorationImage(
                //         image: AssetImage("asset/transfer-mutasi.png"),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _proceedToTransfer(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      context.read<SaldoBloc>().add(LoadRekeningFavorit());
      context.read<SaldoBloc>().add(LoadListBankLain());
      context.read<RekeningBloc>().add(const getRekeningTransfer());
      await for (final state in context.read<RekeningBloc>().stream) {
        if (state is RekeningForTransferFailed) {
          showCustomSnackBar(context, 'Gagal Memuat Rekening Transfer: ${state.e}');
          break;
        }
      }
      await for (final state in context.read<SaldoBloc>().stream) {
        if (state is LoadListBankLainFailed) {
          showCustomSnackBar(context, 'Gagal Memuat List Bank: ${state.e}');
          break;
        }
        if (state is LoadRekFavFailed) {
          showCustomSnackBar(context, 'Gagal Memuat Rekening Favorit: ${state.e}');
          break;
        }
      }
    } catch (e) {
      showCustomSnackBar(context, 'Terjadi kesalahan: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }
}