import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:myWM/ui/pages/onboarding_page.dart';

// void configLoading() {
//   EasyLoading.instance
//     ..indicatorWidget = CustomLoading()  // Menggunakan custom loading widget
//     ..loadingStyle = EasyLoadingStyle.custom  // Set style ke custom
//     ..maskType = EasyLoadingMaskType.clear  // Mask background
//     ..userInteractions = false  // Prevent user interactions
//     ..dismissOnTap = false;  // Prevent dismiss on tap
// }
// class CustomLoading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Image.asset(
//         'asset/logo/loading.gif',
//         width: 100,
//         height: 100,
//       ),
//     );
//   }
// }

// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false
//     ..customAnimation = CustomAnimation();
// }
// class CustomAnimation extends EasyLoadingAnimation {
//   CustomAnimation();

//   @override
//   Widget buildWidget(
//     Widget child,
//     AnimationController controller,
//     AlignmentGeometry alignment,
//   ) {
//     return Opacity(
//       opacity: controller.value,
//       child: Image.asset('asset/logo/loading.gif'),
//     );
//   }
// }

// class MyAppXX extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter EasyLoading',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TestLoadingPage(title: 'Flutter EasyLoading'),
//       builder: EasyLoading.init(),
//     );
//   }
// }

// class TestLoadingPage extends StatefulWidget {
//   TestLoadingPage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   TestLoadingPageState createState() => TestLoadingPageState();
// }

// class TestLoadingPageState extends State<TestLoadingPage> {
//   Timer? _timer;
//   late double _progress;

//   @override
//   void initState() {
//     super.initState();
//     EasyLoading.addStatusCallback((status) {
//       print('EasyLoading Status $status');
//       if (status == EasyLoadingStatus.dismiss) {
//         _timer?.cancel();
//       }
//     });
//     EasyLoading.showSuccess('Use in initState');
//     // EasyLoading.removeCallbacks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? ''),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               TextField(),
//               Wrap(
//                 runAlignment: WrapAlignment.center,
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: <Widget>[
//                   // TextButton(
//                   //   child: Text('open test page'),
//                   //   onPressed: () {
//                   //     _timer?.cancel();
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (BuildContext context) => OnBoardingPage(data: null,),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   TextButton(
//                     child: Text('dismiss'),
//                     onPressed: () async {
//                       _timer?.cancel();
//                       await EasyLoading.dismiss();
//                       print('EasyLoading dismiss');
//                     },
//                   ),
//                   TextButton(
//                     child: Text('show'),
//                     onPressed: () async {
//                       _timer?.cancel();
//                       await EasyLoading.show(
//                         status: 'loading...',
//                         maskType: EasyLoadingMaskType.black,
//                       );
//                       print('EasyLoading show');
//                     },
//                   ),
//                   TextButton(
//                     child: Text('showToast'),
//                     onPressed: () {
//                       _timer?.cancel();
//                       EasyLoading.showToast(
//                         'Toast',
//                       );
//                     },
//                   ),
//                   TextButton(
//                     child: Text('showSuccess'),
//                     onPressed: () async {
//                       _timer?.cancel();
//                       await EasyLoading.showSuccess('Great Success!');
//                       print('EasyLoading showSuccess');
//                     },
//                   ),
//                   TextButton(
//                     child: Text('showError'),
//                     onPressed: () {
//                       _timer?.cancel();
//                       EasyLoading.showError('Failed with Error');
//                     },
//                   ),
//                   TextButton(
//                     child: Text('showInfo'),
//                     onPressed: () {
//                       _timer?.cancel();
//                       EasyLoading.showInfo('Useful Information.');
//                     },
//                   ),
//                   TextButton(
//                     child: Text('showProgress'),
//                     onPressed: () {
//                       _progress = 0;
//                       _timer?.cancel();
//                       _timer = Timer.periodic(const Duration(milliseconds: 100),
//                           (Timer timer) {
//                         EasyLoading.showProgress(_progress,
//                             status: '${(_progress * 100).toStringAsFixed(0)}%');
//                         _progress += 0.03;

//                         if (_progress >= 1) {
//                           _timer?.cancel();
//                           EasyLoading.dismiss();
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Text('Style'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.0),
//                       child: CupertinoSegmentedControl<EasyLoadingStyle>(
//                         selectedColor: Colors.blue,
//                         children: {
//                           EasyLoadingStyle.dark: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('dark'),
//                           ),
//                           EasyLoadingStyle.light: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('light'),
//                           ),
//                           EasyLoadingStyle.custom: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('custom'),
//                           ),
//                         },
//                         onValueChanged: (value) {
//                           EasyLoading.instance.loadingStyle = value;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Text('MaskType'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.0),
//                       child: CupertinoSegmentedControl<EasyLoadingMaskType>(
//                         selectedColor: Colors.blue,
//                         children: {
//                           EasyLoadingMaskType.none: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('none'),
//                           ),
//                           EasyLoadingMaskType.clear: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('clear'),
//                           ),
//                           EasyLoadingMaskType.black: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('black'),
//                           ),
//                           EasyLoadingMaskType.custom: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('custom'),
//                           ),
//                         },
//                         onValueChanged: (value) {
//                           EasyLoading.instance.maskType = value;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Text('Toast Positon'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.0),
//                       child:
//                           CupertinoSegmentedControl<EasyLoadingToastPosition>(
//                         selectedColor: Colors.blue,
//                         children: {
//                           EasyLoadingToastPosition.top: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('top'),
//                           ),
//                           EasyLoadingToastPosition.center: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('center'),
//                           ),
//                           EasyLoadingToastPosition.bottom: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('bottom'),
//                           ),
//                         },
//                         onValueChanged: (value) {
//                           EasyLoading.instance.toastPosition = value;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Text('Animation Style'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.0),
//                       child:
//                           CupertinoSegmentedControl<EasyLoadingAnimationStyle>(
//                         selectedColor: Colors.blue,
//                         children: {
//                           EasyLoadingAnimationStyle.opacity: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('opacity'),
//                           ),
//                           EasyLoadingAnimationStyle.offset: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('offset'),
//                           ),
//                           EasyLoadingAnimationStyle.scale: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('scale'),
//                           ),
//                           EasyLoadingAnimationStyle.custom: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('custom'),
//                           ),
//                         },
//                         onValueChanged: (value) {
//                           EasyLoading.instance.animationStyle = value;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 20.0,
//                   bottom: 50.0,
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text('IndicatorType(total: 23)'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.0),
//                       child:
//                           CupertinoSegmentedControl<EasyLoadingIndicatorType>(
//                         selectedColor: Colors.blue,
//                         children: {
//                           EasyLoadingIndicatorType.circle: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('circle'),
//                           ),
//                           EasyLoadingIndicatorType.wave: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('wave'),
//                           ),
//                           EasyLoadingIndicatorType.ring: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('ring'),
//                           ),
//                           EasyLoadingIndicatorType.pulse: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('pulse'),
//                           ),
//                           EasyLoadingIndicatorType.cubeGrid: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('cubeGrid'),
//                           ),
//                           EasyLoadingIndicatorType.threeBounce: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Text('threeBounce'),
//                           ),
//                         },
//                         onValueChanged: (value) {
//                           EasyLoading.instance.indicatorType = value;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// class LoadingGif extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Image.asset(
//         'asset/logo/loading.gif',  // Pastikan file GIF ada di folder assets
//         width: 100,
//         height: 100,
//       ),
//     );
//   }
// }