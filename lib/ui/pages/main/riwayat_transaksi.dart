import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myWM/shared/global_data.dart';
import 'package:logger/logger.dart';
import '../../../blocs/rekening/rekening_bloc.dart';
import '../../../models/data_riyawat_transaksi.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/card_riwayat_transaksi.dart';
String formattedMonthAndYear = DateFormat.yMMMM('id').format(dateNowWm);
DateTime satuBulanLalu = dateNowWm.subtract(const Duration(days: 30 * 1));
String formattedsatuBulanLalu = DateFormat.yMMMM('id').format(satuBulanLalu);
DateTime duaBulanLalu = dateNowWm.subtract(const Duration(days: 30 * 2));
String formattedduaBulanLalu = DateFormat.yMMMM('id').format(duaBulanLalu);

class RiwayatTransaksiPage extends StatefulWidget {
  @override
  _RiwayatTransaksiPageState createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  var logger = Logger();
  String _selectedOptionRek = globalListRekening[0];
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
    _getDataMutasi(_selectedOptionRek, _selectedOptionTrx);
  }

  @override
  Widget build(BuildContext context) {
    // logger.i(ListWaktuPilihanMutasi);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool cameFromPageD = ModalRoute.of(context)?.settings.name == '/riwayat_transaksi';
        if (cameFromPageD) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Riwayat Transaksi',
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
                    builder: (_, rekeningState) {
                      // logger.i(rekeningState);
                      if(rekeningState is LoadRiwayatTransaksiFailed){
                        Future.delayed(Duration.zero,(){
                          showCustomSnackBar(context, '${rekeningState.e}, Please Reload Application');
                          Timer(const Duration(seconds: 3),(){
                            Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
                          });
                        });
                      }
                      if(rekeningState is Rekeningloaded){
                        _.read<RekeningBloc>().add(getDataRiwayatTransaksi(_selectedOptionRek, _selectedOptionTrx));
                      }
                      if(rekeningState is DataRiwayatTransaksiSuccess){
                        EasyLoading.dismiss();
                        List<DataRiwayatTransaksi> data = rekeningState.dataRiwayatTransaksi;
                        if(data.isNotEmpty){
                          return SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.all(2),
                                child: cardRiwayatTransaksi(data[index]),
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
                        return cardLoadingAll(2);
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
                  'Pilih Waktu',
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
      context.read<RekeningBloc>().add(getDataRiwayatTransaksi(rekening,tanggal));
      // print(rekening);
      // print(tanggal);
    });
  }
}
