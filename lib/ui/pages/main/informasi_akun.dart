import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/global_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';
class InformasiAkunPage extends StatefulWidget {
  const InformasiAkunPage({super.key});

  @override
  State<InformasiAkunPage> createState() => _InformasiAkunPageState();
}

class _InformasiAkunPageState extends State<InformasiAkunPage> {
  
  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    // logger.i(localEmail);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Informasi Akun',
            style: whiteTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
          ),
          backgroundColor: blueBackgroundColor,
          // toolbarHeight: 45.sp,
          centerTitle: true,
        ),
        backgroundColor: blueBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'asset/terompet.png',
                          width: 40.sp,
                        ),
                        SizedBox(width: 15.sp,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16.sp),
                              child: SizedBox(
                                width: 200.sp,
                                child: Text(
                                  'Informasi',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: medium,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.sp),
                              child: SizedBox(
                                width: 220.sp,
                                child: Text(
                                  'Untuk Pengkinian data, silahkan datang ke kantor Bank WM',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 11.sp,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchURL();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 50.sp,),
                          Icon(
                            Icons.location_on,
                            color: blueColor,
                            size: 16.sp,
                          ),
                          Text(
                            ' Lokasi Kantor',
                            style: blueTextStyle.copyWith(
                              fontSize: 14.sp,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.sp,
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
                    const Divider(),
                    SizedBox(
                      height: 41.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Nama',
                                style: greyTextStyle.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                localName,
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 41.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Username',
                                style: greyTextStyle.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                localUsername,
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 41.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: greyTextStyle.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                localEmail,
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 41.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Nomor Handphone',
                                style: greyTextStyle.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                localNomorTelp,
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 41.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Terdaftar',
                                style: greyTextStyle.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                localCreateDate,
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     labelText: 'Username',
                    //     labelStyle: TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     contentPadding: const EdgeInsets.all(12),
                    //     hintText: localUsername,
                    //     hintStyle: TextStyle(fontSize: 16.sp),
                    //     filled: true,
                    //   ),
                    //   readOnly: true,
                    // ),
                    SizedBox(
                      height: 10.sp,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomFilledButton(
                  title: 'Blokir Akun',
                  onPressed: () {
                    Navigator.pushNamed(context, '/blokir_akun');
                  },
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> launchURL() async {
    final Uri url = Uri.parse('https://bprwm.co.id/kantor-layanan');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}