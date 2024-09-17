import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:logger/logger.dart';
// import 'package:gif/gif.dart';
import 'package:myWM/shared/theme.dart';
// import 'package:logger/logger.dart';

import '../../blocs/auth/auth_bloc.dart';
// import '../../shared/share_methods.dart';
import '../data_provider.dart';
import '../widgets/navigator_without_context.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ImageProvider gifImage = const AssetImage('asset/logo/logo_splash.gif');
  bool _isImageLoaded = false;

  @override
  void initState() {
    // callAPICekVersion();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(gifImage, context).then((_) {
        setState(() {
          _isImageLoaded = true;
        });
        // print("GIF berhasil dimuat.");
      }).catchError((error) {
        // print("Error saat memuat GIF: $error");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    DateTime dateNowWm = DateTime.now();
    return Scaffold(
      backgroundColor: blueBackgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if(state is AuthLoginSuccess){
            const storage = FlutterSecureStorage();
            final verificationOTP = await storage.read(key: 'verificationOTP');
            if(verificationOTP == 'false'){
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
            }else{
              final dataSession = await storage.read(key: 'sessionOld');
              if(dataSession != null){
                DateTime dateSession = DateTime.parse(dataSession);
                if (dateNowWm.isAfter(dateSession)) {
                  Future.delayed(const Duration(seconds: 4), () {
                    Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
                  });
                }else{
                  NavigationService.redirectToBeranda();
                }
              }else{
                Future.delayed(const Duration(seconds: 4), () {
                  Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
                });
              }
            }
          }
          if(state is AuthFailed){
            Future.delayed(const Duration(seconds: 5), () {
              Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
            });
          }
        },
        child: Wrap(
          spacing: 10.sp,
          children: [
            SizedBox(
              height: 150.sp,
            ),
            if (_isImageLoaded)
            Center(
              child: Image(
                image: gifImage, 
                width: 180.sp,
              ),
            ),
            Center(
              child: SizedBox(
                width: 300.sp,
                // height: 30.sp,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bank WM (BPR) berizin dan diawasi OJK serta merupakan peserta penjaminan LPS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: regular,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.sp,
              child: Center(
                child: Text(
                  'Version $versionAPK',
                  style: whiteTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12.sp,
                    // color: whiteColor,
                    // backgroundColor: blueBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
