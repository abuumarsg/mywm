import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:myWM/ui/pages/main/transfer_need_pin.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../blocs/transfer/transfer_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';

class TransferSesamaWMNeedOTP extends StatefulWidget {
  final Map<String, dynamic> dataOTP;
  const TransferSesamaWMNeedOTP({
    super.key,
    required this.dataOTP,
  });

  @override
  State<TransferSesamaWMNeedOTP> createState() =>
      _TransferSesamaWMNeedOTPState(dataOTP);
}

class _TransferSesamaWMNeedOTPState extends State<TransferSesamaWMNeedOTP> {
  var logger = Logger();
  _TransferSesamaWMNeedOTPState(this.dataOTP);
  final Map<String, dynamic> dataOTP;
  final TextEditingController otpController = TextEditingController(text: '');

  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;

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
    if(_messages.isNotEmpty){
      final message = _messages[0];
      final otpMatch = RegExp(r'\d{6}').firstMatch(message.body ?? '');
      final otpSMS = otpMatch?.group(0) ?? 'OTP tidak ditemukan';
      otpController.text = otpSMS;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Konfirmasi Kode OTP',
          style: whiteTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueBackgroundColor,
        centerTitle: true,
      ),
      backgroundColor: blueBackgroundColor,
      body: BlocConsumer<TransferBloc, TransferState>(
        listener: (context, otpState) {
          // logger.i(otpState);
          if(otpState is TfSesamaSendOTPValidasiLoading){
            showLoadingIndicator();
          }
          if(otpState is TfSesamaSendOTPValidasiFailed){
            EasyLoading.dismiss();
            showCustomSnackBar(context, otpState.e);
          }
          if(otpState is TfSesamaSendOTPValidasiSuccess){
            EasyLoading.dismiss();
            Navigator.push(
              context, 
              MaterialPageRoute(
               builder: ( context) => TransferSesamaWMNeedPIN(dataPIN: otpState.dataPIN),
              ),
            );
          }
        },
        builder: (context, otpState) {
          return Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 10.sp, right: 10.sp, top: 10.sp, bottom: 20.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30.sp,
                        ),
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
                          height: 30.sp,
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
                          height: 20.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.sp,
                          ),
                          child: Column(
                            children: [
                              CustomFilledButton2(
                                title: 'Lanjut',
                                onPressed: () {
                                  if (otpController.text.length == 6) {
                                    Map<String, dynamic> dataBody = dataOTP;
                                    Map<String, dynamic> kodeOtp = {"kodeOtpUser": otpController.text};
                                    dataBody.addAll(kodeOtp);
                                    context.read<TransferBloc>().add(TransferSesamaSendValidasiOTP(dataBody));
                                    // if (otpController.text == '123123') {
                                    //   // Navigator.pushNamedAndRemoveUntil(context, '/lupa_username_success', (route) => false);
                                    //   Navigator.pushNamed(context,
                                    //       '/transfer_sesama_wm_need_pin');
                                    // } else {
                                    //   showCustomSnackBar(context,
                                    //       'OTP yang anda masukkan salah');
                                    // }
                                  } else {
                                    showCustomSnackBar(
                                        context, 'Kode OTP harus 6 Digit');
                                  }
                                },
                                width: 400.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  void resendCodeOTP(dataOTP) {
    setState(() {
      otpController.text = '';
      context.read<TransferBloc>().add(TransferSesamaOTP(dataOTP));
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
