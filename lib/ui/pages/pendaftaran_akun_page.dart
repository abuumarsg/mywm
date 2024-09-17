import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
// import 'package:myWM/ui/widgets/custom_widget.dart';

import '../../shared/global_data.dart';

class PendaftaranAkunPage extends StatefulWidget {
  const PendaftaranAkunPage({super.key});

  @override
  State<PendaftaranAkunPage> createState() => _PendaftaranAkunPageState();
}

class _PendaftaranAkunPageState extends State<PendaftaranAkunPage> {
  Stream<int> _autoRefreshStream() async* {
    int counter = 0;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      counter++;
      yield counter;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: StreamBuilder<int>(
          stream: _autoRefreshStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'PERMOHONAN PENGGUNAAN FASILITAS TRANSFER ONLINE melalui KLIK WM - PT Bank Weleri Makmur',
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                  const Divider(
                    color: Colors.black
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        HtmlWidget(
                          '''
                            $syaratPendaftaran
                          '''
                        ),
                        SizedBox(height: 40.sp,),
                        SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 160.sp,
                                height: 40.sp,
                                child: TextButton(
                                  onPressed: () { 
                                    Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: redColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    'TOLAK',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 160.sp,
                                height: 40.sp,
                                child: TextButton(
                                  onPressed: () { 
                                    // Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
                                    Navigator.pushNamed(context, '/pendaftaran_ktp');
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: greenColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    'TERIMA',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],                   
                          ),
                        ),
                        SizedBox(height: 10.sp,),
                      ],
                    )
                  )
                ],
              );
            }
          },
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