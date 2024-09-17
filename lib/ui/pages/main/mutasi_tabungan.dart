import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:myWM/shared/global_data.dart';
import 'package:logger/logger.dart';
import '../../../blocs/rekening/rekening_bloc.dart';
import '../../../models/data_mutasi_model.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/card_mutasi_rekening.dart';
String formattedMonthAndYear = DateFormat.yMMMM('id').format(dateNowWm);
DateTime satuBulanLalu = dateNowWm.subtract(const Duration(days: 30 * 1));
String formattedsatuBulanLalu = DateFormat.yMMMM('id').format(satuBulanLalu);
DateTime duaBulanLalu = dateNowWm.subtract(const Duration(days: 30 * 2));
String formattedduaBulanLalu = DateFormat.yMMMM('id').format(duaBulanLalu);

class MutasiTabunganPage extends StatefulWidget {
  final String dataRek;
  const MutasiTabunganPage({super.key, required this.dataRek});
  @override
  State<MutasiTabunganPage> createState() => _MutasiTabunganPageState(dataRek);
}

class _MutasiTabunganPageState extends State<MutasiTabunganPage> {
  _MutasiTabunganPageState(this.dataRek);
  String dataRek;
  var logger = Logger();
  String _selectedOptionRek = "";
  String _selectedOptionTrx = '30 Hari Terakhir';
  List ListWaktuPilihanMutasi = [
    '30 Hari Terakhir',
    formattedMonthAndYear,
    formattedsatuBulanLalu,
    formattedduaBulanLalu,
  ];
  @override
  void initState() {
    super.initState();
    _selectedOptionRek = dataRek.isNotEmpty ? dataRek : globalListRekening[0];
    _getDataMutasi(_selectedOptionRek, _selectedOptionTrx);
  }

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        context.read<RekeningBloc>().add(ResetSaldoEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Mutasi Tabungan',
            style: whiteTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
          ),
          backgroundColor: blueBackgroundColor,
          centerTitle: true,
        ),
        backgroundColor: blueBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                SizedBox(
                  height: 40.sp,
                  child: GestureDetector(
                    onTap: () {
                      _openModalRekening();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rekening',
                              style: blackTextStyle.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              _selectedOptionRek,
                              style: blackTextStyle.copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: blueBackgroundColor,
                          size: 25.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 40.sp,
                  child: GestureDetector(
                    onTap: () {
                      _openModalTrx();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Transaksi',
                              style: blackTextStyle.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              _selectedOptionTrx,
                              style: blackTextStyle.copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: blueBackgroundColor,
                          size: 25.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: BlocBuilder<RekeningBloc, RekeningState>(
                    builder: (_, RekeningState) {
                      // logger.i(RekeningState);
                      if(RekeningState is LoadHistoryMutasiFailed){
                        Future.delayed(Duration.zero,(){
                          showCustomSnackBar(context, '${RekeningState.e}, Please Reload Application');
                          Timer(const Duration(seconds: 3),(){
                            Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
                          });
                        });
                      }
                      if(RekeningState is Rekeningloaded){
                        _.read<RekeningBloc>().add(getDataMutasi(_selectedOptionRek, _selectedOptionTrx));
                      }
                      if(RekeningState is DataHistoryMutasiLoad){
                        EasyLoading.dismiss();
                        List<DataMutasiModel> rekening = RekeningState.dataMutasi;
                        if(rekening.isNotEmpty){
                          return SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: rekening.length,
                              itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.all(2),
                                child: cardMutasiRekening(rekening[index]),
                              ),
                            ),
                          );
                        }else{
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 90.sp,
                                child: Text(
                                  'Tidak Ada Transaksi',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }else{
                        return SpinKitFadingCircle(
                          color: blueBackgroundColor,
                          size: 50,
                        );
                      }
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openModalRekening() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'Pilih Rekening',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: globalListRekening.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    globalListRekening[index],
                    style: blackTextStyle.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  onTap: () {
                    _selectOption(globalListRekening[index]);
                    _getDataMutasi(globalListRekening[index], _selectedOptionTrx);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  _openModalTrx() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: blueBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Pilih Tanggal',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ListWaktuPilihanMutasi.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      ListWaktuPilihanMutasi[index],
                      style: blackTextStyle.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    onTap: () {
                      _selectOptionTrx(ListWaktuPilihanMutasi[index]);
                      _getDataMutasi(_selectedOptionRek, ListWaktuPilihanMutasi[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _selectOption(String option) {
    setState(() {
      _selectedOptionRek = option;
    });
  }

  _selectOptionTrx(String option) {
    setState(() {
      _selectedOptionTrx = option;
    });
  }

  _getDataMutasi(String rekening, String tanggal) {
    setState(() {
      context.read<RekeningBloc>().add(getDataMutasi(rekening,tanggal));
      // print(rekening);
      // print(tanggal);
    });
  }
}
