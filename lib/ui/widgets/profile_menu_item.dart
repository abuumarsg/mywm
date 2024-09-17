import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    Key? key,
    required this.iconUrl,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 30.sp,
        ),
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              width: 24.sp,
            ),
            SizedBox(
              width: 18.sp,
            ),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
