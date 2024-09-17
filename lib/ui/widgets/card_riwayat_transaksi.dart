import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:logger/logger.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
// import '../../models/data_mutasi_model.dart';
import '../../models/data_riyawat_transaksi.dart';
import '../../shared/theme.dart';

// ignore: camel_case_types
class cardRiwayatTransaksi extends StatelessWidget {
  final DataRiwayatTransaksi mutasi;
  const cardRiwayatTransaksi(this.mutasi, {super.key});

  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    // Map<String, dynamic> datax = {
    //   "nomorRekening": mutasi.nomorRekening.toString(),
    //   "namaBankTujuan": mutasi.namaBankTujuan.toString(),
    //   "nominal": mutasi.nominal.toString(),
    //   "tanggal": mutasi.tanggal.toString(),
    //   "rekeningTujuan": mutasi.rekeningTujuan.toString(),
    //   "atasNamaTujuan": mutasi.atasNamaTujuan.toString(),
    //   "biayaAdmin": mutasi.biayaAdmin.toString(),
    //   "nominalBiayaAdmin": mutasi.nominalBiayaAdmin.toString(),
    //   "flag": mutasi.flag.toString(),
    //   "nomorSlip": mutasi.nomorSlip.toString(),
    //   "kodePbk": mutasi.kodePbk.toString(),
    //   "berita": mutasi.berita.toString(),
    //   "waktuTransaksi": mutasi.waktuTransaksi.toString(),
    //   "biayaAdminSlip": mutasi.biayaAdminSlip.toString(),
    //   "norefId": mutasi.norefId.toString(),
    //   "namaSumber": mutasi.namaSumber.toString(),
    // };
    return 
    Column(
      children: [
        SizedBox(
          height: 90.sp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mutasi.namaBankTujuan,
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      width: 180.sp,
                      child: Text(
                      '${mutasi.rekeningTujuan} AN ${mutasi.atasNamaTujuan!}',
                        style: blackTextStyle.copyWith(
                          fontSize: 12.sp,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    mutasi.flag! == '*' ? 'Proses'
                    : mutasi.flag! == 'Y' ? 'Berhasil'
                    : mutasi.flag! == 'B' ? 'Tolak'
                    : mutasi.flag! == 'BN' ? 'Dibatalkan'
                    : '',
                    style:  ((mutasi.flag! == '*') ? yellowTextStyle
                    : (mutasi.flag! == 'Y') ? greenTextStyle
                    : redTextStyle).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    mutasi.tanggal!,
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    mutasi.nominal,
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        RoundedBackgroundTextSpan(
                          text: mutasi.nominalBiayaAdmin!,
                          backgroundColor: mutasi.biayaAdmin == '0.00' ? greenColor : redColor,
                          style: whiteTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: medium,
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
        if( mutasi.flag! == 'Y')
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                // print('cetak');
                // logger.i(datax);
                // Navigator.pushNamed(context, '/lupa_password');
                Navigator.pushNamed(context, '/transfer_send_bukti_wm', arguments: {
                  "nomorRekening": mutasi.nomorRekening.toString(),
                  "namaBankTujuan": mutasi.namaBankTujuan.toString(),
                  "nominal": mutasi.nominal.toString(),
                  "tanggal": mutasi.tanggal.toString(),
                  "rekeningTujuan": mutasi.rekeningTujuan.toString(),
                  "atasNamaTujuan": mutasi.atasNamaTujuan.toString(),
                  "biayaAdmin": mutasi.biayaAdmin.toString(),
                  "nominalBiayaAdmin": mutasi.nominalBiayaAdmin.toString(),
                  "flag": mutasi.flag.toString(),
                  "nomorSlip": mutasi.nomorSlip.toString(),
                  "kodePbk": mutasi.kodePbk.toString(),
                  "berita": mutasi.berita.toString(),
                  "waktuTransaksi": mutasi.waktuTransaksi.toString(),
                  "biayaAdminSlip": mutasi.biayaAdminSlip.toString(),
                  "norefId": mutasi.norefId.toString(),
                  "namaSumber": mutasi.namaSumber.toString(),
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Text.rich(
                TextSpan(
                  text: 'Bagikan Bukti Transaksi ',
                  style: TextStyle(fontSize: 12.sp, color: blueColor),
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: Icon(Icons.share, color: blueColor, size: 12.sp),
                      ),
                    ),
                    // TextSpan(
                    //   text: 'Flutter',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Text(
        //       mutasi.nomorSlip!,
        //     ),
        //     Text(
        //       mutasi.kodePbk!,
        //     ),
        //   ],
        // ),
        Divider(),
      ],
    );
  }
}
