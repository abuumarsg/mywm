// import 'dart:convert';

import 'dart:async';
import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/ui/pages/main/transfer_sesama_wm_next.dart';
import 'package:logger/logger.dart';
import '../../../blocs/transfer/transfer_bloc.dart';
import '../../../models/form_transfer_sesama_model.dart';
// import '../../../models/rekening_favorit_model.dart';
import '../../../models/rekening_transfer_model.dart';
// import '../../../models/transfer_sesama_model.dart';
import '../../../models/transfer_sesama_model.dart';
import '../../../shared/global_data.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';
// import '../example/card_rekening_fav.dart';
// import '../../widgets/card_rekening_favorit.dart';

class TransferSesamaWM extends StatefulWidget {
  final Map<String, dynamic> dataFav;
  const TransferSesamaWM({super.key, required this.dataFav});

  @override
  State<TransferSesamaWM> createState() => _TransferSesamaWMState(dataFav);
}

class _TransferSesamaWMState extends State<TransferSesamaWM> {
  var logger = Logger();
  _TransferSesamaWMState(this.dataFav);
  Map<String, dynamic> dataFav;
  bool _isValid = true;
  RekeningForTransferModel? selectedRekeningTransfer;
  String _selectedOptionRek = globalListRekeningTransfer.isNotEmpty
      ? globalListRekeningTransfer[0].nomorRekening
      : '';
  String _selectedOptionNama = globalListRekeningTransfer.isNotEmpty
      ? globalListRekeningTransfer[0].nama
      : '';
  String _selectedOptionJenis = globalListRekeningTransfer.isNotEmpty
      ? globalListRekeningTransfer[0].jenis
      : '';
  String _selectedOptionNominal = globalListRekeningTransfer.isNotEmpty
      ? globalListRekeningTransfer[0].saldo
      : '';
  String minimalTransfer = globalListRekeningTransfer.isNotEmpty
      ? globalListRekeningTransfer[0].minimalTransfer
      : '0';
  final TextEditingController _controllerNominal = TextEditingController();
  final nomorRekeningController = TextEditingController(text: '');
  final pesanController = TextEditingController(text: '');
  bool validate() {
    if (_controllerNominal.text.isEmpty ||
        nomorRekeningController.text.isEmpty) {
      return false;
    }
    return true;
  }
  
  bool picFavorit = false;
  final List<Map<String, dynamic>> _allFavorit = List<Map<String, dynamic>>.from(
      json.decode(jsonEncode(globalListFavoritWM)).map((x) => Map<String, dynamic>.from(x)));

