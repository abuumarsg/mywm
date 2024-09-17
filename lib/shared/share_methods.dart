import 'package:another_flushbar/flushbar.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myWM/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showCustomSnackBar2(BuildContext context, String message){
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}
void showCustomSnackBar(context, String message){
  Flushbar(
    // title: 'ERROR',
    icon: Icon(
      Icons.info_outline,
      size: 20.0,
      color: whiteColor,
    ),
    message: message,
    messageColor: whiteColor,
    messageSize: 12,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    // flushbarStyle: FlushbarStyle.GROUNDED,
    // flushbarStyle: FlushbarStyle.FLOATING,
    // reverseAnimationCurve: Curves.decelerate,
    // forwardAnimationCurve: Curves.easeIn,
    backgroundColor: Colors.red.withOpacity(1),
    borderColor: whiteColor,
    borderWidth: 2,
    duration: Duration(seconds: 7),
  ).show(context);
}
void showCustomSnackBarTime(context, String message, {int detik=7}){
  Flushbar(
    // title: 'ERROR',
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: whiteColor,
    ),
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: redColor,
    duration: Duration(seconds: detik),
  ).show(context);
}
void showCustomSnackBarSuccess(context, String message){
  Flushbar(
    // title: 'ERROR',
    icon: Icon(
      Icons.check_circle_outline,
      size: 28.0,
      color: whiteColor,
    ),
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: greenColor,
    duration: const Duration(seconds: 7),
  ).show(context);
}
class ManipulasiString {
  static String manipulate(String input) {
    if (input.length <= 4) {
      // Jika panjang string kurang dari atau sama dengan 4, tidak ada yang perlu diubah
      return input;
    }
    // Ambil 4 karakter terakhir
    String empatAngkaTerakhir = input.substring(input.length - 4);
    // Ganti karakter sebelumnya dengan 4 karakter saja
    // String karakterDidepan = input.substring(0, input.length - 4);
    String karakterDiganti = "****"; // Ganti dengan karakter yang diinginkan
    // Gabungkan hasil akhir
    // String hasil = karakterDidepan + karakterDiganti + empatAngkaTerakhir;
    String hasil = karakterDiganti + empatAngkaTerakhir;
    return hasil;
  }
}
class FormatCurrency{
  static String formatRupiah(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    // Convert to integer
    int intValue = int.tryParse(value) ?? 0;
    // Format as currency
    String formattedValue = 'Rp ${intValue.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
    return formattedValue;
  }
}
class StringReplace{
  static String replaceString(String originalString, String searchString, String replacementString) {
    // String originalString = "Hello, world!";
    // String searchString = "world";
    // String replacementString = "Flutter";
    String modifiedString = originalString.replaceAll(searchString, replacementString);
    return modifiedString;
  }
  static double replace2DigitKoma(double originalNumber) {
    // try {
    //   double myDouble = double.parse(originalNumber.replaceAll(',', '.'));
    //   print(myDouble);
    // } catch (e) {
    //   print("Error: $e");
    // }
    var modifiedNumber = double.parse(originalNumber.toStringAsFixed(2));
    return modifiedNumber;
  }
}

Future<XFile?> selectImage() async{
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return selectedImage;
}

Future<XFile?> pickImageFromCamera() async {
  try {
    XFile? imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera
    );
    return imagePicker;
  } catch (e) {
    print('Kesalahan saat mengambil gambar: $e');
    return null;
  }
}
class ButtonTitleProvider {
  static List<String> getShuffledTitles() {
    List<String> buttonTitles = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
    buttonTitles.shuffle();  
    return buttonTitles;
  }
}

void showLoadingIndicator(){
  EasyLoading.show();
  // EasyLoading.show(
  //   status: 'loading...',
  //   maskType: EasyLoadingMaskType.clear, 
  // );
}
void hideLoadingIndicator(){
  EasyLoading.dismiss();
}

Widget buildLoadingIndicator({
  // Indicator indicatorType = Indicator.ballPulse,
  Indicator indicatorType = Indicator.ballPulseSync,
  List<Color> colors = const [Colors.white],
  double strokeWidth = 2.0,
  Color backgroundColor = Colors.transparent,
  Color pathBackgroundColor = Colors.transparent,
}) {
  return LoadingIndicator(
    indicatorType: indicatorType,
    colors: colors,
    strokeWidth: strokeWidth,
    backgroundColor: backgroundColor,
    pathBackgroundColor: pathBackgroundColor,
  );
}

Widget cardLoadingAll(int jumlah) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: jumlah,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp, bottom: 20.sp),
        child: const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardLoading(
                height: 30,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                width: 100,
                margin: EdgeInsets.only(bottom: 10),
              ),
              CardLoading(
                height: 100,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                margin: EdgeInsets.only(bottom: 10),
              ),
              CardLoading(
                height: 30,
                width: 200,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                margin: EdgeInsets.only(bottom: 10),
              ),
            ],
          ),
        ),
      );
    }
  );
}


