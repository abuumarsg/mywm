// import 'dart:async';
// import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import '../../../blocs/transfer/transfer_bloc.dart';
// import '../../../models/form_transfer_sesama_model.dart';
// import '../../../models/rekening_transfer_model.dart';
import '../../../shared/global_data.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'rekening_kredit_otp.dart';
// import 'package:http/http.dart' as http;

class RekeningKreditPage extends StatefulWidget {
  final Map<String, dynamic> dataKredit;
  const RekeningKreditPage({super.key, required this.dataKredit});

  @override
  State<RekeningKreditPage> createState() => _RekeningKreditPageState(dataKredit);
}

class _RekeningKreditPageState extends State<RekeningKreditPage> {
  var logger = Logger();
  _RekeningKreditPageState(this.dataKredit);
  Map<String, dynamic> dataKredit;
  bool _isValid = true;
  String _selectedOptionFor = '';
  final TextEditingController _controllerNominal = TextEditingController();
  final _controllerTujuan = TextEditingController(text: '');
  final _controllerNomorRekeningKredit = TextEditingController(text: '');
  final _controllerNomorRekeningTabungan = TextEditingController(text: '');
  bool validate() {
    if (_controllerNominal.text.isEmpty || _controllerTujuan.text.isEmpty) {
      return false;
    }
    return true;
  }
  //==========================================================================================================================
  final blocTransfer = TransferBloc();
  List<File> _files = [];
  // String _responseMessage = '';
  Future<void> _pickFile() async {
    if (await Permission.storage.request().isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (result != null) {
        setState(() {
          _files.add(File(result.files.single.path!));
        });
      }
    } else {
      print('Permission denied');
    }
  }

