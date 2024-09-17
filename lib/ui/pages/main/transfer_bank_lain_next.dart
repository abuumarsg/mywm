import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import '../../../blocs/transfer/transfer_bloc.dart';
// import '../../../models/transfer_sesama_model.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';
import 'transfer_need_otp.dart';

class TransferBankLainNext extends StatefulWidget {
  final Map<String, dynamic> dataTransfer;
  const TransferBankLainNext({
    super.key,
    required this.dataTransfer,
  });
  // const TransferBankLainNext({super.key, required Map<String, dynamic> dataTransfer});

  @override
  State<TransferBankLainNext> createState() =>
      _TransferBankLainNextState(dataTransfer);
}

class _TransferBankLainNextState extends State<TransferBankLainNext> {
  var logger = Logger();
  _TransferBankLainNextState(this.dataTransfer);
  final Map<String, dynamic> dataTransfer;
  bool beFavorit = false;

  @override
  Widget build(BuildContext context) {
    // logger.i(dataTransfer);
    // final Object? args = ModalRoute.of(context)!.settings.arguments;
    // Map<String, dynamic>? jsonData = args as Map<String, dynamic>?;
    Map<String, dynamic> jsonData = dataTransfer as Map<String, dynamic>;
    // logger.i(jsonData);
    Map<String, dynamic> datax = {
      "nomorRekening": jsonData['nomorRekening'],
      "nomorRekeningTujuan": jsonData['nomorRekeningTujuan'],
      "nominalPengirim": jsonData['nominalPengirim'],
      "nominalTransfer": jsonData['nominalTransfer'],
      "namaPenerima": jsonData['namaPenerima'],
      "jenisTabunganPengirim": jsonData['jenisTabunganPengirim'],
      "keterangan": jsonData['keterangan'],
      "biayaAdmin": jsonData['biayaAdmin'].toString(),
      "nomorSlip": jsonData['nomorSlip'],
      "nomorTelp": jsonData['nomorTelp'],
      "favorit": beFavorit ? "1" : "0",
    };
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Konfirmasi Transfer',
          style: whiteTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueBackgroundColor,
        centerTitle: true,
      ),
      backgroundColor: blueBackgroundColor,
      body: BlocConsumer<TransferBloc, TransferState>(
        listener: (context, transferState) {
          // logger.i(transferState);
          if(transferState is TfSesamaSendOTPLoading){
            showLoadingIndicator();
          }
          if(transferState is TfSesamaSendOTPFailed){
            EasyLoading.dismiss();
            showCustomSnackBar(context, transferState.e);
          }
          if(transferState is CekAutorFailed){
            EasyLoading.dismiss();
            Future.delayed(Duration.zero,(){
              showCustomSnackBar(context, '${transferState.e}, Please Reload Application');
              // Timer(const Duration(seconds: 3),(){
              //   Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
              // });
            });
          }
          if(transferState is TfSesamaSendOTPSuccess){
            EasyLoading.dismiss();
            // logger.i(transferState.dataOTP);
            Navigator.push(
              context, 
              MaterialPageRoute(
               builder: ( context) => TransferSesamaWMNeedOTP(dataOTP: transferState.dataOTP),
              ),
            );
          }
        },
        builder: (context, transferState) {
          return Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                  height: 200.sp,
                  margin: EdgeInsets.only(
                    left: 10.sp,
                    right: 10.sp,
                    top: 10.sp,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor, width: 1),
                  ),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nominal',
                              style: blackTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                jsonData['nominalTransfer'],
                                style: blackTextStyle.copyWith(
                                  fontSize: 25.sp,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Transfer Ke',
                              style: greyTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                jsonData['namaPenerima'],
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                jsonData['namaBank'],
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                jsonData['nomorRekeningTujuan'],
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 14.sp,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  RoundedBackgroundTextSpan(
                                    text: 'Biaya Admin',
                                    backgroundColor: Colors.amber,
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: jsonData['biayaAdmin'] == 0
                                        ? 'GRATIS'
                                        : jsonData['biayaAdmin'],
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.sp,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '  Transfer Dari',
                        style: greyTextStyle.copyWith(
                          fontWeight: black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50.sp,
                  margin: EdgeInsets.only(
                    left: 10.sp,
                    right: 10.sp,
                    top: 10.sp,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor, width: 1),
                  ),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${jsonData['jenisTabunganPengirim']} (${jsonData['nomorRekening']})',
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 90.sp,
                  margin: EdgeInsets.only(
                    left: 10.sp,
                    right: 10.sp,
                    top: 10.sp,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor, width: 1),
                  ),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${jsonData['keterangan']}',
                              style: blackTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5.sp,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                            (beFavorit) ? Icons.favorite : Icons.favorite_border),
                        onPressed: () {
                          setState(() {
                            if (beFavorit == true) {
                              beFavorit = false;
                            } else {
                              beFavorit = true;
                            }
                          });
                        },
                        color: beFavorit ? redColor : blackColor,
                      ),
                      Text(
                        'Simpan Sebagai Favorit',
                        style: blackTextStyle.copyWith(
                          fontWeight: black,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.sp,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10.sp,
                    right: 10.sp,
                    top: 10.sp,
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        'Pastikan nominal dan nomor rekening yang dimasukkan sudah sesuai. Jika terdapat kesalahan data, maka sepenuhnya menjadi tanggung jawab nasabah.',
                        style: greyTextStyle.copyWith(
                          fontWeight: black,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  child: Column(
                    children: [
                      CustomFilledButton2(
                        title: 'Minta OTP',
                        onPressed: () {
                          context.read<TransferBloc>().add(TransferSesamaOTP(datax));
                        },
                        width: 400.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45.sp,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
