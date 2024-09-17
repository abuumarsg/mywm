
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/models/kredit_model.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import '../../shared/theme.dart';
import '../pages/main/rekening_kredit.dart';

class kreditCard extends StatelessWidget {
  final KreditModel kredit;
  const kreditCard(this.kredit, {super.key});

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
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kredit.namaJenis,
                    style: blackTextStyle.copyWith(
                      fontWeight: black,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    kredit.nomorRekening,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              // subtitle: Text(
              //   'Rp. ${kredit.plafon}',
              //   style: blackTextStyle.copyWith(
              //     fontWeight: semiBold,
              //     fontSize: 18.sp,
              //   ),
              // ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plafon Kredit',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'Rp. ${kredit.plafon}',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Baki Debet',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'Rp. ${kredit.bakiDebet}',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kelonggaran Tarik',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'Rp. ${kredit.kelonggaranTarik!}',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Atas Nama',
                //       style: blackTextStyle.copyWith(
                //         fontWeight: semiBold,
                //         fontSize: 14.sp,
                //       ),
                //     ),
                //     Text(
                //       kredit.atasNama,
                //       style: blackTextStyle.copyWith(
                //         fontWeight: semiBold,
                //         fontSize: 14.sp,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 30.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomFilledButton2(
                      title: 'Ajukan Penarikan',
                      width: 200.sp,
                      onPressed: () {
                        // context.read<TransferBloc>().add(TransferSesamaOTP(datax));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RekeningKreditPage(dataKredit: {
                              "atasNama": kredit.atasNama,
                              "nomorRekeningTabungan": kredit.nomorRekeningTabungan,
                              "nomorRekening": kredit.nomorRekening,
                              "namaJenis": kredit.namaJenis,
                              "plafon": kredit.plafon,
                              "bakiDebet": kredit.bakiDebet,
                              "kelonggaranTarik": kredit.kelonggaranTarik,
                              "jenis": kredit.jenis,
                            }),
                          ),
                        );
                      },
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
