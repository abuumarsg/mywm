import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/rekening/rekening_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';


class TransferSuccessPage extends StatelessWidget {
  TransferSuccessPage({super.key});
  final blocRekening = RekeningBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.task_alt,
                color: greenColor,
                size: 100.sp,
              ),
            ),
            SizedBox(
              height: 40.sp,
            ),
            Text(
              'Permintaan Transfer\nBerhasil Dikirim',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40.sp,
            ),
            CustomFilledButton(
              title: 'Selesai',
              width: 183.sp,
              onPressed: () {
                blocRekening.add(LoadRekening());
                blocRekening.stream.listen((stateR) {
                  if (stateR is LoadRekeningFailed) {
                    Future.delayed(Duration.zero,(){
                      showCustomSnackBar(context, 'Gagal Memuat Rekening, ${stateR.e}');
                    });
                  }
                  if (stateR is RekeningLoading) {
                    showLoadingIndicator();
                  }
                  if (stateR is Rekeningloaded) {
                    hideLoadingIndicator();
                    Future.delayed(Duration.zero,(){
                      Navigator.pushNamedAndRemoveUntil(context, '/riwayat_transaksi', (route) => true);
                    });
                  }
                });
                // Navigator.pushNamed(context, '/riwayat_transaksi');
              },
            ),
          ],
        ),
      ),
    );
  }  
}