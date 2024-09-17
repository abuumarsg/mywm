import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFilledButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomFilledButton({
    Key? key,
    required this.title, 
    this.width = double.infinity, 
    this.height = 40, 
    this.onPressed,    
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height.sp,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}


class CustomFilledButton2 extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomFilledButton2({
    Key? key,
    required this.title, 
    this.width = 10, 
    this.height = 40, 
    this.onPressed,    
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.sp,
      height: height.sp,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: blueBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final double size;
  final VoidCallback? onPressed;

  const CustomTextButton({
    Key? key,
    required this.title, 
    this.width = 200,//double.infinity, 
    this.height = 24,
    this.size = 12,
    this.onPressed,  
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.sp,
      height: height.sp,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: blueTextStyle.copyWith(
            fontSize: size.sp,
          ),
        ),
      ),
    );
  }
}

class CustomInputButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomInputButton({
    Key? key,
    required this.title, 
    this.onTap,  
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.sp,
        height: 60.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: numberWhitegroundColor,
          border: Border.all(color: blackColor),
        ),
        child: Center(
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingOtherApp extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String url;
  final VoidCallback? onTap;


  const OnboardingOtherApp({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.url,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchURL(url);
        // ignore: deprecated_member_use
        // if(await canLaunch(url)){
        //   // ignore: deprecated_member_use
        //   launch(url);
        // }
      },
      child: Column(
        children: [
          Container(
            width: 90.sp,
            height: 90.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: whiteColor,
            ),
            child: Center(
              child: Image.asset(
                iconUrl,
                width: 80.sp,
              ),
            ),
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
  Future<void> launchURL(url) async {
    // final Uri urlx = Uri.parse('https://bprwm.co.id/kantor-layanan');
    final Uri urlx = Uri.parse(url);
    if (!await launchUrl(urlx)) {
      throw Exception('Could not launch $urlx');
    }
  }
}


class CustomNavBarOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: whiteColor,
      // unselectedItemColor: blackColor,
      // showSelectedLabels: true,
      // showUnselectedLabels: true,
      // selectedLabelStyle: blueTextStyle.copyWith(
      //   fontSize: 10,
      //   fontWeight: medium,
      // ),
      // unselectedLabelStyle: blackTextStyle.copyWith(
      //   fontSize: 10,
      //   fontWeight: medium,
      // ),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'asset/logo-bprwm.png',
            width: 120.sp,
            // height: 30.sp,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'asset/logo_ojk.png',
            width: 100.sp,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'asset/logo_lps.png',
            width: 100.sp,
          ),
          label: '',
        ),
      ],
      onTap:(value) => () {
        launchURLX();
      },
    );
  }
  Future<void> launchURLX() async {
    final Uri urlx = Uri.parse('https://bprwm.co.id/');
    if (!await launchUrl(urlx)) {
      throw Exception('Could not launch $urlx');
    }
  }
}


class OTPInput extends StatefulWidget {
  final Function(String) onCompleted;

  const OTPInput({Key? key, required this.onCompleted}) : super(key: key);

  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  List<String> _otp = List.filled(6, '');
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 50,
          child: TextFormField(
            focusNode: _focusNodes[index],
            onChanged: (value) {
              if (value.length == 1) {
                _otp[index] = value;
                if (index < 5) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                } else {
                  widget.onCompleted(_otp.join());
                }
              }
            },
            style: blackTextStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: bold,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              counterText: '',
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}


class cardMenuUtama extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onPressed;

  const cardMenuUtama({
    Key? key,
    required this.title, 
    required this.icon, 
    this.onPressed,    
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              icon,
              width: 35.sp,
            ),
          ),
          Text(
            title,
            style: darkBlueTextStyle.copyWith(
              fontSize: 11.sp,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}



