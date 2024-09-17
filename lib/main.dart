import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:myWM/notifikasi/firebase_api.dart';
import 'package:myWM/blocs/auth/auth_bloc.dart';
import 'package:myWM/blocs/maintenance/maintenance_bloc.dart';
import 'package:myWM/blocs/satu/satu_bloc.dart';
import 'package:myWM/models/transfer_sesama_model.dart';
import 'package:myWM/models/user_model.dart';
import 'package:myWM/service_locator.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/data_provider.dart';
import 'package:myWM/ui/pages/Splash_page.dart';
import 'package:myWM/ui/pages/confirm_otp_login_page.dart';
import 'package:myWM/ui/pages/forget_password_page.dart';
import 'package:myWM/ui/pages/forget_username_page.dart';
import 'package:myWM/ui/pages/login_page.dart';
import 'package:myWM/ui/pages/main/home.dart';
import 'package:myWM/ui/pages/main/rekening.dart';
import 'package:myWM/ui/pages/main/transfer_bank_lain.dart';
import 'package:myWM/ui/pages/main/transfer_sesama_wm_next.dart';
import 'package:myWM/ui/pages/notifikasi_list.dart';
import 'package:myWM/ui/pages/onboarding_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/ui/pages/pendaftaran_akun_page.dart';
import 'package:myWM/ui/widgets/navigator_without_context.dart';
import 'package:logger/logger.dart';
import 'blocs/dua/dua_bloc.dart';
import 'blocs/rekening/rekening_bloc.dart';
import 'blocs/saldo/saldo_bloc.dart';
import 'blocs/transfer/transfer_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'shared/share_values.dart';
import 'ui/pages/contoh_otp.dart';
import 'ui/pages/example_page.dart';
import 'ui/pages/forget_password_otp_page.dart';
import 'ui/pages/forget_password_success_page.dart';
import 'ui/pages/forget_username_otp_page.dart';
import 'ui/pages/forget_username_success_page.dart';
import 'ui/pages/main/blokir_akun.dart';
import 'ui/pages/main/blokir_akun_pin.dart';
import 'ui/pages/main/blokir_akun_success_page.dart';
import 'ui/pages/main/buat_pin_baru.dart';
import 'ui/pages/main/buat_pin_baru_otp.dart';
import 'ui/pages/main/favorite.dart';
import 'ui/pages/main/ganti_password.dart';
import 'ui/pages/main/ganti_password_otp.dart';
import 'ui/pages/main/ganti_pin.dart';
import 'ui/pages/main/ganti_pin_otp.dart';
import 'ui/pages/main/informasi_akun.dart';
import 'ui/pages/main/kira.dart';
import 'ui/pages/main/lupa_pin.dart';
import 'ui/pages/main/mutasi_tabungan.dart';
import 'ui/pages/main/my_pin_page.dart';
import 'ui/pages/main/perintah_transfer.dart';
import 'ui/pages/main/rekening_kredit.dart';
import 'ui/pages/main/rekening_kredit_otp.dart';
import 'ui/pages/main/rekening_kredit_pin.dart';
import 'ui/pages/main/riwayat_transaksi.dart';
import 'ui/pages/main/setting.dart';
import 'ui/pages/main/transfer_bank_lain_next.dart';
import 'ui/pages/main/transfer_need_otp.dart';
import 'ui/pages/main/transfer_need_pin.dart';
import 'ui/pages/main/transfer_send_bukti_wm.dart';
import 'ui/pages/main/transfer_sesama_wm.dart';
import 'ui/pages/main/transfer_success.dart';
import 'ui/pages/main/virtual_account.dart';
import 'ui/pages/need_username.dart';
import 'ui/pages/notifikasi_page.dart';
import 'ui/pages/pendaftaran_akun_foto.dart';
import 'ui/pages/pendaftaran_akun_kelengkapan.dart';
import 'ui/pages/pendaftaran_akun_ktp.dart';
import 'ui/pages/pendaftaran_akun_success.dart';
import 'ui/pages/pendaftaran_akun_tanggal.dart';
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 20.0
    ..radius = 10.0
    ..progressColor = Colors.transparent
    ..backgroundColor = Colors.black.withOpacity(0.2)
    ..indicatorColor = Colors.transparent
    ..textColor = Colors.transparent
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = []
    ..indicatorWidget = Image.asset(
      'asset/logo/loading.gif',
      width: 80,
      height: 80,
    );
}

