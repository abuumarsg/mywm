import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/ui/pages/main/blokir_akun_pin.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';

class BlokirAkunPage extends StatefulWidget {
  const BlokirAkunPage({super.key});

  @override
  State<BlokirAkunPage> createState() => _BlokirAkunPageState();
}

class _BlokirAkunPageState extends State<BlokirAkunPage> {
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  bool validate() {
    if (passwordController.text.isEmpty || usernameController.text.isEmpty) {
      return false;
    }
    return true;
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
          'PERSETUJUAN BLOKIR AKUN',
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
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, userState) {
          if(userState is PerintahBlokirAkunFailed){
            showCustomSnackBar(context, userState.e);
          }
          if(userState is PerintahBlokirAkunSuccess){
            EasyLoading.dismiss();
            Navigator.push(
              context, 
              MaterialPageRoute(
               builder: ( context) => BlokirAkunPIN(dataPIN: userState.dataResult),
              ),
            );
          }
        },
        builder: (context, userState) {
          if(userState is PerintahBlokirAkunLoading){
            showLoadingIndicator();
          }
          if(userState is PerintahBlokirAkunFailed){
            EasyLoading.dismiss();
          }
          return ListView(
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Username',
                        labelStyle:
                            TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: greyColor,
                        ),
                        // filled: true,
                      ),
                      // readOnly: true,
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
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
                        hintText: 'Password',
                        // filled: true,
                      ),
                      // readOnly: true,
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Center(
                      child: CustomFilledButton(
                        title: 'Lanjutkan',
                        onPressed: () {
                          if (validate()) {
                            context
                                .read<UserBloc>()
                                .add(PerintahBlokirAkun(
                                  {
                                    "username": usernameController.text,
                                    "password": passwordController.text,
                                  }
                                ));
                          } else {
                            showCustomSnackBar(
                                context, 'Username dan Password Harus diisi !');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
            ],
          );
        },
      ),
    );
  }
}
