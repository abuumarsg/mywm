import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myWM/shared/theme.dart';
import 'package:flutter/material.dart';
// import 'package:sweetalertv2/sweetalertv2.dart';
// import 'package:url_launcher/url_launcher.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: strings.map((str) {
        children: strings.mapIndexed((index, str) {
          final ind = (index + 1).toInt();
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$ind. ",
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.55,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black.withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
class BulletListDot extends StatelessWidget {
  final List<String> strings;

  BulletListDot(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.mapIndexed((index, str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: 12.sp,
                color: Colors.black.withOpacity(0.6),
              ),
              SizedBox(
                width: 10.sp,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black.withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}


class loadModalLoading extends StatefulWidget {
  @override
  _loadModalLoadingState createState() => _loadModalLoadingState();
}

class _loadModalLoadingState extends State<loadModalLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.141592653589793, // Two times pi for a full circle
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: Container(
        // color: blueColor,
        width: 100,
        height: 100,
        child: Image.asset('asset/klik_kira.png'), // Ganti dengan path/logo kustom Anda
      ),
    );
  }
}


class MyCustomLoadingWidget extends StatefulWidget {
  @override
  _MyCustomLoadingWidgetState createState() => _MyCustomLoadingWidgetState();
}

class _MyCustomLoadingWidgetState extends State<MyCustomLoadingWidget>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.141592653589793,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: Container(
        width: 100,
        height: 100,
        child: Image.asset(
          'asset/klik_kira.png', // Ganti dengan path/logo kustom Anda
        ),
      ),
    );
  }
}

