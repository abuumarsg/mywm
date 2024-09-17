
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/rekening_favorit_model.dart';
import '../../shared/theme.dart';

class CardRekeningFavorit extends StatelessWidget {
  // const saldoCard({super.key});
  // final String? nama;
  final RekFavModel? rekening;
  final bool isSelected;
  const CardRekeningFavorit({
    Key? key,
    // this.nama,
    this.rekening,
    this.isSelected = false,
  }) : super(key: key);

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
        border: Border.all(
          color: isSelected ? blueBackgroundColor : whiteColor, 
          width: 2
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(
              //   'asset/img_bank_bca.png',
              //   width: 60.sp,
              // ),
              // SizedBox(width: 15.sp,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.sp),
                    child: SizedBox(
                      width: 250.sp,
                      child: Text(
                        // nama.toString(),
                        rekening!.atasNama.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: medium,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.sp),
                    child: SizedBox(
                      // width: 179.sp,
                      width: 250.sp,
                      child: Text(
                        // nama.toString(),
                        '${rekening!.namaBank} - ${rekening!.nomorRekening}',
                        style: greyTextStyle.copyWith(
                          fontSize: 10.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(left: 1.sp),
              //       child: Icon(Icons.delete, color: redColor, size: 25.sp),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
