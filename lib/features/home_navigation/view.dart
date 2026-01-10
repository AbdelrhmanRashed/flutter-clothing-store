import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:final_project/features/home/home_screen.dart';
import 'package:final_project/features/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => HomeNavState();
}

class HomeNavState extends State<HomeNav> {
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(query: "", isFromBottomNav: true),
    SizedBox(),
    SizedBox(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xffF8F7F7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: Color(0xffE9E9E9), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 100,
              spreadRadius: 0,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            elevation: 0,

            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffF8F7F7),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: AppColors.secondColor,
            selectedItemColor: AppColors.mainColor,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),

            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: SvgPicture.asset(
                  AppIcons.home,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 0
                        ? AppColors.mainColor
                        : AppColors.hintColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Search",
                icon: SvgPicture.asset(
                  AppIcons.search,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 1
                        ? AppColors.mainColor
                        : AppColors.hintColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Cart",

                icon: SvgPicture.asset(
                  AppIcons.cart,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 2
                        ? AppColors.mainColor
                        : AppColors.hintColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "User",
                icon: SvgPicture.asset(
                  AppIcons.user,
                  colorFilter: ColorFilter.mode(
                    currentIndex == 3
                        ? AppColors.mainColor
                        : AppColors.hintColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: screens.elementAt(currentIndex),
    );
  }
}
