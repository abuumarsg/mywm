import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/blocs/rekening/rekening_bloc.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import 'package:logger/logger.dart';
import '../../../blocs/saldo/saldo_bloc.dart';
import '../../../models/rekening_favorit_model.dart';
import '../../../shared/global_data.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../widgets/card_rekening_favorit.dart';
import 'transfer_bank_lain.dart';
import 'transfer_sesama_wm.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var logger = Logger();
  RekFavModel? selectedRekeningFavorit;
  List<Map<String, dynamic>> _allFavorit = [];
  List<Map<String, dynamic>> _foundFavorit = [];

  final bool isSelected = false;
  @override
  initState() {
    super.initState();
    refreshDateNowWm();
    blocSaldo.add(LoadRekeningFavorit());
    blocRekening.add(const getRekeningTransfer());
    blocRekening.stream.listen((stateB) {
      if (stateB is RekeningForTransferLoading) {
        showLoadingIndicator();
      }
      if (stateB is RekeningForTransferFailed) {
        Future.delayed(Duration.zero,(){
          showCustomSnackBar(context, 'Gagal Memuat Rekaning Transfer, ${stateB.e}');
        });
      }
      if (stateB is DataRekeningForTransfer) {
        hideLoadingIndicator();
      }
    });
    blocSaldo.stream.listen((stateS) {
      if (stateS is LoadRekFavFailed) {
        Future.delayed(Duration.zero,(){
          showCustomSnackBar(context, 'Gagal Memuat Rekening Favorit, ${stateS.e}');
        });
      }
      if (stateS is RekFavoritloading) {
        showLoadingIndicator();
      }
      if (stateS is RekFavoritloaded) {
        EasyLoading.dismiss();
        setState(() {
          _allFavorit = List<Map<String, dynamic>>.from(
            json.decode(jsonEncode(globalListFavorit))
                .map((x) => Map<String, dynamic>.from(x))
          );
          _foundFavorit = _allFavorit;
        });
      }
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allFavorit;
    } else {
      results = _allFavorit
          .where((user) => user["atasNama"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundFavorit = results;
      selectedRekeningFavorit = null;
    });
  }
  final blocSaldo = SaldoBloc();
  final blocRekening = RekeningBloc();

  bool showListtoDelete = false;
  bool showCheckboxListTile = false;

  final Set<String> selectedItems = {};
  bool selectAllDel = false;
  @override
  Widget build(BuildContext context) {
    final RekFavModel? rekening = selectedRekeningFavorit;
    List result = _foundFavorit;
    List<RekFavModel> foundFavoritMap =
        result.map((e) => RekFavModel.fromJson(e)).toList();
    // logger.i(showListtoDelete);
    // logger.i(foundFavoritMap[0].atasNama);
    //  List<String> selectedItems = [];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Favorit Saya',
          style: whiteTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: blueBackgroundColor,
        // toolbarHeight: 45.sp,
        centerTitle: true,
        actions: <Widget>[
          if (showListtoDelete)
            GestureDetector(
              onTap: () {
                setState(() {
                  showListtoDelete = false;
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.highlight_off,
                    size: 24.sp,
                  ),
                  Text(
                    ' Batal  ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          if (showListtoDelete == false)
            GestureDetector(
              onTap: () {
                // print('hapus');
                setState(() {
                  showListtoDelete = true;
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 24.sp,
                  ),
                  Text(
                    '  ',
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
      backgroundColor: blueBackgroundColor,
      body: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => _runFilter(value),
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
              SizedBox(
                height: 20.sp,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Semua',
                      style: redTextStyle.copyWith(
                        fontWeight: black,
                        fontSize: 16.sp,
                      ),
                    ),
                    if (showListtoDelete)
                    Checkbox(
                      value: selectAllDel,
                      onChanged: (value) {
                        setState(() {
                          selectAllDel = value!;
                            selectedItems.clear();
                            if (selectAllDel) {
                              for (var item in foundFavoritMap) {
                                selectedItems.add(item.id.toString());
                                print(item.id.toString());
                              }
                            }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              if (showListtoDelete == false)
              Expanded(
                child: _foundFavorit.isNotEmpty
                    ? ListView(
                        children: foundFavoritMap.map((rek) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRekeningFavorit = rek;
                              });
                            },
                            child: CardRekeningFavorit(
                              rekening: rek,
                              isSelected: rek.id == selectedRekeningFavorit?.id,
                            ),
                          );
                        }).toList(),
                      )
                    : Text(
                        'No results found',
                        style: TextStyle(fontSize: 16.sp),
                      ),
              ),
              //======================================================= UNTUK HAPUS =============================================================
              if (showListtoDelete)
              Expanded(
                child: ListView.builder(
                  itemCount: foundFavoritMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = foundFavoritMap[index].id.toString();
                    final isSelectedDel = selectedItems.contains(item);
                    return Container(
                      margin: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 10.sp,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 17.sp,
                        vertical: 12.sp,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? blueColor : whiteColor, 
                          width: 2
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.sp),
                                    child: SizedBox(
                                      width: 200.sp,
                                      child: Text(
                                        foundFavoritMap[index].atasNama.toString(),
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: medium,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.sp),
                                    child: SizedBox(
                                      // width: 179.sp,
                                      width: 200.sp,
                                      child: Text(
                                        '${foundFavoritMap[index].namaBank.toString()} - ${foundFavoritMap[index].nomorRekening.toString()}',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 10.sp,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Checkbox(
                                value: isSelectedDel,
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      selectedItems.add(item);
                                    } else {
                                      selectedItems.remove(item);
                                    }
                                    selectAllDel = selectedItems.length == foundFavoritMap.length;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if(selectedItems.isNotEmpty && showListtoDelete)
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 150.sp,
                        height: 40.sp,
                        child: TextButton(
                          onPressed: () {
                            // deleteRekeningFavorit(selectedItems);
                            confirmdeleteRekeningFavorit(context, selectedItems);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Hapus',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              //======================================================= ========== =============================================================
              if (selectedRekeningFavorit != null && showListtoDelete == false)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  child: Column(
                    children: [
                      CustomFilledButton2(
                        title: 'Transaksi',
                        onPressed: () {
                          Future.delayed(Duration.zero,(){
                            if (rekening?.kodeBank.toString() == '000') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransferSesamaWM(dataFav: {
                                    "nomorRekeningBPRWM": rekening?.nomorRekening
                                  }),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransferBankLain(dataFav: {
                                    "nomorRekening": rekening?.nomorRekening,
                                    "kodeBank": rekening?.kodeBank,
                                    "namaBank": rekening?.namaBank
                                  }),
                                ),
                              );
                            }
                          });
                        },
                        width: 400.sp,
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  
  void confirmdeleteRekeningFavorit(BuildContext context, data) {
    Set<String> dataSet = data;
    int count = dataSet.length;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi',
            style: TextStyle(
              color: blackColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Anda Yakin menghapus $count data rekening Favorit ??',
            style: TextStyle(
              color: blackColor,
              fontSize: 12.0,
              fontWeight: regular,
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 2), // Warna dan lebar border
              ),
              child: Text(
                'Batal',
                style: TextStyle(
                  color: blueColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                deleteRekeningFavorit(data);
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 2), // Warna dan lebar border
              ),
              child: Text(
                'Hapus',
                style: TextStyle(
                  color: redColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  deleteRekeningFavorit(data) {
    Set<String> dataSet = data;
    List<String> dataList = dataSet.toList();
    String jsonString = jsonEncode(dataList);
    Map<String, dynamic> dataX = {"id_favorit":jsonString};
    blocRekening.add(DeleteRekeningFavorit(dataX));
    blocRekening.stream.listen((stateS) {
      if(stateS is DeleteRekeningFavoritLoading){
        showLoadingIndicator();
      }
      if (stateS is DeleteRekeningFavoritSuccess) {
        EasyLoading.dismiss();
        showCustomSnackBarSuccess(context, 'Rekening Favorit Berhasil di hapus');
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,);
        });
      }
      if (stateS is DeleteRekeningFavoritFailed) {
        EasyLoading.dismiss();
        showCustomSnackBar(context, stateS.e);
      }
    });
  }
}
