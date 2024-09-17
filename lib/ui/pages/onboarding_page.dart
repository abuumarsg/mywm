import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/share_methods.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/pages/confirm_otp_login_page.dart';
import 'package:logger/logger.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../service_locator.dart';
import '../data_provider.dart';

class OnBoardingPage extends StatefulWidget {
  // const OnBoardingPage({super.key, required this.data});
  const OnBoardingPage({super.key,});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}
final dataProvider = getIt.get<DataProvider>();

class _OnBoardingPageState extends State<OnBoardingPage> {
  var logger = Logger();
  final blocAuth = AuthBloc();
  final dataversiapk = dataProvider.dataVERSI;
  final usernameController = TextEditingController(text: '');
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(dataversiapk?.responseReturn == true){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Yeah !'),
              content: Text('Aplikasi Terbaru versi ${dataversiapk?.versi.toString()} telah tersedia'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tutup'),
                ),
              ],
            );
          },
        );
      }
      if(dataversiapk?.maintenanceAPK == true){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Pemberitahuan',
                style: blackTextStyle.copyWith(
                  fontSize: 15.sp,
                  fontWeight: bold,
                ),
              ),
              content: Text(
                dataversiapk!.ketMaintenance.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.justify,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tutup',
                    style: blackTextStyle.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      body: Wrap(
        spacing: 10.sp,
        children: [
          SizedBox(
            height: 40.sp,
          ),
          Row(
            children: [
              SizedBox(width: 20.sp,),
              Image.asset(
                'asset/logo/logo_my_wm.png',
                width: 80.sp,
              )
            ],
          ),
          SizedBox(
            height: 20.sp,
          ),
          Center(
            child: Image.asset(
              'asset/logo/background_onboarding.png',
              width: 350.sp,
            ),
          ),
          SizedBox(
            height: 100.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              SizedBox(
                width: 320.sp,
                height: 35.sp,
                child: TextButton(
                  onPressed:() {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: darkBlueTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              SizedBox(
                width: 320.sp,
                height: 35.sp,
                child: TextButton(
                  onPressed:() {
                    Navigator.pushNamed(context, '/not_yet_username');
                  },
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      color: whiteColor,
                      width: 3,
                    ),
                    backgroundColor: blueBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Daftar',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: bold,
                    ),
                  ),
                ),
              ),
            ],
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
  void confirmPerangkatBaru(BuildContext context, String keterangan, userModelx){    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pemberitahuan',
            style: blackTextStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: bold,
            ),
          ),
          content: Text(
            // keterangan,
            'Akun Anda telah terdeteksi login di perangkat lain. Apakah Anda ingin melanjutkan login di perangkat ini?\nUntuk keamanan, kami akan mengirimkan kode OTP ke nomor handphone yang terdaftar. Pastikan SIM card dengan nomor tersebut terpasang di perangkat ini.\nJika Anda melanjutkan, kode OTP akan terisi secara otomatis untuk memverifikasi identitas Anda.',
            style: blackTextStyle.copyWith(
              fontSize: 13.sp,
            ),
            // textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            // Text(
            //   userModelx.name.toString(),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tutup',
                    style: blackTextStyle.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.sp,
                  height: 40.sp,
                  child: TextButton(
                    onPressed:() {
                      Navigator.of(context).pop();
                      proceedToGetOtp(userModelx);
                      // proceedToGetOtp(context, userModelx);
                      // Navigator.push(
                      //   context, 
                      //   MaterialPageRoute(
                      //   builder: ( context) => ConfirmLoginOTP(
                      //     user: userModelx,
                      //     ),
                      //   ),
                      // );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Lanjutkan',
                      style: whiteTextStyle.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  proceedToGetOtp(userModelx) {
    Map<String, dynamic> dataBody = {"kode": userModelx.kode.toString(), "cif":userModelx.cif.toString(), "token":userModelx.token.toString()};
    blocAuth.add(getOTPLogin(dataBody));
    blocAuth.stream.listen((stateS) {
      logger.i(stateS);
      if(stateS is AuthgetOtpLoginLoading){
        showLoadingIndicator();
      }
      if (stateS is AuthgetOtpLoginFailed) {
        hideLoadingIndicator();
        showCustomSnackBar(context, stateS.e);
      }
      if (stateS is AuthgetOtpLoginSuccess) {
        hideLoadingIndicator();
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: ( context) => ConfirmLoginOTP(
              user: userModelx,
            ),
          ),
        );
      }
    });
  }
  
}