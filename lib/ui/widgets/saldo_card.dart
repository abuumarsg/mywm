import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/ui/pages/main/mutasi_tabungan.dart';

import '../../blocs/saldo/saldo_bloc.dart';
import '../../models/saldo_model.dart';
import '../../shared/theme.dart';
import '../pages/main/virtual_account.dart';

class saldoCard extends StatelessWidget {
  final SaldoModel saldo;
  const saldoCard(this.saldo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10.sp,
        right: 10.sp,
        top: 10.sp,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: blueBackgroundColor, width: 1),
      ),
      child: Wrap(
        children: [
          Container(
            height: 50.sp,
            width: 350.sp,
            decoration : BoxDecoration(
              color: blueBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border.all(color: blueBackgroundColor, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Nomor Rekening : ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    saldo.nomorRekening,
                    style: whiteTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 210.sp,
            width: 320.sp,
            decoration : BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      saldo.keterangan,
                      style: blackTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  SizedBox(height:10.sp),
                  Center(
                    child: Text(
                      'Rp. ${saldo.saldoEfektif!}',
                      style: blackTextStyle.copyWith(
                        fontSize: 24.sp,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  SizedBox(height:20.sp),
                  if(saldo.keterangan == 'TABUNGAN MAKMUR')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Saldo Pembukuan',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                          Text(
                            'Rp. ${saldo.saldoAkhir}',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nilai yang diblokir',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                          Text(
                            'Rp. ${saldo.saldoBlokir!}',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dana dapat dipakai',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                          Text(
                            'Rp. ${saldo.saldoEfektif!}',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if(saldo.keterangan == 'TABUNGAN RENCANA')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal Jatuh Tempo',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                          Text(
                            saldo.tglJatuhtempoIndo!,
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30.sp,
                        width:140.sp,
                        child: TextButton(
                          onPressed: ()  {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                              builder: ( context) => MutasiTabunganPage(dataRek: saldo.nomorRekening),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: blueBackgroundColor, width: 2)
                            ),
                          ),
                          child: Text(
                            'Lihat Mutasi',
                            style: darkBlueTextStyle.copyWith(
                              fontSize: 9.sp,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                      if(saldo.keterangan == 'TABUNGAN MAKMUR')
                      SizedBox(
                        height: 30.sp,
                        width:140.sp,
                        child: TextButton(
                          onPressed: ()  {
                            String nomorRekening = saldo.nomorRekening;
                            context.read<SaldoBloc>().add(getVirtualAccount(nomorRekening));
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                              builder: ( context) => VirtualAccountPage(nomorRekening: saldo.nomorRekening),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: blueBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Virtual Account',
                            style: whiteTextStyle.copyWith(
                              fontSize: 9.sp,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
