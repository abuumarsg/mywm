import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/share_values.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../blocs/user/user_bloc.dart';
import '../../shared/share_methods.dart';
// import '../../shared/share_values.dart';
import '../widgets/onboarding_header.dart';
import 'forget_username_otp_page.dart';

class ForgetUsernamePage extends StatefulWidget {
  const ForgetUsernamePage({super.key});

  @override
  State<ForgetUsernamePage> createState() => _ForgetUsernamePageState();
}

class _ForgetUsernamePageState extends State<ForgetUsernamePage> {
  var logger = Logger();
  final nomorKTPController = TextEditingController(text: '');
  String nomorKTP = '';
  final nomorRekeningController = TextEditingController(text: '');
  String nomorRekening = '';
  final blocUser = UserBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> submitForm() async {
    refreshDateNowWm();
    final signCode = await SmsAutoFill().getAppSignature;
    await SmsAutoFill().unregisterListener();
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> dataBody = {
        "nomorKTP": nomorKTP,
        "nomorRekening": nomorRekening,
        "signCode": signCode,
      };
      // logger.i(dataBody);
      blocUser.add(LupaUsername(dataBody));
      blocUser.stream.listen((stateUser) {
        // logger.i(stateUser);
        if(stateUser is LupaUsernameLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateUser is LupaUsernameFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateUser.e);
        }
        if (stateUser is LupaUsernameSuccess) {
          EasyLoading.dismiss();
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: ( context) => ForgetUsernameOTP(dataOTP: stateUser.dataResult),
            ),
          );
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    // refreshDateNowWm();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Lupa Username',
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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nomorKTPController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Nomor KTP',
                          labelStyle: TextStyle(fontSize: 22.sp, fontWeight: semiBold),
                          errorStyle: TextStyle(fontSize: 11.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: greyColor,
                          ),
                          alignLabelWithHint: false,
                          hintText: 'Nomor Induk Kependudukan',
                        ),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan Masukkan Nomor KTP';
                          }
                          if (value.length < 16 || value.length > 16) {
                            return 'Nomor KTP harus 16 angka';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            nomorKTP = value;
                          });
                        },
                      ),
                      SizedBox(height: 30.sp,),
                      TextFormField(
                        controller: nomorRekeningController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Nomor Rekening Bank WM',
                          labelStyle: TextStyle(fontSize: 22.sp, fontWeight: semiBold),
                          errorStyle: TextStyle(fontSize: 11.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: greyColor,
                          ),
                          alignLabelWithHint: false,
                          hintText: 'Salah satu nomor rekening tabungan di Bank WM',
                        ),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan masukkan salah satu nomor rekening \ntabungan di Bank Weleri Makmur';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            nomorRekening = value;
                          });
                        },
                      ),
                      SizedBox(height: 10.sp,),
                      Text(
                        'Tekan tombol "Minta OTP" di bawah ini, kemudian masukkan pada kolom dibawahnya',
                        style: blackTextStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      CustomFilledButton(
                        title: 'Minta OTP',
                        onPressed: () { 
                          submitForm();
                        },
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),                
            const OtherServiceOnboarding(),
            SizedBox(
              height: 200.sp,
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
}