  void _removeFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }
  
  functionUploadFile()
  {
      Map<String, dynamic> dataBody = {
        "nominal": _controllerNominal.text,
        "tujuanPenggunaan": _controllerTujuan.text,
        "nomorRekeningKredit": _controllerNomorRekeningKredit.text,
        "nomorRekeningTujuan": _controllerNomorRekeningTabungan.text,
        "file": _files,
      };
      blocTransfer.add(PengajuanRekeningKredit(dataBody));
      blocTransfer.stream.listen((stateS) {
        logger.i(stateS);
        if(stateS is PengajuanRekeningKreditLoading){
          EasyLoading.show(
            status: 'loading...',
            maskType: EasyLoadingMaskType.clear, 
          );
        }
        if (stateS is PengajuanRekeningKreditSuccess) {
          EasyLoading.dismiss();
          // Navigator.pushNamedAndRemoveUntil(context, '/transfer_success_page', (route) => false);
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: ( context) => RekeningKreditOTPPage(dataOTP: stateS.dataResult),
            ),
          );
        }
        if (stateS is PengajuanRekeningKreditFailed) {
          EasyLoading.dismiss();
          showCustomSnackBar(context, stateS.e);
        }
      });
  }
  

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    Map<String, dynamic> dataFavorit = dataKredit;
    String resultData =_selectedOptionFor;
    _controllerTujuan.text = resultData.isNotEmpty ? _selectedOptionFor.toString() :  _controllerTujuan.text;
    _controllerNomorRekeningKredit.text = dataFavorit['nomorRekening'].toString();
    _controllerNomorRekeningTabungan.text = dataFavorit['nomorRekeningTabungan'].toString();
    
    List<String> keteranganDokumen = getDataFromKey(_selectedOptionFor.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Rekening Kredit',
          style: whiteTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueColor,
        centerTitle: true,
      ),
      backgroundColor: lightBackgroundColor,
      body: BlocConsumer<TransferBloc, TransferState>(
        listener: (context, transferState) {
          // logger.i(transferState);
        },
        builder: (context, state) {
          return ListView(
            children: <Widget>[
              SizedBox(
                height: 20.sp,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.sp,
                ),
                child: Row(
                  children: [
                    Text(
                      '  Permohonan Penarikan Data Fasilitas Kredit',
                      style: blackTextStyle.copyWith(
                        fontWeight: black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Container(
                height: 300.sp,
                margin: EdgeInsets.only(
                  left: 10.sp,
                  right: 10.sp,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: greyColor, width: 1),
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                        vertical: 10.sp,
                      ),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(topLeft:Radius.circular(10.sp), topRight:Radius.circular(10.sp)),
                        color: greenColor,
                      ),
                      child: Row(
                        children: [                    
                          Text(
                            'Sumber Dana',
                            style: whiteTextStyle.copyWith(
                              fontWeight: black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nomor Rekening Kredit',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  dataFavorit['nomorRekening'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jenis Kredit',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  dataFavorit['namaJenis'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nama',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  dataFavorit['atasNama'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nomor Rekening Tabungan',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  dataFavorit['nomorRekeningTabungan'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Container(
                height: 335.sp,
                margin: EdgeInsets.only(
                  left: 10.sp,
                  right: 10.sp,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: greyColor, width: 1),
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                        vertical: 10.sp,
                      ),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(topLeft:Radius.circular(10.sp), topRight:Radius.circular(10.sp)),
                        color: greenColor,
                      ),
                      child: Row(
                        children: [                    
                          Text(
                            'Fasilitas Dana',
                            style: whiteTextStyle.copyWith(
                              fontWeight: black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Plafon Kredit',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  'Rp. ${dataFavorit['plafon']}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Baki Debet',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  'Rp. ${dataFavorit['bakiDebet']}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: SizedBox(
                        height: 41.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Kelonggaran Tarik',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  'Rp. ${dataFavorit['kelonggaranTarik']}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 15.sp,
                    ),
                    TextFormField(
                      controller: _controllerNominal,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Nominal Permohonan',
                        labelStyle:
                            TextStyle(fontSize: 20.sp, fontWeight: semiBold, color: greyColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'Masukkan Nominal Permohonan',
                        hintStyle: TextStyle(fontSize: 14.sp, color: greyColor),
                        errorText: _isValid ? null : 'Nominal Tidak Boleh Melebihi Kelonggaran Tarik',
                        errorStyle: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        setState(() {
                          _controllerNominal.text = FormatCurrency.formatRupiah(value);
                          _isValid = _validateInputNominal(_controllerNominal.text, dataFavorit['kelonggaranTarik']);
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Expanded(
                child: Container(
                  height: 600.sp,
                  margin: EdgeInsets.only(
                    left: 10.sp,
                    right: 10.sp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: greyColor, width: 1),
                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 10.sp,
                        ),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(topLeft:Radius.circular(10.sp), topRight:Radius.circular(10.sp)),
                          color: greenColor,
                        ),
                        child: Row(
                          children: [                    
                            Text(
                              'Tujuan Penggunaan',
                              style: whiteTextStyle.copyWith(
                                fontWeight: black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.sp,
                      ),
                      TextFormField(
                        controller: _controllerTujuan,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Tujuan Penggunaan',
                          labelStyle:
                              TextStyle(fontSize: 20.sp, fontWeight: semiBold, color: greyColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: 'Pilih Tujuan Penggunaan',
                          hintStyle: TextStyle(fontSize: 14.sp, color: greyColor),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () {
                                  _openModalRekening();
                                },
                                color: blackColor,
                              ),
                            ],
                          ),
                        ),
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      if(keteranganDokumen.isNotEmpty)
                      Text(
                        'Silahkan lampirkan dokumen berikut :',
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black.withOpacity(0.6),
                          height: 1.55,
                        ),
                      ),
                      BulletListDot(keteranganDokumen),
                      SizedBox( height: 15.sp, ),
                      DottedBorder(
                        color: greyColor,
                        strokeWidth: 2,
                        dashPattern: const [6, 3],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.sp),
                        child: Container(
                          height: 200,
                          width: 350.sp,
                          color: Colors.white,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              if (_files.isEmpty)
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 50.sp,
                                    ),
                                    Text(
                                      "Upload File (Optional)\ndengan format jpg, jpeg, png, pdf",
                                      style: blackTextStyle.copyWith(
                                        fontWeight: medium,
                                        fontSize: 12.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox( height: 10.sp, ),
                                  ],
                                ),
                              ),
                              if (_files.isNotEmpty)
                              SizedBox(
                                height: 140,
                                child: ListView.builder(
                                  itemCount: _files.length,
                                  itemBuilder: (context, innerIndex) {
                                    return SizedBox(
                                      height: 40.sp,
                                      child: ListTile(
                                        title: Text(
                                          _files[innerIndex].path.split('/').last,
                                          style: blackTextStyle.copyWith(
                                            fontWeight: medium,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: 20.sp,
                                            color: redColor,
                                          ),
                                          onPressed: () => _removeFile(innerIndex),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: _pickFile,
                                style: TextButton.styleFrom(
                                  fixedSize: Size(110.sp, 3.sp),
                                  backgroundColor: springGreenColor,
                                  side: BorderSide(color: greenColor, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Pilih File',
                                  style: greenTextStyle.copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text(_responseMessage),
                      SizedBox( height: 25.sp, ),
                      Column(
                        children: [
                          CustomFilledButton2(
                            title: 'Lanjut',
                            onPressed: () {
                              if (validate()) {
                                if (_isValid) {
                                  functionUploadFile();
                                }else{
                                  showCustomSnackBar(context, 'Harap Cek Data Kembali');
                                }
                              } else {
                                showCustomSnackBar(context, 'Nominal Permohonan dan Tujuan Penggunaan harus diisi !');
                              }
                            },
                            width: 400.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  _openModalRekening() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'Pilih Data',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: tujuanPenggunaan.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 50.sp,
                  margin: EdgeInsets.only(
                    left: 10.sp,
                    right: 10.sp,
                    top: 10.sp,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor, width: 1),
                  ),
                  child: SizedBox(
                    // height: 60.sp,
                    child: GestureDetector(
                      onTap: () {
                        _selectOption(
                          tujuanPenggunaan[index],
                        );
                        // _isValid = _validateInputNominal(_controllerNominal.text, _selectedOptionNominal);
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 16.sp),
                                child: SizedBox(
                                  width: 270.sp,
                                  child: Text(
                                    tujuanPenggunaan[index],
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 160.sp,
            ),
          ],
        );
      },
    );
  }

  _selectOption(String untuk) {
    setState(() {
      _selectedOptionFor = untuk;
    });
  }
  bool _validateInputNominal(String input, String maksimal) {
    try {
      String nominal = StringReplace.replaceString(input, 'Rp ', '');
      String nominalinput = StringReplace.replaceString(nominal, '.', '');
      double myinput = double.parse(nominalinput);
      String nominalMaksimal = StringReplace.replaceString(maksimal, '.', '');
      double myMaksimal = double.parse(nominalMaksimal.replaceAll(',', '.'));
      if(myinput > myMaksimal){
          return false;
      }else{
        return true;
      }
    } catch (e) {
      return false;
    }
  }
  List<String> getDataFromKey(String key) {
    Map<String, List<String>> data = dataTujuanPenggunaan;
    return data[key] ?? [];
  }

}