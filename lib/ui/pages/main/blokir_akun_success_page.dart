import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';


class BlokirAkunSuccessPage extends StatefulWidget {
  const BlokirAkunSuccessPage({super.key});

  @override
  State<BlokirAkunSuccessPage> createState() => _BlokirAkunSuccessPageState();
}

class _BlokirAkunSuccessPageState extends State<BlokirAkunSuccessPage> {

  int secondsRemaining = 7;
  bool enableResend = false;
  late Timer timer;
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
          context.read<UserBloc>().add(UserLogout());
          Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false,);
        });
      }
    });
  }
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
              'Akun Anda sudah diblokir.\nLogout otomatis dalam $secondsRemaining detik',
              style: blackTextStyle.copyWith(
                fontSize: 16,
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
                context.read<UserBloc>().add(UserLogout());
                Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false,);
              },
            ),
          ],
        ),
      ),
    );
  }  

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}