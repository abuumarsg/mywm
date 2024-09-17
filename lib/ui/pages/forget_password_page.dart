import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:myWM/ui/widgets/forms.dart';

import '../../blocs/user/user_bloc.dart';
import '../../shared/share_methods.dart';
import '../widgets/onboarding_header.dart';
import 'forget_password_otp_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  // final String namaNasabah;
  final Map<String, dynamic> dataNasabah;
  const ForgetPasswordPage({super.key, required this.dataNasabah});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState(dataNasabah);
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  _ForgetPasswordPageState(this.dataNasabah);
  final Map<String, dynamic> dataNasabah;
  @override 
  void initState(){ 
    super.initState(); 
    passwordVisibleN = true;
    passwordVisibleR = true;
  }
  final namaController = TextEditingController(text: '');
  final nomorKTPController = TextEditingController(text: '');
  final nomorRekeningController = TextEditingController(text: '');
  final passwordBaruController = TextEditingController(text: '');
  final passwordBaruUlangController = TextEditingController(text: '');
  bool passwordVisibleN = false;
  bool passwordVisibleR = false;
  String nomorKTP = '';
  String nomorRekening = '';
  String newPassword = '';
  String confirmNewPassword = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final blocUser = UserBloc();
  void submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> dataBody = {
        "nomorKTP": nomorKTP,
        "user_id": dataNasabah['user_id'].toString(),
        "nomorRekening": nomorRekening,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      };
      // logger.i(dataBody);
      blocUser.add(LupaPassword(dataBody));
      blocUser.stream.listen((stateUser) {
        // logger.i(stateUser);
        if(stateUser is LupaPasswordLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateUser is LupaPasswordFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateUser.e);
        }
        if (stateUser is LupaPasswordSuccess) {
          EasyLoading.dismiss();
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: ( context) => ForgetPasswordOTP(dataOTP: stateUser.dataResult),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    namaController.text = dataNasabah['nama'].toString();
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
        bottomNavigationBar: CustomNavBarOnboarding(),
        body: ListView(
          children: [
            SizedBox(height: 40.sp,),
            OnboardingHeader(),
            SizedBox(height: 40.sp,),
            WelcomeOnboarding(),
            SizedBox(height: 20.sp,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: namaController,
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Nama',
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
                          hintText: 'Nama Lengkap',
                          filled: true, 
                        ),
                        readOnly: true,
                      ),
                      SizedBox( height: 25.sp, ),
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
                      SizedBox( height: 25.sp, ),
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
                      SizedBox( height: 25.sp, ),
                      TextFormField(
                        controller: passwordBaruController,
                        obscureText: passwordVisibleN,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Password Baru',
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
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisibleN
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisibleN = !passwordVisibleN;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                          hintText: 'Password Baru',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan masukkan password baru';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          if (!value.contains(RegExp(r'\d'))) {
                            return 'Password harus mengandung angka';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password harus mengandung huruf kapital';
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password harus mengandung huruf kecil';
                          }
                          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password harus mengandung karakter khusus';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            newPassword = value;
                          });
                        },
                      ),
                      SizedBox( height: 30.sp,),
                      TextFormField(
                        controller: passwordBaruUlangController,
                        obscureText: passwordVisibleR,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Ulang Password Baru',
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
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisibleR
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisibleR = !passwordVisibleR;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                          hintText: 'Ulang Password Baru',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan masukkan Password baru';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          if (!value.contains(RegExp(r'\d'))) {
                            return 'Password harus mengandung angka';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password harus mengandung huruf kapital';
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password harus mengandung huruf kecil';
                          }
                          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password harus mengandung karakter khusus';
                          }
                          if (value != newPassword) {
                            return 'Password baru tidak sama';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            confirmNewPassword = value;
                          });
                        },
                      ),
                      SizedBox( height: 30.sp,),
                      Text(
                        'Tekan tombol "Minta OTP" di bawah ini, kemudian masukkan pada kolom dibawahnya',
                        style: blackTextStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox( height: 15.sp,),
                      CustomFilledButton(
                        title: 'Minta OTP',
                        onPressed: () { 
                          submitForm();
                          // Navigator.pushNamedAndRemoveUntil(context, '/confirm_otp_lupa_username', (route) => false);
                          // Navigator.pushNamed(context, '/confirm_otp_lupa_password');
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),                
            OtherServiceOnboarding(),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}