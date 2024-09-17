import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/models/saldo_model.dart';
import 'package:myWM/shared/share_methods.dart';
import 'package:myWM/shared/theme.dart';
import 'package:myWM/ui/widgets/saldo_card.dart';
import '../../../blocs/saldo/saldo_bloc.dart';
import '../../../shared/share_values.dart';

class RekeningPage extends StatefulWidget {
  const RekeningPage({
    super.key,
  });

  @override
  State<RekeningPage> createState() => _RekeningPageState();
}

class _RekeningPageState extends State<RekeningPage> {
  void handleOnRefreshPage(BuildContext context) {
    // context.read<SaldoBloc>().add(LoadSaldo());
    context.read<SaldoBloc>().add(RefreshSaldo());
  }

  Future<void> _refreshPage(context) async {
    await Future.delayed(const Duration(seconds: 2));
    handleOnRefreshPage(context);
  }
  
  @override
  void initState() {
    super.initState();
    refreshDateNowWm();tujuanPenggunaanKredit();
    context.read<SaldoBloc>().add(LoadSaldo());
  }

  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueBackgroundColor,
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        title: Text(
          'Tabungan Saya',
          style: whiteTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: blueBackgroundColor,
      body: RefreshIndicator(
        // onRefresh: _refreshPage(context),
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
                  BlocBuilder<SaldoBloc, SaldoState>(
                    builder: (context, saldoState) {
                      if (saldoState is LoadSaldoFailed) {
                        EasyLoading.dismiss();
                        Future.delayed(Duration.zero,(){
                          showCustomSnackBar(context, '${saldoState.e}, Please Reload Application');
                        });
                      }
                      // logger.i(saldoState);
                      if (saldoState is SaldoTabunganloaded) {
                        List<SaldoModel> saldo = saldoState.saldo;
                        return SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: saldo.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.all(2),
                              child: saldoCard(saldo[index]),
                            ),
                          ),
                        );
                      }else{
                        return cardLoadingAll(3);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}