import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
import 'package:flutter/material.dart';
// import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';

import '../../shared/global_data.dart';

var logger = Logger();
// ignore: must_be_immutable
class OnboardingHeader extends StatefulWidget {

  OnboardingHeader({super.key});

  @override
  State<OnboardingHeader> createState() => _OnboardingHeaderState();
}

class _OnboardingHeaderState extends State<OnboardingHeader> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // logger.i(imagesBanner);
    return  CarouselSlider(
      items: imagesBanner.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
              // child: Image.network(
              //   image,
              //   fit: BoxFit.cover,
              // ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 235.sp,
        enlargeCenterPage: true,
        autoPlay: true,
        // aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex =index;
          });
        },
      ),
    );
  }  

  // @override
  // void setState(Null Function() param0) {}
}

class WelcomeOnboarding extends StatelessWidget {
  const WelcomeOnboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Selamat datang di ',
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 7,
        ),
        Image.asset(
          'asset/logo-klikwm-warna.png',
          width: 85.sp,
        ),
      ],
    );
  }
}

class OtherServiceOnboarding extends StatelessWidget {
  const OtherServiceOnboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5.sp,
        left: 5.sp,
        right: 5.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 70.sp,
                height: 70.sp,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.circular(20),
                  color: whiteColor,
                ),
                child: Center(
                  child: Image.asset(
                    'asset/logo/kredit.png',
                    width: 50.sp,
                  ),
                ),
              ),
              Text(
                'Permohonan Kredit',
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 70.sp,
                height: 70.sp,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.circular(20),
                  color: whiteColor,
                ),
                child: Center(
                  child: Image.asset(
                    'asset/logo/tabungan.png',
                    width: 55.sp,
                  ),
                ),
              ),
              Text(
                'Pembukaan Tabungan',
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 70.sp,
                height: 70.sp,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.circular(20),
                  color: whiteColor,
                ),
                child: Center(
                  child: Image.asset(
                    'asset/logo/deposito.png',
                    width: 50.sp,
                  ),
                ),
              ),
              Text(
                'Pembukaan Deposito',
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     SizedBox(
      //       height: 5.sp,
      //     ),
      //     const Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         OnboardingOtherApp(
      //           iconUrl: 'asset/logo/kredit.png', 
      //           title: '',
      //           url: 'https://kredit69.com',
      //         ),
      //         OnboardingOtherApp(
      //           iconUrl: 'asset/logo/tabungan.png', 
      //           title: '',
      //           url: 'https://klikwm.com/pembukaan-tabungan-online.html',
      //         ),
      //         OnboardingOtherApp(
      //           iconUrl: 'asset/logo/deposito.png', 
      //           title: '',
      //           url: 'https://klikwm.com/pembukaan-deposito-online.html',
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}