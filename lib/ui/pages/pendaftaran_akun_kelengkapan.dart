import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';

import '../../blocs/user/user_bloc.dart';
import '../../shared/share_methods.dart';
import 'pendaftaran_akun_foto.dart';

// import '../widgets/forms.dart';

class PendaftaranAkunKelengkapan extends StatefulWidget {
  final Map<String, dynamic> dataKelengkapan;
  const PendaftaranAkunKelengkapan({
    super.key,
    required this.dataKelengkapan,
  });

  @override
  State<PendaftaranAkunKelengkapan> createState() => _PendaftaranAkunKelengkapanState(dataKelengkapan);
}

class _PendaftaranAkunKelengkapanState extends State<PendaftaranAkunKelengkapan> {
  var logger = Logger();
  _PendaftaranAkunKelengkapanState(this.dataKelengkapan);
  final Map<String, dynamic> dataKelengkapan;
  final nomorRekeningController = TextEditingController(text: '');
  final nomorHPController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final nomorWAController = TextEditingController(text: '');  
  bool pickSamakan = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nomorRekening = '';
  String nomorHP = '';
  String email = '';
  String nomorWA = '';
  final blocUser = UserBloc();
  void submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> dataBody = {
        "nomorRekening": nomorRekening,
        "nomorHP": nomorHP,
        "email": email,
        "nomorWA": nomorWA,
      };
      dataBody.addAll(dataKelengkapan);
      // logger.i(dataBody);
      // Navigator.pushNamed(context, '/pendaftaran_foto');
      blocUser.add(DaftarCekRekening(dataBody));
      blocUser.stream.listen((stateUser) {
        // logger.i(stateUser);
        if(stateUser is DaftarCekRekeningLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateUser is DaftarCekRekeningFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateUser.e);
        }
        if (stateUser is DaftarCekRekeningSuccess) {
          EasyLoading.dismiss();
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: ( context) => PendaftaranAkunFoto(dataFoto: stateUser.dataResult),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // logger.i(dataKelengkapan);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Pendaftaran Akun',
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 20.sp,),
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
                    SizedBox(height: 30.sp,),
                    TextFormField(
                      controller: nomorHPController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Nomor Handphone',
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
                        hintText: 'Masukkan No HP (yang terdaftar di Bank WM)',
                        helperText: 'Pastikan SMS aktif, \njika tidak silahkan melakukan pengkinian data',
                        helperStyle: TextStyle(
                          fontSize: 10.sp,
                          color: greenColor,
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Silahkan Masukkan No HP ( yang terdaftar di Bank WM )';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          nomorHP = value;
                        });
                      },
                    ),
                    SizedBox(height: 30.sp,),
                    TextFormField(
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Email',
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
                        hintText: 'Masukkan Email (yang terdaftar di Bank WM)',
                      ),
                      // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z, a-z]'))],
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Silahkan Masukkan Email ( yang terdaftar di Bank WM )';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Silahkan masukkan alamat email yang valid';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 30.sp,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if(pickSamakan){
                              setState(() {
                                pickSamakan = false;
                                nomorWAController.text = '';
                                nomorWA = '';
                              });
                            }else{
                              setState(() {
                                pickSamakan = true;
                                nomorWAController.text = nomorHPController.text;
                                nomorWA = nomorHPController.text;
                              });
                            }
                          },
                          child: Icon(
                            pickSamakan ? Icons.check_box : Icons.check_box_outline_blank,
                            size: 20.sp,
                            color: blackColor,
                          ),
                        ),
                        Text(
                          'samakan dengan nomor HP',
                          style: blackTextStyle.copyWith(
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: nomorWAController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Nomor WA',
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
                        hintText: 'Masukkan No WA',
                        helperText: 'Kami akan menghubungi Anda melalui Whatsapp Video Call',
                        helperStyle: TextStyle(
                          fontSize: 10.sp,
                          color: greenColor,
                          // overflow: TextOverflow.visible,
                          // letterSpacing: 1,
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Silahkan Masukkan No WA';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          nomorWA = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.sp,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 330.sp,
                          height: 40.sp,
                          child: TextButton(
                            onPressed: () { 
                              submitForm();
                              // Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
                              // Navigator.pushNamed(context, '/pendaftaran_kelengkapan');
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: greenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'LANJUT',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14.sp,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                      ],                   
                    ),
                    SizedBox(height: 10.sp,),
                  ],
                )
              )
            ],
          ),
        ),
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