import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kejaksaan/screen_page/admin/homeindex.dart';
import 'package:kejaksaan/screen_page/admin/page_profile.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            HomeIndexAdmin(),PageProfileAdmin()
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          waterDropColor: Colors.white,
          backgroundColor: Colors.green,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.newspaper_rounded,
              outlinedIcon: Icons.newspaper_outlined,
            ),
            BarItem(
              filledIcon: Icons.perm_identity_rounded,
              outlinedIcon: Icons.perm_identity_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
