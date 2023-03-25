import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/screens/main/home/home.dart';
import 'package:grocery_app/screens/main/order/order_screen.dart';
import 'package:grocery_app/utils/assets_constants.dart';

import '../utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // Logger().w(widget.uid);
    _screens.addAll({
      const HomeScreen(),
      const OrderScreen(),
    });
    super.initState();
  }

  //List to store bottom navigation screens
  final List<Widget> _screens = [];

  int index = 0;

  //onTap function
  void onItemTap(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      bottomNavigationBar: SizedBox(
        height: 83.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: SvgPicture.asset(
                AssetsConstants.homeIcon,
                color: index == 0 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () {
                onItemTap(0);
              },
            ),
            InkWell(
              child: SvgPicture.asset(
                AssetsConstants.menuIcon,
                color: index == 1 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () {
                onItemTap(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
