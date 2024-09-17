import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:myWM/blocs/rekening/rekening_bloc.dart';
import 'package:myWM/blocs/user/user_bloc.dart';
import 'package:myWM/shared/theme.dart';
import 'package:logger/logger.dart';
import 'package:myWM/ui/widgets/buttons.dart';
import '../../../blocs/dua/dua_bloc.dart';
import '../../../blocs/satu/satu_bloc.dart';
import '../../../blocs/transfer/transfer_bloc.dart';
import '../../../notifikasi/notifikasi_service.dart';
import '../../../service_locator.dart';
import '../../../shared/global_data.dart';
import '../../../shared/share_methods.dart';
import '../../../shared/share_values.dart';
import '../../data_provider.dart';
import 'package:badges/badges.dart' as badges;

class BerandaPage extends StatefulWidget {
  const BerandaPage({
    super.key,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

final dataProvider = getIt.get<DataProvider>();
var logger = Logger();

class _BerandaPageState extends State<BerandaPage> {
  int currentIndexBenner = 0;
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 11) {
      return 'Selamat Pagi,';
    }
    if (hour < 15) {
      return 'Selamat Siang,';
    }
    if (hour < 18) {
      return 'Selamat Sore,';
    }
    return 'Selamat Malam,';
  }

  final dataversiapk = dataProvider.dataVERSI;

  @override
  void initState() {
    super.initState();
    refreshDateNowWm();
    _loadNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dataversiapk?.responseReturn == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Yeah !'),
              content: Text(
                  'Aplikasi Terbaru versi ${dataversiapk?.versi.toString()} telah tersedia'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/need_username', (route) => false);
                  },
                  child: Text('Tutup'),
                ),
              ],
            );
          },
        );
      }
      if (dataversiapk?.maintenanceAPK == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Pemberitahuan',
                style: blackTextStyle.copyWith(
                  fontSize: 15.sp,
                  fontWeight: bold,
                ),
              ),
              content: Text(
                dataversiapk!.ketMaintenance.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.justify,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/need_username', (route) => false);
                  },
                  child: Text(
                    'Tutup',
                    style: blackTextStyle.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
    // context.read<SaldoBloc>().add(ResetSaldoState());
  }
  String rekeningDefault = '';
  bool showSaldo = false;
  int _unreadCount = 0;
  final NotificationService _notificationService = NotificationService();
  Future<void> _loadNotifications() async {
    await _notificationService.cleanExpiredNotifications();
    final notificationsUnread = await _notificationService.getNotifications(unreadOnly: true);
    setState(() {
      _unreadCount = notificationsUnread.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueBackgroundColor,
        title: Row(
          children: [
            SizedBox(width: 10.sp),
            Flexible(
              child: Image.asset(
                'asset/logo/logo_my_wm.png',
                width: 70.sp,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/setting');
                },
                child: Icon(
                  Icons.settings,
                  color: whiteColor,
                  size: 25.sp,
                ),
              ),
              SizedBox(width: 10.sp),
              GestureDetector(
                onTap: () {
                  _showConfirmLogoutDialog();;
                },
                child: Icon(
                  Icons.logout,
                  color: whiteColor,
                  size: 25.sp,
                ),
              ),
              SizedBox(width: 10.sp),
            ],
          ),
        ],
      ),
      backgroundColor: blueBackgroundColor,
      body: ListView(
        children: [
          SizedBox(
            height: 10.sp,
          ),
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.fromLTRB(10.sp, 5.sp, 10.sp, 30.sp),
            child: Column(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserloadedFailed) {
                      showCustomSnackBar(context, userState.e);
                      return GestureDetector(
                        onTap: () {
                          context.read<UserBloc>().add(LoadUser());
                        },
                        child: Icon(
                          Icons.refresh,
                          color: blackColor,
                          size: 30.sp,
                        ),
                      );
                    }
                    if (userState is UserInitial) {
                      context.read<UserBloc>().add(LoadUser());
                    }
                    if (userState is Userloaded) {
                      return Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: blueBackgroundColor, width: 1),
                            ),
                            child: Stack(
                              children: <Widget>[
                                SpinKitFadingCircle(
                                  color: blackColor,
                                  size: 50.sp,
                                ),
                                Container(
                                  width: 50.sp,
                                  height: 50.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      // image: AssetImage("asset/user_pic.png"),
                                      image:
                                          userState.user.profilePicture == null
                                              ? const AssetImage(
                                                  'asset/user_pic.png',
                                                )
                                              : NetworkImage(userState
                                                      .user.profilePicture!)
                                                  as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                greeting(),
                                style: blackTextStyle.copyWith(fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    2 * 24.sp -
                                    89.sp,
                                child: Text(
                                  userState.user.name.toString(),
                                  style:
                                      blackTextStyle.copyWith(fontSize: 16.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _loadNotifications();
                              Navigator.pushNamed(context, '/notifikasi_list');
                              // Navigator.of(context).pushNamed(NotificationListPage.route);
                            },
                            child: 
                            (_unreadCount > 0) ?
                              badges.Badge(
                                badgeContent: Text(
                                  '$_unreadCount',
                                  style: whiteTextStyle.copyWith(fontSize: 12.sp),
                                ),
                                badgeStyle: badges.BadgeStyle(badgeColor: redColor),
                                child: const Icon(Icons.notifications_none),
                              ) : Icon(
                                Icons.notifications_none,
                                color: blackColor,
                                size: 25.sp,
                              ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 60.sp,
                        child: buildLoadingIndicator( colors: [blackColor, blackColor, blackColor]),
                      );
                    }
                  },
                ),
                SizedBox(height: 10.sp),
                Container(
                  decoration: BoxDecoration(
                    color: blueBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(12.sp, 8.sp, 12.sp, 10.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rekening Utama : ',
                            style: whiteTextStyle.copyWith(
                              fontSize: 12.sp,
                              fontWeight: regular,
                            ),
                          ),
                          BlocBuilder<DuaBloc, DuaState>(
                            builder: (context, duaState) {
                            if (duaState is DuaInitial) {
                              context.read<DuaBloc>().add(LoadRekeningUtama());
                            }
                            if (duaState is LoadRekeningUtamaFailed) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<DuaBloc>().add(LoadRekeningUtama());
                                },
                                child: Icon(
                                  Icons.refresh,
                                  color: whiteColor,
                                  size: 20.sp,
                                ),
                              );
                            }
                            if (duaState is LoadRekeningUtamaSuccess) {
                              rekeningDefault = duaState.rekening[0].toString();
                              return Text(
                                duaState.rekening[0].toString(),
                                style: whiteTextStyle.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: regular,
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: 20.sp,
                                height: 30.sp,
                                child: buildLoadingIndicator(),
                              );
                            }
                          }),
                        ],
                      ),
                      BlocBuilder<SatuBloc, SatuState>(
                        builder: (context, satuState) {
                          if (satuState is SatuInitial) {
                            context.read<SatuBloc>().add(LoadSaldoMyWm());
                          }
                          if (satuState is GetSaldoUtamaFailed) {
                            return GestureDetector(
                              onTap: () {
                                context.read<SatuBloc>().add(LoadSaldoMyWm());
                              },
                              child: Icon(
                                Icons.refresh,
                                color: whiteColor,
                                size: 25.sp,
                              ),
                            );
                          }
                          if (satuState is GetSaldoUtamaSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  showSaldo
                                      ? 'IDR ${satuState.dataResult[0].saldoAkhir}'
                                      : 'IDR *******',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 21.sp,
                                    fontWeight: bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        showSaldo = !showSaldo;
                                      },
                                    );
                                  },
                                  child: Icon(
                                    showSaldo
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: whiteColor,
                                    size: 21.sp,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: 50.sp,
                              child: buildLoadingIndicator(
                                  colors: [whiteColor, whiteColor, whiteColor]),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 10.sp),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/rekening');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          padding: EdgeInsets.fromLTRB(12.sp, 8.sp, 12.sp, 8.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Semua Rekening',
                                style: blackTextStyle.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: bold,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: blackColor,
                                size: 15.sp,
                                weight: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.sp),
                CarouselSlider(
                  items: imagesBanner.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.symmetric(horizontal: 2.sp),
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                image,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 235.sp,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    // aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndexBenner = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10.sp),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(12.sp, 8.sp, 12.sp, 8.sp),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardMenuUtama(
                            title: 'Transfer',
                            icon:'asset/menu_icon_transfer.png',
                            onPressed: () {
                              Navigator.pushNamed(context, '/perintah_transfer');
                            },
                          ),
                          cardMenuUtama(
                            title: 'Tabungan',
                            icon:'asset/menu_icon_rekeningku.png',
                            onPressed: () {
                              Navigator.pushNamed(context, '/rekening');
                            },
                          ),
                          cardMenuUtama(
                            title: 'Deposito',
                            icon:'asset/menu_icon_deposito.png',
                            onPressed: () {
                              print('Deposito');
                            },
                          ),
                          cardMenuUtama(
                            title: 'Kredit',
                            icon:'asset/menu_icon_kredit.png',
                            onPressed: () {
                              print('Kredit');
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardMenuUtama(
                            title: 'Riwayat',
                            icon:'asset/menu_icon_riwayat.png',
                            onPressed: () {
                              Navigator.pushNamed(context, '/riwayat_transaksi');
                            },
                          ),
                          cardMenuUtama(
                            title: 'e Statement',
                            icon:'asset/menu_icon_estatement.png',
                            onPressed: () {
                              print('e Statement');
                            },
                          ),
                          cardMenuUtama(
                            title: 'Nomor VA',
                            icon:'asset/menu_icon_VA.png',
                            onPressed: () {
                              print('Nomor VA');
                            },
                          ),
                          cardMenuUtama(
                            title: 'Promo',
                            icon:'asset/menu_icon_promo.png',
                            onPressed: () {
                              print('Promo');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.sp),
                BlocBuilder<TransferBloc, TransferState>(
                  builder: (context, transferState) {
                    // logger.i(transferState);
                    if (transferState is TransferInitial) {
                      if(rekeningDefault.isNotEmpty){
                        context.read<TransferBloc>().add(GetDataTransaksiTerakhir(rekeningDefault));
                      }
                    }
                    if (transferState is TransaksiTerakhirFailed) {
                      return GestureDetector(
                        onTap: () {
                          context.read<TransferBloc>().add(GetDataTransaksiTerakhir(rekeningDefault));
                        },
                        child: Icon(
                          Icons.refresh,
                          color: blueBackgroundColor,
                          size: 40.sp,
                        ),
                      );
                    }
                    if (transferState is TransaksiTerakhirSuccess) {
                      return Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(width: 1, color: greyColor),
                        ),
                        padding: EdgeInsets.fromLTRB(5.sp, 8.sp, 5.sp, 8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Transaksi Terakhir',
                                  style: darkBlueTextStyle.copyWith(
                                      fontSize: 14.sp, fontWeight: bold),
                                ),
                                const Divider(),
                                Text(
                                  transferState.dataResult['namaBankTujuan'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: SizedBox(
                                    width: 180.sp,
                                    child: Text(
                                      '${transferState.dataResult['rekeningTujuan'].toString()} AN ${transferState.dataResult['atasNamaTujuan'].toString()}',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Berhasil',
                                  style: greenTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  transferState.dataResult['tanggal'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  transferState.dataResult['nominal'].toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }else{
                      return const CardLoading(
                        height: 100,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        margin: EdgeInsets.only(bottom: 10),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showConfirmLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin untuk Logout ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                showLoadingIndicator();
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                  hideLoadingIndicator();
                  Navigator.pushNamedAndRemoveUntil(context, '/need_username', (route) => false);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Widget saldoRekening(context) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.pushNamed(context, '/rekening');
//     },
//     child: Container(
//       height: 80.sp,
//       margin: const EdgeInsets.only(
//         left: 10,
//         right: 10,
//         top: 10,
//       ),
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: whiteColor,
//         image: const DecorationImage(
//           image: AssetImage("asset/btn_saldo_tabungan.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//   );
// }

// Widget mutasiTabungan(context) {
//   final blocRekening = RekeningBloc();
//   return GestureDetector(
//     onTap: () {
//       refreshDateNowWm();
//       // Navigator.pushNamed(context, '/mutasi_tabungan');
//       blocRekening.add(LoadRekening());
//       blocRekening.stream.listen((stateR) {
//         if (stateR is LoadRekeningFailed) {
//           Future.delayed(Duration.zero, () {
//             showCustomSnackBar(context, 'Gagal Memuat Rekening, ${stateR.e}');
//           });
//         }
//         if (stateR is RekeningLoading) {
//           EasyLoading.show(
//             status: 'loading...',
//             maskType: EasyLoadingMaskType.clear,
//           );
//         }
//         if (stateR is Rekeningloaded) {
//           EasyLoading.dismiss();
//           Future.delayed(Duration.zero, () {
//             Navigator.pushNamed(context, '/mutasi_tabungan');
//           });
//         }
//       });
//     },
//     child: Container(
//       height: 80.sp,
//       margin: const EdgeInsets.only(
//         left: 10,
//         right: 10,
//         top: 10,
//       ),
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: whiteColor,
//         image: const DecorationImage(
//           image: AssetImage("asset/btn_mutasi_tabungan.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//   );
// }

// Widget perintahTransfer(context) {
//   return GestureDetector(
//     onTap: () {
//       refreshDateNowWm();
//       // resetTimer();
//       Navigator.pushNamed(context, '/perintah_transfer');
//     },
//     child: Container(
//       height: 80.sp,
//       margin: const EdgeInsets.only(
//         left: 10,
//         right: 10,
//         top: 10,
//       ),
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: whiteColor,
//         image: const DecorationImage(
//           image: AssetImage("asset/btn_transfer.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//   );
// }
