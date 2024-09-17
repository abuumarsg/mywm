import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
class MyPINPage extends StatefulWidget {
  const MyPINPage({super.key});

  @override
  State<MyPINPage> createState() => _MyPINPageState();
}

class _MyPINPageState extends State<MyPINPage> {
  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'My PIN',
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
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/ganti_pin');
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10.sp,
                      bottom: 10.sp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ganti PIN',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: blackColor,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/lupa_pin');
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10.sp,
                      bottom: 10.sp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lupa PIN',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: blackColor,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}