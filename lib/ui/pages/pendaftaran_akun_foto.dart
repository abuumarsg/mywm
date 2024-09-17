import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
// import 'package:permission_handler/permission_handler.dart';

import '../../blocs/user/user_bloc.dart';
import '../../shared/share_methods.dart';
import 'pendaftaran_akun_tanggal.dart';

class PendaftaranAkunFoto extends StatefulWidget {
  final Map<String, dynamic> dataFoto;
  const PendaftaranAkunFoto({
    super.key,
    required this.dataFoto,
  });

  @override
  State<PendaftaranAkunFoto> createState() => _PendaftaranAkunFotoState(dataFoto);
}

class _PendaftaranAkunFotoState extends State<PendaftaranAkunFoto> {
  var logger = Logger();
  _PendaftaranAkunFotoState(this.dataFoto);
  final Map<String, dynamic> dataFoto;
  XFile? selectedImage;
  XFile? selectedImageSelfi;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final blocUser = UserBloc();
  void submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      logger.i(selectedImage);
      if(selectedImage == null || selectedImageSelfi == null){
        showCustomSnackBar(context, 'Harap pilih foto KTP dan foto Selfie dgn KTP !');
      }else{
        String dataImage = 'data:image/png;base64,${base64Encode(
          File(selectedImage!.path).readAsBytesSync(),
        )}';
        String ekstensi = p.extension(selectedImage!.path);
        String dataImageSelfie = 'data:image/png;base64,${base64Encode(
          File(selectedImageSelfi!.path).readAsBytesSync(),
        )}';
        String ekstensiSelfie = p.extension(selectedImageSelfi!.path);
        Map<String, dynamic> dataBody = {
          "fotoKTP": dataImage,
          "ekstensiKTP": ekstensi,
          "fotoSelfie": dataImageSelfie,
          "ekstensiSelfie": ekstensiSelfie,
        };
        dataBody.addAll(dataFoto);
        // logger.i(dataBody);
      // Navigator.pushNamed(context, '/pendaftaran_kelengkapan');
        blocUser.add(DaftarUploadKTPSelfie(dataBody));
        blocUser.stream.listen((stateUser) {
          // logger.i(stateUser);
          if(stateUser is DaftarUploadKTPSelfieLoading){
            showLoadingIndicator();
          }
          if (stateUser is DaftarUploadKTPSelfieFailed) {
            EasyLoading.dismiss();
            showCustomSnackBar(context, stateUser.e);
          }
          if (stateUser is DaftarUploadKTPSelfieSuccess) {
            EasyLoading.dismiss();
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: ( context) => PendaftaranAkunTanggal(dataTanggal: stateUser.dataResult),
              ),
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // logger.i(dataFoto);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upload Foto KTP',
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 14.sp,
                          ),
                        ),
                        if(selectedImage == null)
                        GestureDetector(
                          onTap: () {
                            modalViewContohFoto(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20.sp,
                                color: greenColor,
                              ),
                              Text(
                                ' Contoh Foto',
                                style: greenTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(selectedImage != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = null;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20.sp,
                                color: redColor,
                              ),
                              Text(
                                ' Hapus Foto',
                                style: redTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp,),
                    if(selectedImage != null)
                    DottedBorder(
                      color: greyColor,
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                selectedImage!.path,
                              ),
                            ),
                          ),
                        ),
                        height: 200,
                        width: 350.sp,
                      ),
                    ),
                    if(selectedImage == null)
                    DottedBorder(
                      color: greyColor,
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10.sp),
                      child: Container(
                        height: 200,
                        width: 350.sp,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'asset/ilustrasi_KTP.png',
                            ),
                            opacity: 0.2,
                          ),
                        ),
                        // color: Colors.white,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 50.sp,
                                  ),
                                  Text(
                                    "Upload File\ndengan format jpg, jpeg, png.",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 12.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox( height: 10.sp, ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final image = await selectImage();
                                  if (image != null) {
                                    setState(() {
                                      selectedImage = image;
                                    });
                                  }else{
                                    selectedImage = null;
                                  }
                                } catch (e) {
                                  selectedImage = null;
                                }
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(110.sp, 3.sp),
                                backgroundColor: springGreenColor,
                                side: BorderSide(color: greenColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Pilih File',
                                style: greenTextStyle.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.sp,),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final pickedImage = await pickImageFromCamera();
                                  if (pickedImage != null) {
                                    setState(() {
                                      selectedImage = pickedImage;
                                    });
                                  } else {
                                      selectedImage = null;
                                  }
                                } catch (e) {
                                  selectedImage = null;
                                }
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(110.sp, 3.sp),
                                backgroundColor: springGreenColor,
                                side: BorderSide(color: greenColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Buka Kamera',
                                style: greenTextStyle.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sp,),
                    //================================================================================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Foto Selfie + KTP',
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 14.sp,
                          ),
                        ),
                        if(selectedImageSelfi == null)
                        GestureDetector(
                          onTap: () {
                            modalViewContohFotoSelfie(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20.sp,
                                color: greenColor,
                              ),
                              Text(
                                ' Contoh Foto',
                                style: greenTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(selectedImageSelfi != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageSelfi = null;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20.sp,
                                color: redColor,
                              ),
                              Text(
                                ' Hapus Foto',
                                style: redTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp,),
                    if(selectedImageSelfi != null)
                    DottedBorder(
                      color: greyColor,
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                selectedImageSelfi!.path,
                              ),
                            ),
                          ),
                        ),
                        height: 200,
                        width: 350.sp,
                      ),
                    ),
                    if(selectedImageSelfi == null)
                    DottedBorder(
                      color: greyColor,
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10.sp),
                      child: Container(
                        height: 200,
                        width: 350.sp,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'asset/ilustrasi_selvie_photo.png',
                            ),
                            opacity: 0.2,
                            // scale: 0.1,
                          ),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 50.sp,
                                  ),
                                  Text(
                                    "Upload File\ndengan format jpg, jpeg, png.",
                                    style: blackTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 12.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox( height: 10.sp, ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final imageSelf = await selectImage();
                                  if (imageSelf != null) {
                                    setState(() {
                                      selectedImageSelfi = imageSelf;
                                    });
                                  }else{
                                    selectedImageSelfi = null;
                                  }
                                } catch (e) {
                                  selectedImageSelfi = null;
                                }
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(110.sp, 3.sp),
                                backgroundColor: springGreenColor,
                                side: BorderSide(color: greenColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Pilih File',
                                style: greenTextStyle.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.sp,),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final pickedImageSelfi = await pickImageFromCamera();
                                  if (pickedImageSelfi != null) {
                                    setState(() {
                                      selectedImageSelfi = pickedImageSelfi;
                                    });
                                  } else {
                                      selectedImageSelfi = null;
                                  }
                                } catch (e) {
                                  selectedImageSelfi = null;
                                }
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(110.sp, 3.sp),
                                backgroundColor: springGreenColor,
                                side: BorderSide(color: greenColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Buka Kamera',
                                style: greenTextStyle.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              // Navigator.pushNamed(context, '/pendaftaran_tanggal');
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

  void modalViewContohFoto(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 150.sp,
            child: Container(
              width: 300.sp,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'asset/ilustrasi_KTP.png',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void modalViewContohFotoSelfie(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 450.sp,
            child: Container(
              width: 300.sp,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'asset/ilustrasi_selvie_photo.png',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}