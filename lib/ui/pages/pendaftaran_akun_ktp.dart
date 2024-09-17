import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/user/user_bloc.dart';
import '../../shared/share_methods.dart';
import '../widgets/navigator_without_context.dart';
// import 'pendaftaran_akun_kelengkapan.dart';
// import '../../shared/share_methods.dart';

class PendaftaranAkunKTP extends StatefulWidget {
  const PendaftaranAkunKTP({super.key});

  @override
  State<PendaftaranAkunKTP> createState() => _PendaftaranAkunKTPState();
}

class _PendaftaranAkunKTPState extends State<PendaftaranAkunKTP> {
  var logger = Logger();
  // late NavigatorState navigatorState;
  @override
  void initState() {
    super.initState();
    // navigatorState = Navigator.of(context);
  }
  final nomorKTPController = TextEditingController(text: '');
  final namaController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nomorKTP = '';
  String namaLengkap = '';
  String errorMessage = '';
  Map<String, dynamic> textLink = {};
  final blocUser = UserBloc();
  void submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> dataBody = {
        "nomorKTP": nomorKTP,
        "namaLengkap": namaLengkap,
      };
      blocUser.add(DaftarCekKtpNama(dataBody));
      blocUser.stream.listen((stateUser) {
        // logger.i(stateUser);
        if(stateUser is DaftarCekKtpNamaLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateUser is DaftarCekKtpNamaFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateUser.e);
        }
        if (stateUser is DaftarCekKtpNamaSuccess) {
          EasyLoading.dismiss();
          if(stateUser.dataResult['pesan'] != null){
            setState(() {
              errorMessage = stateUser.dataResult['pesan'];
              if(stateUser.dataResult['link'] != null){
                textLink = stateUser.dataResult['link'];
              }
            });
          }else{         
            NavigationService.redirectToPendaftaranAkunKelengkapan(stateUser.dataResult);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // logger.i(textLink);
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
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.symmetric(
              horizontal: 5.sp,
            ),
            children: [
              SizedBox(height: 20.sp,),
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
              SizedBox(height: 25.sp,),
              TextFormField(
                controller: namaController,
                obscureText: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Nama Lengkap',
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
                  hintText: 'Masukkan nama lengkap anda',
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Z, a-z]'))],
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Silahkan Masukkan Nama Lengkap';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    namaLengkap = value;
                  });
                },
              ),
              SizedBox(height: 20.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320.sp,
                    height: 40.sp,
                    child: TextButton(
                      onPressed: () { 
                        submitForm();
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
              Text(
                errorMessage,
                style: redTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
              ),
              // HtmlWidget(errorMessage),
              if(textLink.isNotEmpty)
              SizedBox(
                height: 110.sp,
                child: ListView.builder(
                  itemCount: textLink.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = textLink.keys.elementAt(index);
                    String value = textLink[key];
                    return SizedBox(
                      height: 35.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () async {
                              // ignore: deprecated_member_use
                              if(await canLaunch(value)){
                                // ignore: deprecated_member_use
                                launch(value);
                              }
                            },
                            child: Text(
                              key,
                              style: blueTextStyle.copyWith(
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
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