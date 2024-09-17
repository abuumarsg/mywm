
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myWM/shared/theme.dart';

import '../../../shared/share_values.dart';

class KiraPage extends StatelessWidget {
  const KiraPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'KIRA',
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
        // resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              SizedBox(
                height: 750.sp,
                child: const SingleChildScrollView(
                  child: HtmlWidget(
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
              ),
              Positioned(
                top: 610.sp,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: Offset(0, 0),
                    child: Container(
                      height: 150.sp,
                      width: 400.sp,
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: redColor,
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(20),
              //       topRight: Radius.circular(20),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class RekeningPage extends StatefulWidget {
//   const RekeningPage({super.key});

//   @override
//   State<RekeningPage> createState() => RekeningPageState();
// }

// class RekeningPageState extends State<RekeningPage> {
//   @override
//   Widget build(BuildContext context) {
//     // return Center();
//     return Scaffold(
//       bottomNavigationBar: const MainMenuBar(),
//       floatingActionButton: menuBarTengah(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       backgroundColor: lightBackgroundColor,
//       body: Center(
//         child: Text('Rekening'),
//       ),
//     );
//   }
// }