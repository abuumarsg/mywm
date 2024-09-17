import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:myWM/models/user_model.dart';
import 'package:myWM/shared/share_methods.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/pages/confirm_otp_login_page.dart';
// import 'package:myWM/ui/pages/login_page.dart';
// import 'package:myWM/ui/widgets/buttons.dart';
// import 'package:myWM/ui/widgets/forms.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../models/user_model.dart';
import '../../service_locator.dart';
// import '../../shared/share_values.dart';
import '../data_provider.dart';
import '../widgets/onboarding_header.dart';
// import '../widgets/onboarding_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final dataProvider = getIt.get<DataProvider>();

class _LoginPageState extends State<LoginPage> {
  var logger = Logger();
  final blocAuth = AuthBloc();
  final dataversiapk = dataProvider.dataVERSI;
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  Timer? _timer;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dataversiapk?.responseReturn == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Yeah !'),
              content: Text(
                  'Aplikasi Terbaru versi ${dataversiapk?.versi.toString()} telah tersedia'),
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
      if (dataversiapk?.maintenanceAPK == true) {
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

  bool validate() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          // logger.i(authState);
          if(authState is AuthLoginmyWMFailed){
            hideLoadingIndicator();
            showCustomSnackBar(context, authState.e);
          }
          if(authState is AuthLoginmyWMSuccess){
            if(authState.users.flag == 'terdaftar'){
              hideLoadingIndicator();
              confirmPerangkatBaru(context, authState.users.message.toString(),
                UserModel(
                  id: authState.users.id,
                  name: authState.users.name,
                  username: authState.users.username,
                  cif: authState.users.cif,
                  kode: authState.users.kode,
                  token: authState.users.token,
                ),
              );
            }else{
              EasyLoading.dismiss();
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }
          }
        },
        builder: (context, authState) {
          if(authState is AuthLoginmyWMLoading){
            showLoadingIndicator();
          }
          if(authState is AuthLoginmyWMFailed){
            EasyLoading.dismiss();
          }
          return ListView(
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'asset/logo/logo_my_wm.png',
                      width: 80.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: whiteColor,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 800.sp,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10.sp, 5.sp, 10.sp, 30.sp),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'asset/logo/iklan_login.png',
                        width: 320.sp,
                      ),
                    ),
                    SizedBox(
                      height: 40.sp,
                    ),
                    TextFormField(
                      controller: usernameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12.sp),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: greyColor,
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: blueBackgroundColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      readOnly: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12.sp),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          iconSize: 18.sp,
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: greyColor,
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: blueBackgroundColor,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    SizedBox(
                      width: 320.sp,
                      height: 35.sp,
                      child: TextButton(
                        onPressed: () {
                          if (validate()) {
                            context.read<AuthBloc>().add(AuthLoginmyWM(
                                usernameController.text,
                                passwordController.text));
                          } else {
                            showCustomSnackBar(
                                context, 'Username dan Password Harus diisi !');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: blueBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    const OtherServiceOnboarding(),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 200.sp,
              // ),
            ],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     openKiraModel(context);
      //   },
      //   tooltip: 'Chat AI KIRA',
      //   backgroundColor: Colors.transparent,
      //   child: Container(
      //     width: 75.sp,
      //     height: 75.sp,
      //     decoration: BoxDecoration(
      //       border: Border.all(
      //         color: blueColor,
      //         width: 4,
      //       ),
      //       shape: BoxShape.circle,
      //       image: const DecorationImage(
      //         image: AssetImage(
      //           'asset/klik_kira.png',
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
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

  void confirmPerangkatBaru(BuildContext context, String keterangan, userModelx) {
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      proceedToGetOtp(userModelx);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: blueBackgroundColor,
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
    Map<String, dynamic> dataBody = {
      "kode": userModelx.kode.toString(),
      "cif": userModelx.cif.toString(),
      "token": userModelx.token.toString()
    };
    blocAuth.add(getOTPLogin(dataBody));
    blocAuth.stream.listen((stateS) {
      // logger.i(stateS);
      if (stateS is AuthgetOtpLoginLoading) {
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
            builder: (context) => ConfirmLoginOTP(
              user: userModelx,
            ),
          ),
        );
      }
    });
  }
}
