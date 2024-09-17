import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myWM/shared/share_methods.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';

import '../../../blocs/transfer/transfer_bloc.dart';
import '../../../shared/share_methods.dart';

class TransferSesamaWMNeedPIN extends StatefulWidget {
  final Map<String, dynamic> dataPIN;
  const TransferSesamaWMNeedPIN({
    super.key,
    required this.dataPIN,
    });

  @override
  State<TransferSesamaWMNeedPIN> createState() => _TransferSesamaWMNeedPINState(dataPIN);
}

class _TransferSesamaWMNeedPINState extends State<TransferSesamaWMNeedPIN> {
  _TransferSesamaWMNeedPINState(this.dataPIN);
  var logger = Logger();
  final blocTransfer = TransferBloc();
  final Map<String, dynamic> dataPIN;
  final TextEditingController pinController = TextEditingController(text: '');
  addPin(String number){
    if(pinController.text.length < 6){
      setState(() {
        pinController.text = pinController.text + number;
      });
    }
    if(pinController.text.length == 6){
      Map<String, dynamic> dataBody = dataPIN;
      Map<String, dynamic> kodePin = {"pin": pinController.text};
      dataBody.addAll(kodePin);
      blocTransfer.add(TransferSesamaSendValidasiPIN(dataBody));
      blocTransfer.stream.listen((stateS) {
        logger.i(stateS);
        if(stateS is TfSesamaSendPINValidasiLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateS is TfSesamaSendPINValidasiFailed) {
          EasyLoading.dismiss();
          pinController.text = '';
          showCustomSnackBar(context, stateS.e);
        }
        if (stateS is TfSesamaSendPINValidasiSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, '/transfer_success_page', (route) => false);
        }
      });
      // if(pinController.text == '123123'){
      //   // Navigator.pushNamedAndRemoveUntil(context, '/lupa_username_success', (route) => false);
      //   // showCustomSnackBar(context, 'PIN yang anda masukkan BENAR');
      //   _showDialogSuccess(context);
      // }else{
      //   showCustomSnackBar(context, 'PIN yang anda masukkan salah');
      // }
    }
  }
  deletePin(){
    if(pinController.text.isNotEmpty){
      setState(() {
        pinController.text = pinController.text.substring(0, pinController.text.length - 1);
      });
    }
  }
  List<String> buttonTitles = ButtonTitleProvider.getShuffledTitles();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Konfirmasi PIN',
          style: whiteTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueBackgroundColor,
        centerTitle: true,
      ),
      backgroundColor: blueBackgroundColor,
      body: Container(
        height: 800.sp,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 28.sp,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.sp,),
                  Text(
                    'Masukkan PIN Anda',
                    style: blackTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 32.sp,
                  ),
                  SizedBox(
                    width: 210.sp,
                    child: TextFormField(
                      controller: pinController,
                      // keyboardType: TextInputType.number,
                      obscureText: true, 
                      cursorColor: greyColor,
                      obscuringCharacter:  '*',
                      enabled: false,
                      // initialValue: '23432',
                      style:  blackTextStyle.copyWith(
                        fontSize: 36.sp,
                        fontWeight: semiBold,
                        letterSpacing: 15.sp,
                      ),
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greenColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInputButton(
                        title: buttonTitles[0],
                        onTap: () {
                          addPin(buttonTitles[0]);
                        },
                      ),
                      SizedBox(width: 20.sp),
                      CustomInputButton(
                        title: buttonTitles[1],
                        onTap: () {
                          addPin(buttonTitles[1]);                      
                        },
                      ),
                      SizedBox(width: 20.sp),
                      CustomInputButton(
                        title: buttonTitles[2],
                        onTap: () {
                          addPin(buttonTitles[2]);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInputButton(
                        title: buttonTitles[3],
                        onTap: () {
                          addPin(buttonTitles[3]);
                        },
                      ),
                      SizedBox(width: 20.sp),
                      CustomInputButton(
                        title: buttonTitles[4],
                        onTap: () {
                          addPin(buttonTitles[4]);                      
                        },
                      ),
                      SizedBox(width: 20.sp),
                      CustomInputButton(
                        title: buttonTitles[5],
                        onTap: () {
                          addPin(buttonTitles[5]);                      
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInputButton(
                        title: buttonTitles[6],
                        onTap: () {
                          addPin(buttonTitles[6]);
                        },
                      ),
                      SizedBox(width: 20.sp),
                      CustomInputButton(
                        title: buttonTitles[7],
                        onTap: () {
                          addPin(buttonTitles[7]);                      
                        },
                      ),
                      SizedBox(width: 20.sp),
                      CustomInputButton(
                        title: buttonTitles[8],
                        onTap: () {
                          addPin(buttonTitles[8]);                      
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.sp,
                        width: 60.sp,
                      ),
                      SizedBox(width: 20.sp.sp),
                      CustomInputButton(
                        title: buttonTitles[9],
                        onTap: () {
                          addPin(buttonTitles[9]);                      
                        },
                      ),
                      SizedBox(width: 20.sp.sp),
                      GestureDetector(
                        onTap: () {
                          deletePin();
                        },
                        child: Container(
                          width: 60.sp,
                          height: 60.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: numberWhitegroundColor,
                            border: Border.all(color: blackColor),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: blackColor,
                              size: 26.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showDialogSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Icon(
              Icons.task_alt,
              color: greenColor,
              size: 90.sp,
            ),
          ),
          content: Text(
            'Permintaan Transfer Anda\nBerhasil Dikirim',
            style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}