class CustomLoadingAnimation extends EasyLoadingAnimation {
  CustomLoadingAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: Image.asset('asset/logo/loading.gif'),
    );
  }
}

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  configLoading(); 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBogoBHczEER5J7xo8TbIidH4VZOh4RuRg',
      appId: '1:1001803083493:android:811cb3f72f5a9cf5eeee0c',
      messagingSenderId: '1001803083493',
      projectId: 'mywm-88df5',
      storageBucket: 'mywm-88df5.appspot.com',
    ),
  );
  await FirebaseApi().initNotifications();
  initializeDateFormatting('id', null);
  setupServiceLocator();
  await getIt.get<DataProvider>().fetchData();
  await getIt.get<DataProvider>().cekVersionAPK();
  fetchDataBanner();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
// final dataProvider = getIt.get<DataProvider>();

class _MyAppState extends State<MyApp >with WidgetsBindingObserver  {
  var logger = Logger();
  // final dataversiapk = dataProvider.dataVERSI;
  late Timer _timer;
  final Duration _inactiveDuration = const Duration(seconds: 30);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
    _timer.cancel();
    print('=========> BEGINING <=========');
    refreshDateNowWm();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }
  void _startTimer() {
    _timer = Timer(_inactiveDuration, () {
      _clearLocalStorage();
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _startTimer();
  }

  void _clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    try {
      final data = await storage.readAll();
      logger.i(data);
      if (data.isNotEmpty) {
        NavigationService.redirectToNeedUsername();
      } else {
        NavigationService.redirectToYourTimeoutPage();
      }
    } catch (e) {
      logger.e('Error saat membaca dari storage: $e');
    }
    // await storage.delete(key: 'session');
    // print('Data penyimpanan lokal dihapus karena aplikasi tidak aktif selama 1 menit.');
    // var dataToken = await storage.read(key: 'token');
    // if(dataToken != null){
    //   NavigationService.redirectToNeedUsername();
    // }else{
    //   NavigationService.redirectToYourTimeoutPage();
    // }

    // await storage.delete(key: 'session');
    // final dataUsername = await storage.read(key: 'username');
    // if (dataUsername != null) {
    //   NavigationService.redirectToNeedUsername();
    // } else {
    //   NavigationService.redirectToYourTimeoutPage();
    // }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      print('========> detached <=========');
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'session');
    }
    if (state == AppLifecycleState.inactive) {
      print('========> INACTIVE <=========');
      refreshDateNowWm();
    }
    if (state == AppLifecycleState.hidden) {
      print('=========> HIDDEN <=========');
      refreshDateNowWm();
    }
    if (state == AppLifecycleState.paused) {
      refreshDateNowWm();
      const storage = FlutterSecureStorage();
      String? sessionOld = await storage.read(key: 'session');
      await storage.write(key: 'sessionOld', value: sessionOld);
      print('========> PAUSE <=========');
      _resetTimer();
    }
    if (state == AppLifecycleState.resumed) {
      print('========> RESUME <=========');
      refreshDateNowWm();
      _timer.cancel();
      DateTime dateNowWm = DateTime.now();
      String formattedDateWm = DateFormat('yyyyMMddHH').format(dateNowWm);
      final storage = FlutterSecureStorage();
      await storage.write(key: 'session', value: formattedDateWm);
      try {
        final data = await storage.readAll();
        if (data.isNotEmpty) {
          final data = await storage.readAll();
          logger.i(data);
        } else {
          logger.i('Storage kosong');
        }
      } catch (e) {
        logger.e('Error saat membaca dari storage: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => SaldoBloc()),
        BlocProvider(create: (context) => RekeningBloc()),
        BlocProvider(create: (context) => TransferBloc()),
        BlocProvider(create: (context) => MaintenanceBloc()),
        BlocProvider(create: (context) => SatuBloc()),
        BlocProvider(create: (context) => DuaBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        // designSize: const Size(1280, 720),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: lightBackgroundColor,
              appBarTheme: AppBarTheme(          
                backgroundColor: lightBackgroundColor,
                elevation: 0,
                centerTitle: false,
                iconTheme: IconThemeData(
                  color: blackColor,
                ),
                titleTextStyle: blackTextStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: semiBold,
                ),
              ),
            ),
            routes: {
              '/':(context) => const SplashPage(),
              '/onboarding':(context) => const OnBoardingPage(),
              '/forget_username':(context) => const ForgetUsernamePage(),
              '/forget_username_otp':(context) => const ForgetUsernameOTP(dataOTP: {},),
              '/forget_username_success':(context) => const ForgetUsernameSuccess(),
              '/lupa_password':(context) => const ForgetPasswordPage(dataNasabah: {},),
              '/lupa_password_otp':(context) => const ForgetPasswordOTP(dataOTP: {},),
              '/lupa_password_success':(context) => const ForgetPasswordSuccess(),
              '/not_yet_username':(context) => const PendaftaranAkunPage(),
              '/pendaftaran_ktp':(context) => const PendaftaranAkunKTP(),
              '/pendaftaran_kelengkapan':(context) => const PendaftaranAkunKelengkapan(dataKelengkapan: {},),
              '/pendaftaran_foto':(context) => const PendaftaranAkunFoto(dataFoto: {},),
              '/pendaftaran_tanggal':(context) => const PendaftaranAkunTanggal(dataTanggal: {},),
              '/pendaftaran_akun_success':(context) => const PendaftaranAkunSuccessPage(),
              '/favorite':(context) => FavoritePage(),
              '/example':(context) => ExamplePage(),
              '/contohotp':(context) => ContohOTPPage(),
              // '/captcha':(context) => const CaptchaPage(),
              // '/contoh':(context) => ContohPage(),
              // '/otp_sms':(context) => OTPSMS(),
              // '/image_generator':(context) => MyImageGenerator(),
              // '/send_image':(context) => SendImagePage(),
              // '/biometrik':(context) => const BiometrikPage(),
              // '/notif':(context) => NotifPage(),
              // '/home':(context) => MainPage(),
              // '/login':(context) => LoginPage(user:UserModel()),
              '/confirm_otp_login':(context) => ConfirmLoginOTP(user:UserModel()),
              '/login':(context) => LoginPage(),
              '/home':(context) => const HomePage(),
              '/kira':(context) => const KiraPage(),
              '/setting':(context) => const SettingPage(),
              '/need_username':(context) => const NeedUsernamePage(),
              '/rekening':(context) => const RekeningPage(),
              '/virtual_account':(context) => VirtualAccountPage(nomorRekening: "",),
              '/perintah_transfer':(context) => PerintahTransferPage(),
              '/mutasi_tabungan':(context) => MutasiTabunganPage(dataRek: "",),
              '/transfer_sesama_wm':(context) => TransferSesamaWM(dataFav: {},),
              '/transfer_sesama_next':(context) => const TransferSesamaWMNext(dataTrans:TransferSesamaModel()),
              '/transfer_sesama_wm_need_otp':(context) => const TransferSesamaWMNeedOTP(dataOTP: {},),
              '/transfer_sesama_wm_need_pin':(context) => const TransferSesamaWMNeedPIN(dataPIN: {},),
              '/transfer_success_page':(context) => TransferSuccessPage(),
              '/transfer_send_bukti_wm':(context) => SendBuktiTransferWM(),
              '/riwayat_transaksi':(context) => RiwayatTransaksiPage(),
              '/transfer_bank_lain':(context) => TransferBankLain(dataFav: {},),
              '/transfer_bank_lain_next':(context) => const TransferBankLainNext(dataTransfer: {},),
              '/informasi_akun':(context) => const InformasiAkunPage(),
              '/blokir_akun':(context) => const BlokirAkunPage(),
              '/blokir_akun_pin':(context) => const BlokirAkunPIN(dataPIN: {},),
              '/blokir_akun_success_page':(context) => const BlokirAkunSuccessPage(),
              '/ganti_password':(context) => const GantiPasswordPage(),
              '/ganti_password_otp':(context) => const GantiPasswordOTPPage(dataOTP: {},),
              '/my_pin':(context) => const MyPINPage(),
              '/ganti_pin':(context) => const GantiPinPage(),
              '/ganti_pin_otp':(context) => const GantiPinOTPPage(dataOTP: {},),
              '/lupa_pin':(context) => const LupaPinPage(),
              '/buat_pin_baru':(context) => const BuatPinBaruPage(),
              '/buat_pin_baru_otp':(context) => const BuatPinBaruOTPPage(dataOTP: {},),
              '/rekening_kredit':(context) => RekeningKreditPage(dataKredit: {},),
              '/rekening_kredit_otp':(context) => RekeningKreditOTPPage(dataOTP: {},),
              '/rekening_kredit_pin':(context) => RekeningKreditPINPage(dataPIN: {},),
              '/notifikasi':(context) => const NotifikasiPage(),
              '/notifikasi_list':(context) => NotificationListPage(),
            },
            builder: EasyLoading.init(),
          );
        }
      ),
    );
  }
}
