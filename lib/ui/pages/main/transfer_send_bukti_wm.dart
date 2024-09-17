// import 'dart:io';
// import 'dart:typed_data';
import 'dart:async';
// import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:share_plus/share_plus.dart';
import '../../../shared/theme.dart';

class SendBuktiTransferWM extends StatefulWidget {
  const SendBuktiTransferWM({super.key});

  @override
  State<SendBuktiTransferWM> createState() => _SendBuktiTransferWMState();
}

class _SendBuktiTransferWMState extends State<SendBuktiTransferWM> {
  GlobalKey _globalKey = GlobalKey();
  late Uint8List _imageBytes;
  @override
  void initState() {
    super.initState();
    // _captureAndSharePng();
    // print('kirim');
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      setState(() {
        _imageBytes = pngBytes;
      });
      Uint8List uint8List = _imageBytes;
      Share.shareXFiles(
        [
          XFile.fromData(
            uint8List,
            name: 'Image Gallery',
            mimeType: 'image/png',
          ),
        ],
        subject: 'Image Gallery',
      );
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    Map<String, dynamic>? jsonData = args as Map<String, dynamic>?;
    // String nomorRekening = jsonData?['nomorRekening'];
    // logger.i(nomorRekening);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        // title: Text(
        //   'Kembali',
        //   style: whiteTextStyle.copyWith(
        //     fontSize: 16.sp,
        //     fontWeight: semiBold,
        //   ),
        // ),
        backgroundColor: blueColor,
        centerTitle: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _captureAndSharePng();
            },
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  size: 20.sp,
                ),
                Text(
                  '  Bagikan    ',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: blueColor,
      body: RepaintBoundary(
        key: _globalKey,
        child: 
          Container(
          color: blueColor,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
            ),
            children: [
              SizedBox(
                height: 50.sp,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 600.sp,
                    width: 360.sp,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.sp,
                      vertical: 2.sp,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                  ),
                  Positioned(
                    top: 107.sp,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.translate(
                        offset: Offset(-16.sp, 0),
                        child: Container(
                          height: 30.sp,
                          width: 30.sp,
                          decoration: BoxDecoration(
                            color: blueColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 107.sp,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Transform.translate(
                        offset: Offset(16.sp, 0),
                        child: Container(
                          height: 30.sp,
                          width: 30.sp,
                          decoration: BoxDecoration(
                            color: blueColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    // left: 105.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0, -40.sp),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: whiteColor, width: 10),
                          ),
                          height: 90.sp,
                          width: 90.sp,
                          child: Container(
                            decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius: BorderRadius.circular(50.sp),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.done,
                                color: whiteColor,
                                size: 70.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'SUKSES !',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Text(
                            'Transaksi Anda telah berhasil',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120.sp,
                    left: 20.sp,
                    right: 20.sp,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(height: 4),
                          Container(
                            width: 360.sp,
                            height: 0,
                            color: Colors.black,
                            child: CustomPaint(
                              painter: DashedLinePainter(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Image.asset(
                            'asset/logo-klikwm-warna.png',
                            width: 150.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 210.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Text(
                            'NOMINAL',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Text(
                            jsonData?['nominal'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270.sp,
                    left: 0.sp,
                    right: 0.sp,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                RoundedBackgroundTextSpan(
                                  text: 'Biaya Admin',
                                  backgroundColor: Colors.amber,
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                TextSpan(
                                  text: jsonData?['biayaAdminSlip'],
                                  style: blackTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 310.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transfer Ke',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          jsonData?['atasNamaTujuan'],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 335.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          // jsonData?['namaBankTujuan']+' ('+jsonData?['rekeningTujuan']+')',
                          '${jsonData?['namaBankTujuan']} (${jsonData?['rekeningTujuan']})',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 380.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transfer Dari',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Waktu Transaksi',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 405.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          jsonData?['namaSumber'],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          jsonData?['waktuTransaksi'],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 425.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          jsonData?['nomorRekening'],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 470.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Pesan',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 490.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          jsonData?['berita'],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 525.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Referensi / ID Transaksi',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 545.sp,
                    left: 10.sp,
                    right: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          jsonData?['norefId'],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 2 // Lebar garis putus-putus
      ..strokeCap = StrokeCap.round;

    final double dashWidth = 5;
    final double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}