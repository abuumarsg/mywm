// import 'dart:ffi';

import 'dart:convert';
import 'dart:io';
import 'package:myWM/ui/data_provider.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/share_methods.dart';
import 'package:myWM/shared/share_values.dart';
import 'package:myWM/shared/theme.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:myWM/ui/widgets/main_menu_bar.dart';

// import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
// import '../../widgets/buttons.dart';
// import '../../widgets/profile_menu_item.dart';
// import '../../widgets/storage_manager.dart';

class SettingPage extends StatefulWidget {
  // final Int number;
  const SettingPage({
    super.key,
    // required this.number,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  XFile? selectedImage;
  final blocUser = UserBloc();
  bool isProfilePicture = false;

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    readFromStorage();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Pengaturan',
          style: whiteTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueBackgroundColor,
        // toolbarHeight: 45.sp,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
      ),
      backgroundColor: blueBackgroundColor,
      body: BlocConsumer<UserBloc, UserState>(
        listener:(context, userState){
          if(userState is UserloadedFailed){
            showCustomSnackBar(context, userState.e);
          }
          if(userState is UserLogOutSuccess){
            Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false,);
          }
        },
        builder: (context, userState) {
          if(userState is UserLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (userState is Userloaded) {
            isProfilePicture = userState.user.profilePicture == null ? false : true;
            return Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.sp,
                ),
                children: [
                  SizedBox(
                    height: 30.sp,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.sp,
                      vertical: 22.sp,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        if(selectedImage == null)
                        Container(
                          width: 100.sp,
                          height: 100.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: isProfilePicture == false
                                  ? const AssetImage(
                                      'asset/user_pic.png',
                                    )
                                  : NetworkImage(userState.user.profilePicture!)
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                            _openModalPilihSource();
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 30.sp,
                                height: 30.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whiteColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: blackColor,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if(selectedImage != null)
                        Container(
                          width: 100.sp,
                          height: 100.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(
                                  selectedImage!.path,
                                ),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                            _openModalPilihSource();
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 30.sp,
                                height: 30.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whiteColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: blackColor,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        Text(
                          userState.user.name.toString(),
                          style: blackTextStyle.copyWith(
                            fontSize: 18.sp,
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: 40.sp,
                        ),
                        // ProfileMenuItem(
                        //   iconUrl: 'asset/ic_edit_profile.png',
                        //   title: 'Informasi Akun',
                        //   onTap: () async {
                        //     Navigator.pushNamed(context, '/informasi_akun');
                        //   },
                        // ),
                        // ProfileMenuItem(
                        //   iconUrl: 'asset/ic_help.png',
                        //   title: 'Edit Profile',
                        //   onTap: () async {
                            
                        //   },
                        // ),
                        // ProfileMenuItem(
                        //   iconUrl: 'asset/ic_wallet.png',
                        //   title: 'Contoh',
                        //   onTap: () async {
                        //     Navigator.pushNamed(context, '/contoh');
                        //   },
                        // ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/ganti_password');
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 30.sp,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.password,
                                  color: blackColor,
                                  size: 24.sp,
                                ),
                                SizedBox(
                                  width: 18.sp,
                                ),
                                Text(
                                  'My Password',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/my_pin');
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 30.sp,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: blackColor,
                                  size: 24.sp,
                                ),
                                SizedBox(
                                  width: 18.sp,
                                ),
                                Text(
                                  'My Pin',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // Navigator.pushNamed(context, '/otp_sms');
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 30.sp,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.security_update,
                                  color: blackColor,
                                  size: 24.sp,
                                ),
                                SizedBox(
                                  width: 18.sp,
                                ),
                                Text(
                                  'Version',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 120.sp,
                                ),
                                Text(
                                  versionAPK,
                                  style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            showLoadingIndicator();
                            Future.delayed(const Duration(seconds: 2), () {
                              EasyLoading.dismiss();
                              showCustomSnackBarSuccess(context, 'Berhasil Logout.');
                            });
                            Future.delayed(const Duration(seconds: 4), () {
                              context.read<UserBloc>().add(UserLogout());
                              Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false,);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 30.sp,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: redColor,
                                  size: 24.sp,
                                ),
                                SizedBox(
                                  width: 18.sp,
                                ),
                                Text(
                                  'Log Out',
                                  style: redTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ProfileMenuItem(
                        //   iconUrl: 'asset/ic_logout.png',
                        //   title: 'Log Out',
                        //   onTap: () {
                        //     context.read<UserBloc>().add(UserLogout());
                        //     Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false,);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 87,
                  ),
                  // CustomTextButton(
                  //   title: 'Report a Problem',
                  //   onPressed: () {},
                  // ),
                  // Center(
                  //   child: Text(
                  //     versionAPK,
                  //     style: blackTextStyle.copyWith(
                  //       fontWeight: black,
                  //       fontSize: 14.sp,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 50,
                  // ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
  _openModalPilihSource() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'Ubah Foto Profil',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.sp,),
            if(isProfilePicture == true)
            SizedBox(
              height: 40.sp,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    selectedImage = null;
                  });
                  _setStateDeleteFotoProfile();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '  Hapus Foto',
                          style: blackTextStyle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: blueColor,
                      size: 25.sp,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(height: 10.sp,),
            SizedBox(
              height: 40.sp,
              child: GestureDetector(
                onTap: () async {
                  try {
                    final pickedImage = await pickImageFromCamera();
                    if (pickedImage != null) {
                      setState(() {
                        selectedImage = pickedImage;
                      });
                      String dataImage = 'data:image/png;base64,${base64Encode(
                        File(selectedImage!.path).readAsBytesSync(),
                      )}';
                      String ekstensi = p.extension(selectedImage!.path);
                      _selectOptionImage(dataImage, ekstensi);
                    } else {
                        selectedImage = null;
                    }
                  } catch (e) {
                    selectedImage = null;
                  }
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '  Ambil Foto',
                          style: blackTextStyle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: blueColor,
                      size: 25.sp,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: 40.sp,
              child: GestureDetector(
                onTap: () async {
                  try {
                    final image = await selectImage();
                    if (image != null) {
                      setState(() {
                        selectedImage = image;
                      });
                      String dataImage = 'data:image/png;base64,${base64Encode(
                        File(selectedImage!.path).readAsBytesSync(),
                      )}';
                      String ekstensi = p.extension(selectedImage!.path);
                      _selectOptionImage(dataImage, ekstensi);
                    }else{
                    selectedImage = null;
                    }
                  } catch (e) {
                    selectedImage = null;
                  }
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '  Unggah Foto',
                          style: blackTextStyle.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: blueColor,
                      size: 25.sp,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(height: 30.sp,),
          ],
        );
      },
    );
  }
  _selectOptionImage(String image, String ekstensi) {
    // print(image);
    // setState(() {
    //   selectedImage = image a?;
    // });
    Map<String, dynamic> dataBody = {"image": image, "ekstensi": ekstensi};
    blocUser.add(UploadProfilePicture(dataBody));
    blocUser.stream.listen((stateS) {
      if(stateS is UploadProfilePictureLoading){
        EasyLoading.show(
          status: 'loading...',
          maskType: EasyLoadingMaskType.clear, 
        );
      }
      if (stateS is UploadProfilePictureFailed) {
        EasyLoading.dismiss();
        showCustomSnackBar(context, stateS.e);
      }
      if (stateS is UploadProfilePictureSuccess) {
        EasyLoading.dismiss();
        showCustomSnackBarSuccess(context, 'Foto Profile Berhasil di upload');
      }
    });
  }
  _setStateDeleteFotoProfile() {
    blocUser.add(const DeleteProfilePicture('foto'));
    blocUser.stream.listen((stateS) {
      if(stateS is DeleteProfilePictureLoading){
        EasyLoading.show(
          status: 'loading...',
          maskType: EasyLoadingMaskType.clear, 
        );
      }
      if (stateS is DeleteProfilePictureFailed) {
        EasyLoading.dismiss();
        showCustomSnackBar(context, stateS.e);
      }
      if (stateS is DeleteProfilePictureSuccess) {
        EasyLoading.dismiss();
        showCustomSnackBarSuccess(context, 'Foto Profile Berhasil di hapus');
      }
    });
    context.read<UserBloc>().add(LoadUser());
    setState(() {
      selectedImage = null;
      // isProfilePicture = false;
    });
  }
}
