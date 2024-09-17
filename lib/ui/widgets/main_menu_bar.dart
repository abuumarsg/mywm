import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myWM/shared/theme.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class MainMenuBar extends StatefulWidget {
  const MainMenuBar(  {super.key});

  @override
  State<MainMenuBar> createState() => _MainMenuBarState();
}

class _MainMenuBarState extends State<MainMenuBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

        // if (index == 0) Navigator.pushNamed(context, '/home');
        // if (index == 1) const RekeningPage();
        // if (index == 2) Navigator.pushNamed(context, '/chat_kira');
        // if (index == 3) Navigator.pushNamed(context, '/favorite');
        // if (index == 4) Navigator.pushNamed(context, '/setting');
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: whiteColor,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      notchMargin: 5,
      // elevation: 0,
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: whiteColor,
        selectedItemColor: blueColor,
        unselectedItemColor: blackColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: blueTextStyle.copyWith(
          fontSize: 10.sp,
          fontWeight: medium,
        ),
        unselectedLabelStyle: blackTextStyle.copyWith(
          fontSize: 10.sp,
          fontWeight: medium,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,              
              // color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Rekening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'KIRA Chat AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        onTap: _onItemTapped,
        // onTap: (value) {
        //   if (value == 0) Navigator.pushNamed(context, '/home');
        //   if (value == 1) Navigator.pushNamed(context, '/rekening');
        //   if (value == 2) Navigator.pushNamed(context, '/chat_kira');
        //   if (value == 3) Navigator.pushNamed(context, '/favorite');
        //   if (value == 4) Navigator.pushNamed(context, '/setting');
        // },
      ),
    );
  }
}

// ignore: camel_case_types
class menuBarTengah extends StatelessWidget {
  const menuBarTengah({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/chat_kira');
      },
      backgroundColor: purpleColor,
      child: Image.asset(
        'asset/klik_kira.png',
        width: 65.sp,
      ),
    );
  }
}