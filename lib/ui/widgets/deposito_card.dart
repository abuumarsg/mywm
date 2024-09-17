
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/deposito_model.dart';
import '../../shared/theme.dart';

class depositoCard extends StatelessWidget {
  final DepositoModel deposito;
  const depositoCard(this.deposito, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10.sp,
        right: 10.sp,
        top: 10.sp,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 17.sp,
        vertical: 12.sp,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: greyColor, width: 1),
      ),
      child: Wrap(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       deposito.keterangan,
          //       style: blackTextStyle.copyWith(
          //         fontWeight: black,
          //         fontSize: 16.sp,
          //       ),
          //     ),
          //     Icon(Icons.credit_card, color: blueColor, size: 20.sp),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Text(
          //       deposito.nomorRekening,
          //       style: blackTextStyle.copyWith(
          //         fontWeight: medium,
          //         fontSize: 12.sp,
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10.sp,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       'Rp. ${deposito.saldoAkhir}',
          //       style: blackTextStyle.copyWith(
          //         fontWeight: semiBold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10.sp,
          // ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deposito.keterangan,
                    style: blackTextStyle.copyWith(
                      fontWeight: black,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    deposito.nomorRekening,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                'Rp. ${deposito.saldoAkhir}',
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 18.sp,
                ),
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tgl Jatuh Tempo',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      deposito.tglJatuhtempoIndo!,
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
