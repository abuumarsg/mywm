import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../models/user_model.dart';
import '../../shared/share_methods.dart';
import '../../shared/share_values.dart';
import '../widgets/onboarding_header.dart';

class ConfirmLoginOTP extends StatefulWidget {
  final UserModel user;
  const ConfirmLoginOTP({
    super.key,
    required this.user,
  });

  @override
  State<ConfirmLoginOTP> createState() => ConfirmLoginOTPState(user);
}

class ConfirmLoginOTPState extends State<ConfirmLoginOTP>{
  var logger = Logger();
  UserModel user;
  ConfirmLoginOTPState(this.user);
  final otpController = TextEditingController(text: '');
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  final blocAuth = AuthBloc();

  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
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
        count: 2, // Batasi jumlah pesan yang dibaca
      );
      if (mounted) {
        setState(() {
          _messages = messages.where((msg) => 
          msg.address?.toUpperCase() == 'BPR WM' &&
          msg.body!.contains('OTP') &&
          msg.date!.isAfter(DateTime.now().subtract(const Duration(minutes: 1)))
          ).toList();
        });
      }
    } else if (permission.isDenied || permission.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
    } else {
      final newPermissionStatus = await Permission.sms.request();
      if (newPermissionStatus.isGranted) {
        await _getMessages();
      }
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
            'Konfirmasi Login',
            style: whiteTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: semiBold,
            ),
          ),
          backgroundColor: blueBackgroundColor,
          centerTitle: true,
        ),
        backgroundColor: lightBackgroundColor,
        // bottomNavigationBar: Container(
        //   padding: EdgeInsets.symmetric(horizontal: 6.sp),
        //   height: 86.sp,
        //   child: CustomNavBarOnboarding(),
        // ),
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
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: PinCodeTextField(
                      readOnly: true,
                      enabled: true,
                      controller: otpController,
                      appContext: context,
                      length: 6,
                      textStyle: blackTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: bold,
                        // backgroundColor: Color.fromARGB(255, 29, 121, 220),
                        // color: redColor,
                      ),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60.sp,
                        fieldWidth: 50.sp,
                        // activeFillColor: Colors.white,
                        disabledColor: redColor,
                        activeFillColor: greyColor,
                        inactiveFillColor: greyColor,
                        activeColor: greyColor,
                        inactiveColor: greyColor,
                        selectedFillColor: greyColor,
                        selectedColor: greyColor,
                      ),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  if(enableResend)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          enableResend ? resendCodeOTP(user) : null;
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(95.sp, 3.sp),
                          backgroundColor: blueBackgroundColor,
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
                              _konfirmasiSend(otpController.text, user);
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
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
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
  
  _konfirmasiSend(String otp, user) {
    Map<String, dynamic> dataBody = {"kode": user.kode.toString(), "cif":user.cif.toString(), "token":user.token.toString(), "kodeOtpUser": otp};
      blocAuth.add(ValidasiOTPLogin(dataBody));
      blocAuth.stream.listen((stateS) {
        // logger.i(stateS);
        if(stateS is AuthValidasiOTPLoginLoading){
          showLoadingIndicator();
        }
        if (stateS is AuthValidasiOTPLoginFailed) {
          hideLoadingIndicator();
          showCustomSnackBar(context, stateS.e);
        }
        if (stateS is AuthValidasiOTPLoginSuccess) {
          hideLoadingIndicator();
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      });
  }
  
  Future<void> resendCodeOTP(user) async {
    Map<String, dynamic> dataBody = {"kode": user.kode.toString(), "cif":user.cif.toString(), "token":user.token.toString()};
    setState(() {
      otpController.text = '';
      context.read<AuthBloc>().add(getOTPLogin(dataBody));
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('This app requires SMS permission to read messages.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                final newPermissionStatus = await Permission.sms.request();
                if (newPermissionStatus.isGranted) {
                  await _getMessages();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  dispose() { 
    timer.cancel();
    super.dispose();
  }

}