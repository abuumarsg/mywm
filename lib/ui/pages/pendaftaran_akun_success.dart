import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';


class PendaftaranAkunSuccessPage extends StatelessWidget {
  const PendaftaranAkunSuccessPage({super.key});

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
              height: 30.sp,
            ),
            Text(
              'Terimakasih',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Pendaftaran berhasil dan sedang kami proses, \nsilakan menunggu petugas kami akan menghubungi Anda.',
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
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
                Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => true);
              },
            ),
          ],
        ),
      ),
    );
  }  
}