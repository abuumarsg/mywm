
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/data_mutasi_model.dart';
import '../../shared/theme.dart';

// ignore: camel_case_types
class cardMutasiRekening extends StatelessWidget {
  // const cardMutasiRekening({super.key});
  final DataMutasiModel mutasi;
  const cardMutasiRekening(this.mutasi, {super.key});

  @override
  Widget build(BuildContext context) {
    return 
    // Container(
      // margin: EdgeInsets.only(
      //   // left: 2.sp,
      //   // right: 2.sp,
      //   top: 2.sp,
      // ),
      // padding: EdgeInsets.symmetric(
      //   horizontal: 5.sp,
      //   vertical: 5.sp,
      // ),
      // decoration: BoxDecoration(
      //   // color: whiteColor,
      //   borderRadius: BorderRadius.circular(5),
      //   border: Border.all(color: greyColor, width: 1),
      // ),
    Column(
      children: [
        SizedBox(
          height: 90.sp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  width: 170.sp,
                  child: Text(
                    mutasi.keterangan,
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
                    (mutasi.jenis! == 'D') ? '-${mutasi.nominal}' : '+${mutasi.nominal}',
                    style: ((mutasi.jenis! == 'D') ? redTextStyle : greenTextStyle).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
