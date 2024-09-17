import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/service_locator.dart';
import 'package:myWM/shared/share_methods.dart';
import 'package:myWM/shared/theme.dart';
// import 'package:myWM/ui/widgets/buttons.dart';
// import 'package:myWM/ui/widgets/forms.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
// import '../../shared/global_data.dart';
import '../../shared/share_values.dart';
import '../data_provider.dart';
import '../widgets/navigator_without_context.dart';
import '../widgets/onboarding_header.dart';

class NeedUsernamePage extends StatefulWidget {
  const NeedUsernamePage({super.key,});

  @override
  State<NeedUsernamePage> createState() => _NeedUsernamePageState();
}
final dataProvider = getIt.get<DataProvider>();

class _NeedUsernamePageState extends State<NeedUsernamePage> {
  var logger = Logger();
  final dataversiapk = dataProvider.dataVERSI;
  final usernameController = TextEditingController(text: '');
  LocalAuthentication localAuthentication = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;

  @override
  void initState() {
    super.initState();
    refreshDateNowWm();
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
    localAuthentication.isDeviceSupported().then(
      (bool isSupported) => setState(() => _supportState = isSupported
        ? _SupportState.supported
        : _SupportState.unsupported),
    );
  }

  bool validate() {
    if (usernameController.text.isEmpty) {
      return false;
    }
    return true;
  }
  bool isAuthenticated = false;
  String _authorized = 'Not Authorized';
  
  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        isAuthenticated = true;
        _authorized = 'Authenticating';
      });
      authenticated = await localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        isAuthenticated = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isAuthenticated = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    if(_authorized == 'Authorized'){
      EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.clear, 
      );
      Future.delayed(const Duration(seconds: 2), () {
        NavigationService.redirectToBeranda();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dataProvider = DataProvider();
    // final dataX = dataProvider.dataUrl?.dataUrl ?? 'Tidak ada data';
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 6.sp),
      //   height: 86.sp,
      //   child: CustomNavBarOnboarding(),
      // ),
      body: ListView(
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
              ],
            ),
          ),
          Container(
            height: 700.sp,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 6.sp, left: 6.sp),
                          child: Center(
                            child: SizedBox(
                              width: (_supportState == _SupportState.supported) ? 270.sp : 320.sp,
                              child: TextButton(
                                onPressed: () async {
                                  if(validate()){
                                    const storage = FlutterSecureStorage();
                                    String? username = await storage.read(key: 'username');
                                    if(username != usernameController.text){
                                      // ignore: use_build_context_synchronously
                                      showCustomSnackBar(context, 'Username Tidak Sesuai !');
                                    }else{
                                      showLoadingIndicator();
                                      Future.delayed(const Duration(seconds: 2), () {
                                        NavigationService.redirectToBeranda();
                                      });
                                    }
                                  }else{
                                    showCustomSnackBar(context, 'Username Harus diisi !');
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
                                    fontSize: 16.sp,
                                    fontWeight: bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(_supportState == _SupportState.supported)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 50.sp,
                          height: 45.sp,
                          child: TextButton(
                            style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, 
                              backgroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: blueBackgroundColor,
                                  width: 1.5.sp,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if(_supportState == _SupportState.supported){
                                _authenticateWithBiometrics();
                              }
                            },
                            // child: Align(
                            //   alignment: Alignment.center,
                            //   child: Icon(
                            //     Icons.fingerprint,
                            //     color: blueBackgroundColor,
                            //     size: 35.sp,
                            //   ),
                            // ),

                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    color: blueBackgroundColor.withOpacity(0.3),
                                    size: 38.sp,
                                  ),
                                  Icon(
                                    Icons.fingerprint,
                                    color: blueBackgroundColor,
                                    size: 35.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.sp,
                ),
                const OtherServiceOnboarding(),
                SizedBox(
                  height: 20.sp,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 40.sp,
          // ),
          // OnboardingHeader(),
          // SizedBox(
          //   height: 40.sp,
          // ),
          // const WelcomeOnboarding(),
          // SizedBox(
          //   height: 20.sp,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Container(
          //     padding: const EdgeInsets.all(18),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       color: whiteColor,
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         // CustomFormField(
          //         //   title: '',
          //         //   placeHolder: 'Masukkan Username',
          //         //   obscureText: false,
          //         //   controller: usernameController,
          //         // ),
          //         Text(
          //           'Username',
          //           style: blackTextStyle.copyWith(
          //             fontWeight: medium,
          //             fontSize: 14.sp,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 5.sp,
          //         ),
          //         TextFormField(
          //           readOnly: false,
          //           obscureText: false,
          //           controller: usernameController,
          //           inputFormatters: [
          //             FilteringTextInputFormatter.deny(RegExp(r'\s')),
          //           ],
          //           decoration: InputDecoration(
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(4),
          //             ),
          //             contentPadding: EdgeInsets.all(12),            
          //             hintText: 'Masukkan Username',
          //             filled: false, 
          //             // hintTextStyle: placeHolder,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10.sp,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: <Widget>[
          //                 Padding(
          //                   padding: EdgeInsets.only(right: 6.sp),
          //                   child: SizedBox(
          //                     width: 240.sp,
          //                     child: CustomFilledButton(
          //                       title: 'LOGIN',
          //                       onPressed: () async {
          //                         if(validate()){
          //                           const storage = FlutterSecureStorage();
          //                           String? username = await storage.read(key: 'username');
          //                           if(username != usernameController.text){
          //                             // ignore: use_build_context_synchronously
          //                             showCustomSnackBar(context, 'Username Tidak Sesuai !');
          //                           }else{
          //                             EasyLoading.show(
          //                               status: 'loading...',
          //                               maskType: EasyLoadingMaskType.clear, 
          //                             );
          //                             Future.delayed(const Duration(seconds: 2), () {
          //                               NavigationService.redirectToBeranda();
          //                             });
          //                           }
          //                         }else{
          //                           showCustomSnackBar(context, 'Username Harus diisi !');
          //                         }
          //                       },
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: <Widget>[
          //                 Padding(
          //                   padding: EdgeInsets.only(left: 1.sp),
          //                   child: SizedBox(
          //                     width: 50.sp,
          //                     height: 40.sp,
          //                     child: TextButton(
          //                       style: TextButton.styleFrom(
          //                         backgroundColor: (_supportState == _SupportState.supported) ? blueColor : redColor,
          //                         shape: RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(15),
          //                         ),
          //                       ),
          //                       onPressed: () {
          //                         if(_supportState == _SupportState.supported){
          //                           _authenticateWithBiometrics();
          //                         }
          //                       },
          //                       child: Icon(
          //                         Icons.fingerprint,
          //                         color: whiteColor,
          //                         size: 26.sp,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 10.sp,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.pushNamed(context, '/forget_username');
          //               },
          //               style: TextButton.styleFrom(
          //                 padding: EdgeInsets.zero,
          //               ),
          //               child: Text(
          //                 'Lupa username',
          //                 style: blueTextStyle.copyWith(
          //                   fontSize: 12.sp,
          //                 ),
          //               ),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 fetchDataSyaratPendaftaran();
          //                 Navigator.pushNamed(context, '/not_yet_username');
          //               },
          //               style: TextButton.styleFrom(
          //                 padding: EdgeInsets.zero,
          //               ),
          //               child: Text(
          //                 'Belum punya username',
          //                 style: blueTextStyle.copyWith(
          //                   fontSize: 12.sp,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          
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
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}