import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String placeHolder;
  final bool obscureText;
  final bool readOnly;
  final bool filled;
  final TextEditingController? controller;

  const CustomFormField({
    Key? key,
    required this.title, 
    this.obscureText = false, 
    this.readOnly = false, 
    this.filled = false, 
    this.controller,    
    required this.placeHolder,    
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        TextFormField(
          readOnly: readOnly,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: EdgeInsets.all(12),            
            hintText: placeHolder,
            filled: filled, 
            // hintTextStyle: placeHolder,
          ),
        ),
      ],
    );
  }
}


class Marquee extends StatefulWidget {
  final String text;
  final TextStyle? style;

  Marquee({required this.text, this.style});

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 3.0,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Text(widget.text, style: widget.style),
    );
  }
}