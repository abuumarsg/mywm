import 'package:customizable_datetime_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:myWM/ui/widgets/buttons.dart';

import '../../blocs/user/user_bloc.dart';
import '../../shared/share_methods.dart';
import '../../shared/theme.dart';

const TextStyle pickerTextStyle = TextStyle(    
  color: Color(0xFF101010),
  fontSize: 14,
  fontWeight: FontWeight.w600
);

class PendaftaranAkunTanggal extends StatefulWidget {
  final Map<String, dynamic> dataTanggal;
  const PendaftaranAkunTanggal({
    super.key,
    required this.dataTanggal,
  });

  @override
  State<PendaftaranAkunTanggal> createState() => _PendaftaranAkunTanggalState(dataTanggal);
}

class _PendaftaranAkunTanggalState extends State<PendaftaranAkunTanggal> {
  _PendaftaranAkunTanggalState(this.dataTanggal);
  final Map<String, dynamic> dataTanggal;
  DateTime dateTimeNow = DateTime.now(); 
  DateTime _dateTime = DateTime.now(); 
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  bool disableButton = true;

  @override
  void initState() {
    super.initState();
  }
  final blocUser = UserBloc();

  @override
  Widget build(BuildContext context) {
    String tanggalAwal = _selectedDate.toString().split(' ')[0];
    DateTime dateTime = DateTime.parse(tanggalAwal);
    String tanggalAkhir = DateFormat('EEEE, dd MMMM yyyy', 'id').format(dateTime);
    String jamAwal = _selectedTime.toString().split(' ')[1];
    String timeHour = jamAwal.split(':')[0];
    String timeMinutes = jamAwal.split(':')[1];
    String newDate = '${DateFormat('yyyy-MM-dd').format(dateTime)} $timeHour:$timeMinutes:00';
    DateTime newdateTime = DateTime.parse(newDate);
    DateTime newDateTimeWith30MinutesAdded = dateTimeNow.add(Duration(minutes: 30));
    if (dateTimeNow.isAfter(newdateTime)) {
      Future.delayed(Duration.zero,(){
        showCustomSnackBar(context, 'Tidak bisa memilih tanggal yang sudah lewat.');
      });
      setState(() {
        dateTimeNow = DateTime.now(); 
        disableButton = true;
      });
    }
    if (newDateTimeWith30MinutesAdded.isAfter(newdateTime)) {
      Future.delayed(Duration.zero,(){
        showCustomSnackBar(context, 'jadwal minimal 30 menit setelah pendaftaran.');
      });
      setState(() {
        dateTimeNow = DateTime.now(); 
        disableButton = true;
      });
    }
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.sp),
        height: 86.sp,
        child: CustomNavBarOnboarding(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.sp,
        ),
        children: [
          SizedBox(height: 40.sp,),
          Center(
            child: Text(
              'Tentukan Tanggal dan Jam dimana anda akan dihubungi untuk verifikasi data',
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: regular,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(),
          SizedBox(height: 5.sp,),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 22.sp,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => _openModalPilihTanggal(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.date_range_rounded,
                        color: redColor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 15.sp,),
                      Text(
                        tanggalAkhir,
                        style: blackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: redColor,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.sp,),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 22.sp,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => _openModalPilihJam(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.timer,
                        color: redColor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 15.sp,),
                      Text(
                        '$timeHour:$timeMinutes WIB',
                        style: blackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: redColor,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 250.sp,),
          // Text(disableButton.toString()),
          // Text(newdateTime.toString()),
          SizedBox(
            width: 330.sp,
            height: 40.sp,
            child: TextButton(
              onPressed: () { 
                _konfirmasiTanggal(newDate);
                // Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
              },
              style: TextButton.styleFrom(
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Konfirmasi',
                style: whiteTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ],
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
  _konfirmasiTanggal(String date) {
    if(disableButton){
      showCustomSnackBar(context, 'Harap pilih tanggal dan jam yang sesuai');
    }else{
      Map<String, dynamic> dataBody = {"tanggal": date};
      dataBody.addAll(dataTanggal);
      // logger.i(dataBody);
      blocUser.add(DaftarValidasiJam(dataBody));
      blocUser.stream.listen((stateS) {
        // logger.i(stateS);
        if(stateS is DaftarValidasiJamLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateS is DaftarValidasiJamFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateS.e);
        }
        if (stateS is DaftarValidasiJamSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(context, '/pendaftaran_akun_success', (route) => false);
        }
      });
    }
  }
  
  _openModalPilihTanggal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'Tentukan Tanggal',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.sp,),
            const Divider(),
            CustomizableDatePickerWidget(
              locale: DateTimePickerLocale.id,
              looping: true,
              initialDate: _dateTime,
              dateFormat: "dd-MMMM-yyyy",                            
              pickerTheme: const DateTimePickerTheme(                
                itemTextStyle: pickerTextStyle,
                backgroundColor: Color(0xFFEBEBEB),
                itemHeight: 50,
                pickerHeight: 200,
                dividerTheme: DatePickerDividerTheme(
                  dividerColor: Color(0xFF00A962),
                  thickness: 3,
                  height: 2
                )
              ),
              onChange: (dateTime, selectedIndex) => _dateTime = dateTime             
            ),
            SizedBox(height: 10.sp,),
            ElevatedButton(
              onPressed: () => setState(() {
                _selectedDate = _dateTime;
                disableButton = false;
                Navigator.pop(context);
              }),
              child: Text(
                'Oke',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.sp,),
          ],
        );
      },
    );
  }
  _openModalPilihJam() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'Tentukan Jam',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.sp,),
            const Divider(),
            CustomizableTimePickerWidget(
              locale: DateTimePickerLocale.id,                       
              timeFormat: "HH:mm",                            
              pickerTheme: const DateTimePickerTheme(                
                itemTextStyle: pickerTextStyle,                  
                itemHeight: 50,
                pickerHeight: 200,
                dividerTheme: DatePickerDividerTheme(
                  dividerColor: Color(0xFF00A962),
                  thickness: 3,
                  height: 2
                )
              ),
              onChange: (dateTime, selectedIndex) => _dateTime = dateTime             
            ),
            SizedBox(height: 10.sp,),
            ElevatedButton(
              onPressed: () => setState(() {
                _selectedTime = _dateTime;
                disableButton = false;
                Navigator.pop(context);
              }),
              child: Text(
                'Oke',                
                style: TextStyle(
                  color: greenColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.sp,),
          ],
        );
      },
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