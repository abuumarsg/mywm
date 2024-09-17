import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ForgetUsernameSuccess extends StatelessWidget {
  const ForgetUsernameSuccess({super.key});

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
              height: 20.sp,
            ),
            Text(
              'Permintaan Berhasil Dikirim',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              'Username kami kirimkan melalui sms ke nomor telp anda, terimakasih',
              style: blackTextStyle.copyWith(
                fontSize: 12.sp,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.sp,
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