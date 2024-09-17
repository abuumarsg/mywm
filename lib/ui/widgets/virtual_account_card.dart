
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/models/va_model.dart';
import 'package:myWM/shared/share_methods.dart';
import '../../shared/theme.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myWM/ui/pages/main/mutasi_tabungan.dart';
// import '../../blocs/saldo/saldo_bloc.dart';
// import '../../models/saldo_model.dart';
// import '../pages/main/virtual_account.dart';

class VirtualAccountCard extends StatelessWidget {
  // const VirtualAccountCard({super.key});
  final VAModel saldo;
  const VirtualAccountCard(this.saldo, {super.key});

  @override
  Widget build(BuildContext context) {
    String originalString = saldo.NAMA_BANK.toString();
    String replacedNamaBank = originalString.replaceAll("FASPAY ", "");
    // ignore: non_constant_identifier_names
    CopyVA(String nomorVA){
      final value = ClipboardData(text: nomorVA);
      Clipboard.setData(value);
      showCustomSnackBarSuccess(context, 'Nomor VA berhasil disalin!');
    }
    return Container(
      margin: EdgeInsets.only(
        left: 10.sp,
        right: 10.sp,
        top: 3.sp,
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
          //       replacedNamaBank,
          //       style: blackTextStyle.copyWith(
          //         fontWeight: black,
          //         fontSize: 16.sp,
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                replacedNamaBank,
                style: blackTextStyle.copyWith(
                  fontWeight: black,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                saldo.NOAC_VIRTUAL.toString(),
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 13.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  CopyVA(saldo.NOAC_VIRTUAL.toString());
                },
                child: Icon(Icons.copy_outlined, color: blueColor, size: 15.sp)
              ),
            ],
          ),
          // SizedBox(
          //   height: 10.sp,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       'Rp. '+saldo.saldoAkhir,
          //       style: blackTextStyle.copyWith(
          //         fontWeight: semiBold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //   ],
          // ),



          // Theme(
          //   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          //   child: ExpansionTile(
          //     tilePadding: const EdgeInsets.all(0),
          //     title: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           saldo.keterangan,
          //           style: blackTextStyle.copyWith(
          //             fontWeight: black,
          //             fontSize: 16.sp,
          //           ),
          //         ),
          //         Text(
          //           saldo.nomorRekening,
          //           style: blackTextStyle.copyWith(
          //             fontWeight: medium,
          //             fontSize: 12.sp,
          //           ),
          //         ),
          //       ],
          //     ),
          //     subtitle: Text(
          //       'Rp. ${saldo.saldoAkhir}',
          //       style: blackTextStyle.copyWith(
          //         fontWeight: semiBold,
          //         fontSize: 18.sp,
          //       ),
          //     ),
          //     children: <Widget>[
          //       if(saldo.keterangan == 'TABUNGAN RENCANA')
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Tgl Jatuh Tempo',
          //             style: blackTextStyle.copyWith(
          //               fontWeight: medium,
          //               fontSize: 12.sp,
          //             ),
          //           ),
          //           Text(
          //             saldo.tglJatuhtempoIndo!,
          //             style: blackTextStyle.copyWith(
          //               fontWeight: medium,
          //               fontSize: 12.sp,
          //             ),
          //           ),
          //         ],
          //       ),
          //       if(saldo.keterangan == 'TABUNGAN MAKMUR')
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Saldo Efektif',
          //             style: blackTextStyle.copyWith(
          //               fontWeight: medium,
          //               fontSize: 12.sp,
          //             ),
          //           ),
          //           Text(
          //             'Rp. ${saldo.saldoEfektif!}',
          //             style: blackTextStyle.copyWith(
          //               fontWeight: medium,
          //               fontSize: 12.sp,
          //             ),
          //           ),
          //         ],
          //       ),
          //       if(saldo.keterangan == 'TABUNGAN MAKMUR')
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Saldo Blokir',
          //             style: redTextStyle.copyWith(
          //               fontWeight: medium,
          //               fontSize: 12.sp,
          //             ),
          //           ),
          //           Text(
          //             'Rp. ${saldo.saldoBlokir!}',
          //             style: redTextStyle.copyWith(
          //               fontWeight: medium,
          //               fontSize: 12.sp,
          //             ),
          //           ),
          //         ],
          //       ),
          //       if(saldo.keterangan == 'TABUNGAN MAKMUR') const Divider(),
          //       if(saldo.keterangan == 'TABUNGAN MAKMUR')
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               Navigator.push(
          //                 context, 
          //                 MaterialPageRoute(
          //                 builder: ( context) => MutasiTabunganPage(dataRek: saldo.nomorRekening),
          //                 ),
          //               );
          //             },
          //             child: Text(
          //               'Lihat Mutasi',
          //               style: blueTextStyle.copyWith(
          //                 fontWeight: semiBold,
          //                 fontSize: 14.sp,
          //               ),
          //             ),
          //           ),
                    
          //           GestureDetector(
          //             onTap: () {
          //               // print('Nomor VA');
          //               Map<String, dynamic> dataBody = { "nomorRekening": saldo.nomorRekening };
          //               context.read<SaldoBloc>().add(getVirtualAccount(dataBody));
          //               Navigator.push(
          //                 context, 
          //                 MaterialPageRoute(
          //                 builder: ( context) => VirtualAccountPage(nomorRekening: saldo.nomorRekening),
          //                 ),
          //               );
          //             },
          //             child: Text(
          //               'Nomor VA',
          //               style: blueTextStyle.copyWith(
          //                 fontWeight: semiBold,
          //                 fontSize: 14.sp,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
