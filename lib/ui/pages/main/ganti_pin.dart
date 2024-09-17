import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/ui/pages/main/ganti_pin_otp.dart';
import 'package:logger/logger.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';

class GantiPinPage extends StatefulWidget {
  const GantiPinPage({super.key});

  @override
  State<GantiPinPage> createState() => _GantiPinPageState();
}

class _GantiPinPageState extends State<GantiPinPage> {
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
      Map<String, dynamic> dataBody = {
        "currentPin": _currentPassword,
        "newPin": _newPassword,
        "confirmNewPin": _confirmNewPassword,
      };
      blocUser.add(GantiPin(dataBody));
      blocUser.stream.listen((stateUser) {
        // logger.i(stateUser);
        if(stateUser is GantiPinLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateUser is GantiPinFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateUser.e);
        }
        if (stateUser is GantiPinSuccess) {
          EasyLoading.dismiss();
          Navigator.push(
            context, 
            MaterialPageRoute(
             builder: ( context) => GantiPinOTPPage(dataOTP: stateUser.dataResult),
            ),
          );
        }
      });
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
          'Ganti PIN',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'PIN Lama',
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
                      hintText: 'PIN Lama',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan PIN saat ini';
                      }
                      if (value.length < 6 || value.length > 6) {
                        return 'PIN harus 6 angka';
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'PIN Baru',
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
                      hintText: 'PIN Baru',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan PIN baru';
                      }
                      if (value.length < 6 || value.length > 6) {
                        return 'PIN harus 6 angka';
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Ulang PIN Baru',
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
                      hintText: 'Ulang PIN Baru',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan PIN baru';
                      }
                      if (value.length < 6 || value.length > 6) {
                        return 'PIN harus 6 angka';
                      }
                      if (value != _newPassword) {
                        return 'PIN baru tidak sama';
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
