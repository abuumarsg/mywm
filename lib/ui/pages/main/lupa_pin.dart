import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';

class LupaPinPage extends StatefulWidget {
  const LupaPinPage({super.key});

  @override
  State<LupaPinPage> createState() => _LupaPinPageState();
}

class _LupaPinPageState extends State<LupaPinPage> {
  var logger = Logger();
  final nomorRekeningController = TextEditingController(text: '');
  final nomorKTPController = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nomorRekening = '';
  String nomorKTP = '';
  final blocUser = UserBloc();
  void submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> dataBody = {
        "nomorRekening": nomorRekening,
        "nomorKTP": nomorKTP,
      };
      // logger.i(dataBody);
      blocUser.add(LupaPinCekRekeningDanKtp(dataBody));
      blocUser.stream.listen((stateUser) {
        // logger.i(stateUser);
        if(stateUser is LupaPinCekRekeningDanKtpLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateUser is LupaPinCekRekeningDanKtpFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateUser.e);
        }
        if (stateUser is LupaPinCekRekeningDanKtpSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, '/buat_pin_baru');
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
          'Lupa PIN',
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
                    controller: nomorRekeningController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Nomor Rekening',
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
                      hintText: 'Nomor Rekening Tabungan Aktif',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan Masukkan Rekening Tabungan Aktif';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        nomorRekening = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
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
