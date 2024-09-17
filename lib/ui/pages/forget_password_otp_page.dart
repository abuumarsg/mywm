import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../blocs/user/user_bloc.dart';
// import '../../shared/share_methods.dart';
import '../../shared/share_methods.dart';
import '../../shared/share_values.dart';
import '../widgets/onboarding_header.dart';

class ForgetPasswordOTP extends StatefulWidget {
  final Map<String, dynamic> dataOTP;
  const ForgetPasswordOTP({
    super.key,
    required this.dataOTP,
  });

  @override
  State<ForgetPasswordOTP> createState() => _ForgetPasswordOTPState(dataOTP);
}

class _ForgetPasswordOTPState extends State<ForgetPasswordOTP> {
  var logger = Logger();
  _ForgetPasswordOTPState(this.dataOTP);
  final Map<String, dynamic> dataOTP;
  final otpController = TextEditingController(text: '');

  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  final blocUser = UserBloc();

  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
          _getMessages();
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }
  Future<void> _getMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: 2,
      );
      setState(() {
        _messages = messages.where((msg) => 
        msg.address?.toUpperCase() == 'BPR WM' &&
        msg.body!.contains('OTP') &&
        msg.date!.isAfter(DateTime.now().subtract(const Duration(minutes: 1)))
        ).toList();
      });
    } else {
      await Permission.sms.request();
      _getMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    if(_messages.isNotEmpty){
      final message = _messages[0];
      final otpMatch = RegExp(r'\d{6}').firstMatch(message.body ?? '');
      final otpSMS = otpMatch?.group(0) ?? 'OTP tidak ditemukan';
      otpController.text = otpSMS;
    }
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Lupa Password',
            style: whiteTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: semiBold,
            ),
          ),
          backgroundColor: blueColor,
          centerTitle: true,
        ),
        backgroundColor: lightBackgroundColor,
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.sp),
          height: 86.sp,
          child: CustomNavBarOnboarding(),
        ),
        body: ListView(
          children: [
            SizedBox(height: 40.sp,),
            OnboardingHeader(),
            SizedBox(height: 40.sp,),
            const WelcomeOnboarding(),
            SizedBox(height: 20.sp,),
            Container(
              margin: EdgeInsets.only(
                  left: 10.sp, right: 10.sp, top: 10.sp, bottom: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(
                  //   height: 100.sp,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'OTP Terkirim ke SMS',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          'Masukkan 6 Digit OTP yang terkirim ke nomor anda',
                          style: blackTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: PinCodeTextField(
                      controller: otpController,
                      appContext: context,
                      length: 6,
                      textStyle: blackTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: bold,
                      ),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60.sp,
                        fieldWidth: 50.sp,
                        activeFillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  if(enableResend)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          enableResend ? resendCodeOTP(dataOTP) : null;
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(95.sp, 3.sp),
                          backgroundColor: blueColor,
                          // backgroundColor: springGreenColor,
                          // side: BorderSide(color: greenColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Kirim Ulang',
                          style: whiteTextStyle.copyWith(
                            fontSize: 11.sp,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    'Belum menerima OTP? Kirim Ulang dalam $secondsRemaining detik',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pastikan SIM card dengan nomor handphone yang terdaftar\nterpasang di perangkat ini.',
                        style: greyTextStyle.copyWith(
                          fontWeight: black,
                          fontSize: 10.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    child: Column(
                      children: [
                        CustomFilledButton2(
                          title: 'Konfirmasi',
                          onPressed: () {
                            if (otpController.text.length == 6) {
                              _konfirmasiSend(otpController.text);
                            } else {
                              showCustomSnackBar( context, 'Kode OTP harus 6 Digit');
                            }
                          },
                          width: 400.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const OtherServiceOnboarding(),
            SizedBox(
              height: 50.sp,
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openKiraModel(context);
        },
        tooltip: 'Chat AI KIRA',
        backgroundColor: Colors.transparent,
        child: Container(
          width: 75.sp,
          height: 75.sp,
          decoration: BoxDecoration(
            border: Border.all(
              color: blueColor,
              width: 4,
            ),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage(
                'asset/klik_kira.png',
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
  void openKiraModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Membuat latar belakang dialog transparan
          insetPadding: EdgeInsets.all(20.sp), // Mengurangi padding di sekitar dialog
            // width: MediaQuery.of(context).size.width * 0.9, // Mengatur lebar dialog menjadi 80% dari lebar layar
            // height: MediaQuery.of(context).size.height * 0.9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Mengatur warna latar belakang dialog
                borderRadius: BorderRadius.circular(16.sp), // Mengatur radius sudut dialog
              ),
              child: const HtmlWidget(
                '''
                <iframe 
                  src="https://www.chatbase.co/chatbot-iframe/rGhSw2xhPc23YQs7m1MyX" 
                  title="Kira" 
                  width="100%" 
                  style="height:100%; min-height:700px" 
                  framebolder="0">
                </iframe>
                ''',
              ),
            ),
        );
      },
    );
  }
  _konfirmasiSend(String otp) {
      Map<String, dynamic> dataBody = {"kodeOtpUser": otp};
      dataBody.addAll(dataOTP);
      // logger.i(dataBody);
      blocUser.add(ValidasiLupaPassword(dataBody));
      blocUser.stream.listen((stateS) {
        logger.i(stateS);
        if(stateS is ValidasiLupaPasswordLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateS is ValidasiLupaPasswordFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateS.e);
        }
        if (stateS is ValidasiLupaPasswordSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, '/lupa_password_success', (route) => false);
        }
      });
  }
  void resendCodeOTP(dataOTP) {
    setState(() {
      otpController.text = '';
      context.read<UserBloc>().add(LupaPassword(dataOTP));
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}