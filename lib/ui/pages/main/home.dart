import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../blocs/saldo/saldo_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
// import 'package:myWM/ui/pages/main/perintah_transfer.dart';
import 'package:myWM/ui/widgets/fab_bottom_app_bar.dart';
import 'package:myWM/ui/pages/main/beranda.dart';
import 'package:myWM/ui/pages/main/favorite.dart';
// import 'package:myWM/ui/pages/main/setting.dart';

import '../../../blocs/saldo/saldo_bloc.dart';
import 'informasi_akun.dart';
import 'riwayat_transaksi.dart';
// import '../../../shared/share_methods.dart';
// import '../../widgets/storage_manager.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final blocSaldo = SaldoBloc();
  void _onItemTapped(int index) {
    setState(() {
      // holdSession();
      _selectedIndex = index;
      if(index == 2){
        // context.read<SaldoBloc>().add(LoadRekeningFavorit());
      }
    });
  }
  final List<Widget> _pages = [
    const BerandaPage(),
    RiwayatTransaksiPage(),
    // PerintahTransferPage(),
    const FavoritePage(),
    // const SettingPage(),
    const InformasiAkunPage(),
  ];

  Future<void> _refreshPage(int selectedIndex) async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() { 
      if(selectedIndex == 0){
          // context.read<UserBloc>().add(LoadUser());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 29, 121, 220),
    ));
    return Scaffold(
      floatingActionButton: Container(
        width: 60.sp,
        height: 60.sp,
        child: RawMaterialButton(
          shape: const CircleBorder(),
          elevation: 0.0,
          child: Container(
              width: 60.sp,
              height: 60.sp,
              decoration: BoxDecoration(
                border: Border.all(
                  color: blueBackgroundColor,
                  width: 3,
                ),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage(
                    'asset/klik_kira.png',
                  ),
                ),
              ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/kira');
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: true, 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: lightBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await _refreshPage(_selectedIndex);
        },
        child: GestureDetector(
          onTap: () async  {
            // holdSession();
          },
          child: Center(
            child: _pages[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'KIRA',
        color: greyColor,
        currentIndex: '',//Provider.of<TabProvider>(context).currentIndex,
        selectedColor: whiteColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: _onItemTapped,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.history, text: 'Riwayat'),
          FABBottomAppBarItem(iconData: Icons.favorite, text: 'Favorit'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Akun Saya'),
        ],
        backgroundColor: blueBackgroundColor,
      ),
    );
  }
  
  @override
  void dispose() {
    // autoDeleteStorage.dispose();
    super.dispose();
  }
}
