import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import '../drawer/drawer_items.dart';
import '../notifications/notification_screen.dart';

class ScaffoldWithDefaultTab extends StatelessWidget {
  const ScaffoldWithDefaultTab({
    Key? key,
    required this.title,
    required this.tabCount,
    required this.tabTitles,
    required this.tabs,
    this.appBarColor,
    this.tabBarBackgroudColor,
    this.withDrawer = true,
    this.tabScrolled = false,
    this.floatingActionButton,
    this.textColor,
    this.selectedColor,
    this.indicatorColor,
  }) : super(key: key);
  final int tabCount;
  final String title;
  final Color? appBarColor;
  final Color? textColor;
  final Color? selectedColor;
  final Color? indicatorColor;
  final Color? tabBarBackgroudColor;
  final List<String> tabTitles;
  final List<Widget> tabs;
  final Widget? floatingActionButton;
  final bool withDrawer;
  final bool tabScrolled;

  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      isScrollable: tabScrolled,
      indicatorWeight: 3,
      indicatorColor: indicatorColor ?? Colors.white,
      labelColor: selectedColor,
      unselectedLabelColor: textColor,
      labelStyle: TextStyles.customText(8.sp, FontWeight.w500),
      unselectedLabelStyle: TextStyles.customText(10.sp, FontWeight.w500),
      tabs: tabTitles.map((title) => Tab(
              text: title.toUpperCase()           
            )
          ).toList(),
          
    );
    final preferredSize = tabBar.preferredSize;
    final bottom = (tabBarBackgroudColor == null)
        ? tabBar
        : PreferredSize(
            preferredSize: preferredSize,
            child: ColoredBox(
              color: tabBarBackgroudColor!,
              child: tabBar,
            ),
          );

    return DefaultTabController(
      length: tabCount,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.green,
        ),
        child: Scaffold(
          //drawer: withDrawer ? const DrawerSide() : null,
          drawer: Platform.isAndroid ? const DrawerSide() : null,
          appBar: AppBar(
            backgroundColor: appBarColor,
            title: Text(title, style: TextStyles.smallTextStyle(),)
            ,
            automaticallyImplyLeading: !Platform.isIOS,
            leading: Platform.isIOS
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  )
                : null,
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  Get.to(() => const NotificationScreen());
                },
                icon: const Icon(Icons.message),
              ),
            ],
            bottom: bottom,
          ),
          floatingActionButton: floatingActionButton,
          body: TabBarView(
            children: tabs,
          ),
        ),
      ),
    );
  }
}
