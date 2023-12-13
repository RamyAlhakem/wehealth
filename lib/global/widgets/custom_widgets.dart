import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.appBarBG),
          fit: BoxFit.cover,
        ),
      ),
      height: 90.h,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Row(
            children: [
              SizedBox(height: 10.h),
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "back",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// no back button appbar

class NoBackPressAppbar extends StatelessWidget {
  const NoBackPressAppbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.appBarBG),
          fit: BoxFit.cover,
        ),
      ),
      height: 90.h,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: IconButton(
          onPressed: () async {
            // _onWillPop(context);
            // await onWillPopWarning(context);
            Navigator.of(context).pop();
          },
          icon: Row(
            children: [
              SizedBox(height: 10.h),
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "back",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
AppBar dashboardAppBar(BuildContext context, String appTitle) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        Flexible(
          child: Text(
            appTitle,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    ),
    flexibleSpace: const Image(
      image: AssetImage(Images.appBarBG),
      fit: BoxFit.cover,
    ),
    backgroundColor: Colors.transparent,
    bottomOpacity: 0.0,
    elevation: 0.0,
  );
}

///* ========= |> <| =======  */
AppBar newAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    flexibleSpace: Image.asset(Images.appBarBG, fit: BoxFit.cover),
    leadingWidth: 20.w,
    leading: IconButton(
      onPressed: () {
        print("new appbar");
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    ),
    title: Text(
      'back',
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    ),
  );
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
