import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/auth/signin.dart';


//* ============== |>   toast    <| ============== */
void showToast(message, BuildContext? context) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showToastWithout(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showLongToast(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.white,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}

//* ============== |> onWillPop when logout <| ============== */
Future<bool> onWillPopLogout(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            title: const Center(
              child: Text("Logout!!!"),
            ),
            content: Text(
              "want_to_logout".tr,
              textAlign: TextAlign.center,
            ),
            actions: [
              Column(
                children: [
                  const Divider(
                    height: 1.0,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        const VerticalDivider(
                          width: 1.0,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.clear();
                            Get.offAll(() => const SigninScreen());
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      )) ??
      true;
}

//* ============== |> onWillPop when exit <| ============== */
Future<bool> onWillPopExit(BuildContext context, key) async {
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            elevation: 0,
            title: const Center(
              child: Text(
                "Exit !!",
              ),
            ),
            content: const Text(
              "Want to exit",
              textAlign: TextAlign.center,
            ),
            actions: [
              Column(
                children: [
                  const Divider(
                    height: 1.0,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"),
                        ),
                        const VerticalDivider(
                          width: 1.0,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        TextButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      )) ??
      false;
}

//------>