  Map<String, dynamic> _selectedResult = {};
  void _openModalFavorit() async {
    Map<String, dynamic>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterModalRekeningFavorit(_allFavorit);
      },
    );
    if (result != null) {
      setState(() {
        _selectedResult = result;
        picFavorit = true;
      });
    }else{
      setState(() {
        _selectedResult = {};
        picFavorit = false;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    Map<String, dynamic> dataFavorit = dataFav;
    if(dataFavorit.isNotEmpty){
      setState(() {
        picFavorit = true;
      });
    }
    Map<String, dynamic> resultData =_selectedResult;
    nomorRekeningController.text = resultData.isNotEmpty ? resultData["nomorRekening"].toString() 
      : dataFavorit.isNotEmpty ? dataFavorit['nomorRekeningBPRWM'].toString()
      : nomorRekeningController.text;
    String hasil = ManipulasiString.manipulate(_selectedOptionRek);
    return WillPopScope(
      onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, '/perintah_transfer', (route) => false);
          return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Transfer Sesama Rek. Bank WM',
            style: whiteTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: semiBold,
            ),
          ),
          backgroundColor: blueBackgroundColor,
          centerTitle: true,
        ),
        backgroundColor: blueBackgroundColor,
        body: BlocConsumer<TransferBloc, TransferState>(
          listener: (context, transferState) {
            // logger.i(transferState);
            if(transferState is CekPenerimaLoading){
              showLoadingIndicator();
            }
            if(transferState is CekPenerimaFailed){
              EasyLoading.dismiss();
              showCustomSnackBar(context, transferState.e);
            }
            if(transferState is CekAutorFailed){
              EasyLoading.dismiss();
              Future.delayed(Duration.zero,(){
                showCustomSnackBar(context, '${transferState.e}, Please Reload Application');
                Timer(const Duration(seconds: 3),(){
                  // Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
                });
              });
            }
            if(transferState is CekPenerimaSuccess){
              EasyLoading.dismiss();
              // logger.i(transferState);
              Navigator.push(
                context, 
                MaterialPageRoute(
                builder: ( context) => TransferSesamaWMNext(
                  dataTrans: TransferSesamaModel(
                      nomorRekening: transferState.datarek.nomorRekening,
                      nomorRekeningTujuan: transferState.datarek.nomorRekeningTujuan,
                      nominalPengirim: transferState.datarek.nominalPengirim,
                      nominalTransfer: transferState.datarek.nominalTransfer,
                      namaPenerima: transferState.datarek.namaPenerima,
                      jenisTabunganPengirim: transferState.datarek.jenisTabunganPengirim,
                      keterangan: transferState.datarek.keterangan,
                      biayaAdmin: transferState.datarek.biayaAdmin,
                      nomorSlip: transferState.datarek.nomorSlip,
                      nomorTelp: transferState.datarek.nomorTelp,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              // onRefresh: _refreshPage(context),
              onRefresh: () async {
                // await _refreshPage(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
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
                            '  Transfer Dari',
                            style: greyTextStyle.copyWith(
                              fontWeight: black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100.sp,
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
                            _openModalRekening();
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
                                        '$_selectedOptionJenis ($hasil)',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.sp),
                                    child: SizedBox(
                                      width: 270.sp,
                                      child: Text(
                                        _selectedOptionNama,
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.sp),
                                    child: SizedBox(
                                      width: 270.sp,
                                      child: Text(
                                        'Rp $_selectedOptionNominal',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: blueBackgroundColor,
                                size: 25.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                            '  Transfer Ke',
                            style: greyTextStyle.copyWith(
                              fontWeight: black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 15.sp,
                      ),
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 10.sp,
                      // ),
                      child: TextField(
                        controller: nomorRekeningController,
                        // obscureText: passwordVisible,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Nomor Rekening BPR WM',
                          labelStyle: TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          suffixIcon: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(picFavorit)
                                IconButton(
                                  icon: const Icon(Icons.highlight_off),
                                  onPressed: () {
                                    setState(() {
                                      _selectedResult = {};
                                      dataFav = {};
                                      picFavorit = false;
                                    });
                                  },
                                  color: greyColor,
                                ),
                              IconButton(
                                icon: picFavorit ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                                onPressed: () {
                                  _openModalFavorit();
                                },
                                color: picFavorit ? redColor : blackColor,
                              ),
                            ],
                          ),
                          // alignLabelWithHint: false,
                          hintText: 'Ketik atau pilih nomor rekening',
                          hintStyle: TextStyle(fontSize: 14.sp),
                          filled: picFavorit ? true : false,
                        ),
                        readOnly: picFavorit ? true : false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 35.sp,
                      ),
                      child: TextFormField(
                        controller: _controllerNominal,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Nominal Transfer',
                          labelStyle:
                              TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: 'Masukkan Nominal',
                          hintStyle: TextStyle(fontSize: 14.sp),
                          errorText: _isValid ? null : 'Kurang dari Minimal Transfer / Saldo Tidak cukup',
                          errorStyle: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          setState(() {
                            _controllerNominal.text = FormatCurrency.formatRupiah(value);
                            _isValid = _validateInputNominal(_controllerNominal.text, _selectedOptionNominal);
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 35.sp,
                      ),
                      child: TextField(
                        controller: pesanController,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Pesan (optional)',
                          labelStyle:
                              TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: 'Masukkan Pesan',
                          hintStyle: TextStyle(fontSize: 14.sp),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    SizedBox(
                      height: 70.sp,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: Column(
                        children: [
                          CustomFilledButton2(
                            title: 'Lanjut',
                            onPressed: () {
                              if (validate()) {
                                if (_isValid) {
                                // Navigator.pushNamed(context, '/contoh');
                                  context.read<TransferBloc>().add(
                                    TransferSesamaCekPenerima(
                                      FormTransferSesamaModel(
                                        nomorRekening: _selectedOptionRek,
                                        nomorRekeningTujuan: nomorRekeningController.text,
                                        nominalPengirim: _selectedOptionNominal,
                                        nominalTransfer: _controllerNominal.text,
                                        jenisTabunganPengirim: _selectedOptionJenis,
                                        keterangan: pesanController.text,
                                      ),
                                    ),
                                  );
                                }else{
                                  showCustomSnackBar(context, 'Harap Cek Data Kembali');
                                }
                              } else {
                                showCustomSnackBar(context, 'Nomor Rekening dan Nominal Harus diisi !');
                              }
                            },
                            width: 400.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45.sp,
                    ),
                    // if (_selectedResult != null)
                    //   Padding(
                    //     padding: EdgeInsets.all(16.0),
                    //     child: Text("Selected Result: $_selectedResult"),
                    //   ),
                  ],
                ),
              ),
            );
          },
        ),
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
                color: blueBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'Pilih Rekening',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: globalListRekeningTransfer.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 80.sp,
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
                          globalListRekeningTransfer[index].nomorRekening,
                          globalListRekeningTransfer[index].nama,
                          globalListRekeningTransfer[index].saldo,
                          globalListRekeningTransfer[index].jenis,
                        );
                        _isValid = _validateInputNominal(_controllerNominal.text, _selectedOptionNominal);
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
                                    '${globalListRekeningTransfer[index].jenis} (${globalListRekeningTransfer[index].nomorRekening})',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.sp),
                                child: SizedBox(
                                  width: 270.sp,
                                  child: Text(
                                    'Rp ${globalListRekeningTransfer[index].saldo}',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: blueBackgroundColor,
                            size: 25.sp,
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

  _selectOption(String rekening, String nama, String saldo, String jenis) {
    setState(() {
      _selectedOptionRek = rekening;
      _selectedOptionNama = nama;
      _selectedOptionJenis = jenis;
      _selectedOptionNominal = saldo;
    });
  }
  bool _validateInputNominal(String penerima, String pengirim) {
    try {
      String nominal = StringReplace.replaceString(penerima, 'Rp ', '');
      String nominalPenerima = StringReplace.replaceString(nominal, '.', '');
      double myPenerima = double.parse(nominalPenerima);
      String nominalPengirim = StringReplace.replaceString(pengirim, '.', '');
      double myPengirim = double.parse(nominalPengirim.replaceAll(',', '.'));
      double minTrans = double.parse(minimalTransfer);
      if(myPenerima > minTrans){
        if(myPenerima > myPengirim){
          return false;
        }else{
          return true;
        }
      }else{
          return false;
      }
    } catch (e) {
      return false;
    }
  }
}
//=================================================================================================================
class FilterModalRekeningFavorit extends StatefulWidget {
  final List<Map<String, dynamic>> favoritData;
  FilterModalRekeningFavorit(this.favoritData);
  @override
  _FilterModalRekeningFavoritState createState() => _FilterModalRekeningFavoritState();
}

class _FilterModalRekeningFavoritState extends State<FilterModalRekeningFavorit> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredFavorit = [];
  @override
  void initState() {
    _filteredFavorit = widget.favoritData;
    super.initState();
  }
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.favoritData;
    } else {
      results = widget.favoritData
          .where((user) =>
              user["atasNama"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredFavorit = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(5),
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 50.sp,),
                Text(
                  'Pilih Rekening Favorit',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _searchController,
                            onChanged: (value) {
                              _runFilter(value);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              contentPadding: EdgeInsets.all(12),
                              hintText: 'Cari Favorit',
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    _filteredFavorit.isNotEmpty ?                          
                      SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _filteredFavorit.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100.sp,
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
                                    Navigator.pop(context, _filteredFavorit[index]);
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
                                                _filteredFavorit[index]["atasNama"],
                                                style: blackTextStyle.copyWith(
                                                  fontSize: 18.sp,
                                                  fontWeight: bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 16.sp),
                                            child: SizedBox(
                                              width: 270.sp,
                                              child: Text(
                                                '${_filteredFavorit[index]["namaBank"]} (${_filteredFavorit[index]["nomorRekening"]})',
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
                            // return ListTile(
                            //   title: Text(_filteredFavorit[index]["atasNama"]),
                            //   onTap: () {
                            //     Navigator.pop(context, _filteredFavorit[index]);
                            //   },
                            // );
                          },
                        ),
                      )
                    : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
