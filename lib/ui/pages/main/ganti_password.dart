import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/ui/pages/main/ganti_password_otp.dart';
import 'package:logger/logger.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../shared/global_data.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({super.key});

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> {
  var logger = Logger();
  final passwordLamaController = TextEditingController(text: '');
  final passwordBaruController = TextEditingController(text: '');
  final passwordBaruUlangController = TextEditingController(text: '');
  bool passwordVisible = false;
  bool passwordVisibleN = false;
  bool passwordVisibleR = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisibleN = true;
    passwordVisibleR = true;
  }

  bool validate() {
    if (passwordBaruController.text.isEmpty || passwordLamaController.text.isEmpty) {
      return false;
    }
    return true;
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _currentPassword = '';
  // ignore: unused_field
  String _newPassword = '';
  // ignore: unused_field
  String _confirmNewPassword = '';
  final blocUser = UserBloc();
  void submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if(localPassword == _currentPassword){
        Map<String, dynamic> dataBody = {
          "currentPassword": _currentPassword,
          "newPassword": _newPassword,
          "confirmNewPassword": _confirmNewPassword,
        };
        blocUser.add(GantiPassword(dataBody));
        blocUser.stream.listen((stateUser) {
          if(stateUser is GantiPasswordLoading){
            showLoadingIndicator();
          }
          if (stateUser is GantiPasswordFailed) {
            EasyLoading.dismiss();
            showCustomSnackBar(context, stateUser.e);
          }
          if (stateUser is GantiPasswordSuccess) {
            EasyLoading.dismiss();
            Navigator.push(
              context, 
              MaterialPageRoute(
               builder: ( context) => GantiPasswordOTPPage(dataOTP: stateUser.dataResult),
              ),
            );
          }
        });
      }else{
        EasyLoading.show(
          status: 'loading...',
          maskType: EasyLoadingMaskType.clear, 
        );
        Future.delayed(const Duration(seconds: 2), () {
          EasyLoading.dismiss();
          showCustomSnackBar(context, 'Password lama tidak sesuai !');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Ganti Password',
          style: whiteTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueColor,
        // toolbarHeight: 45.sp,
        centerTitle: true,
      ),
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
        ),
        children: [
          SizedBox(
            height: 30.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 22.sp,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(9),
              // border: Border.all(color: greyColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  TextFormField(
                    controller: passwordLamaController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Password Lama',
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
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      hintText: 'Password Lama',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan password saat ini';
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
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _currentPassword = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
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
                        _newPassword = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
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
                      if (value != _newPassword) {
                        return 'Password baru tidak sama';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _confirmNewPassword = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Center(
                    child: CustomFilledButton(
                      title: 'Lanjutkan',
                      onPressed: () {
                        submitForm();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.sp,
          ),
        ],
      ),
    );
  }
}
