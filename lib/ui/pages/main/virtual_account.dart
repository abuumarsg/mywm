import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/models/va_model.dart';
import 'package:logger/logger.dart';
import '../../../blocs/saldo/saldo_bloc.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../../shared/theme.dart';
import '../../widgets/virtual_account_card.dart';

class VirtualAccountPage extends StatefulWidget {
  final String nomorRekening;
  const VirtualAccountPage({super.key, required this.nomorRekening});
  @override
  State<VirtualAccountPage> createState() => _VirtualAccountPageState(nomorRekening);
}

class _VirtualAccountPageState extends State<VirtualAccountPage> {
  _VirtualAccountPageState(this.nomorRekening);
  String nomorRekening;
  var logger = Logger();
  @override
  void initState() {
    super.initState();
  }
  void handleOnRefreshPage(BuildContext context) {
      context.read<SaldoBloc>().add(getVirtualAccount(nomorRekening));
  }

  Future<void> _refreshPage(context) async {
    await Future.delayed(const Duration(seconds: 2));
    handleOnRefreshPage(context);
  }

  @override
  Widget build(BuildContext context) {
    refreshDateNowWm();
    return WillPopScope(
      onWillPop: () async {
        context.read<SaldoBloc>().add(LoadSaldo());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blueBackgroundColor,
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
          title: Text(
            'Virtual Account',
            style: whiteTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: blueBackgroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            await _refreshPage(context);
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
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 10.sp,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: blueBackgroundColor, width: 1),
                      ),
                      child: Wrap(
                        children: [
                          Container(
                            height: 50.sp,
                            width: 350.sp,
                            decoration : BoxDecoration(
                              color: blueBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              border: Border.all(color: blueBackgroundColor, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Nomor Rekening : ',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: regular,
                                    ),
                                  ),
                                  Text(
                                    nomorRekening,
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<SaldoBloc, SaldoState>(
                            builder: (context, saldoState) {
                              if (saldoState is GetVirtualAccountLoading) {
                                return cardLoadingAll(1);
                              }
                              if (saldoState is GetVirtualAccountFailed) {
                                Future.delayed(Duration.zero,(){
                                  showCustomSnackBar(context, saldoState.e);
                                });
                                return GestureDetector(
                                  onTap: () {
                                    context.read<SaldoBloc>().add(getVirtualAccount(nomorRekening));
                                  },
                                  child: SizedBox(
                                    height: 60.sp,
                                    child: Center(
                                      child: Icon(
                                        Icons.refresh,
                                        color: blackColor,
                                        size: 30.sp,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (saldoState is GetVirtualAccountSuccess) {
                                EasyLoading.dismiss();
                                List<VAModel> va = saldoState.dataResult;
                                return Wrap(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        backgroundColor: Colors.transparent,
                                        collapsedBackgroundColor: Colors.transparent,
                                        leading: Icon(
                                          Icons.add_card_rounded,
                                          color: blackColor,
                                          size: 30.sp,
                                        ),
                                        tilePadding: EdgeInsets.all(2.sp),
                                        title: Container(
                                          margin: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Text(
                                                'List Nomor Virtual Account',
                                                style: blackTextStyle.copyWith(
                                                  fontWeight: semiBold,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        children: <Widget>[
                                          (va.isNotEmpty) ?
                                            SingleChildScrollView(
                                              physics: const ScrollPhysics(),
                                              child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: va.length,
                                                itemBuilder: (context, index) => Container(
                                                  margin: const EdgeInsets.all(2),
                                                  child: VirtualAccountCard(va[index]),
                                                ),
                                              ),
                                            )
                                          : Text(
                                            'Belum Ada Nomor Virtual Account',
                                            style: blackTextStyle.copyWith(
                                              fontWeight: semiBold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          SizedBox(height: 10.sp,),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.sp,),
                                    Theme(
                                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        backgroundColor: Colors.transparent,
                                        collapsedBackgroundColor: Colors.transparent,
                                        leading: Icon(
                                          Icons.edit_square,
                                          color: blackColor,
                                          size: 30.sp,
                                        ),
                                        tilePadding: EdgeInsets.all(2.sp),
                                        title: Container(
                                          margin: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Tutorial',
                                                style: blackTextStyle.copyWith(
                                                  fontWeight: semiBold,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.all(3.sp),
                                            child: Image.asset(
                                              'asset/tutorial_setor_va.png',
                                              width: 340.sp,
                                            ),
                                          ),
                                          SizedBox(height: 60.sp,),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40.sp,),
                                  ],
                                );
                              } else {
                                return cardLoadingAll(1);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}