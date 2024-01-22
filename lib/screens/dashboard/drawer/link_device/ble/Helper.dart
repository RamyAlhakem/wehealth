
import 'package:flutter/foundation.dart';

enum DebugColor {
  black,
  red,
  green,
  brightGreen,
  yellow,
  brightYellow,
  blue,
  brightBlue,
  magenta,
  cyan,
  white,
}

class Helper{
static void log(dynamic text, {DebugColor color = DebugColor.white}) {
    if (kDebugMode) {
      switch (color) {
        case DebugColor.black:
          print('\x1B[30m$text\x1B[0m');
          break;
        case DebugColor.green:
          print('\x1B[32m$text\x1B[0m');
          break;
        case DebugColor.yellow:
          print('\x1B[33m$text\x1B[0m');
          break;
        case DebugColor.blue:
          print('\x1B[34m$text\x1B[0m');
          break;
        case DebugColor.magenta:
          print('\x1B[35m$text\x1B[0m');
          break;
        case DebugColor.cyan:
          print('\x1B[36m$text\x1B[0m');
          break;
        case DebugColor.white:
          print('\x1B[37m$text\x1B[0m');
          break;
        case DebugColor.red: // bright red
          print('\x1B[91m$text\x1B[0m');
          break;
        case DebugColor.brightGreen:
          print('\x1B[92m$text\x1B[0m');
          break;
        case DebugColor.brightYellow:
          print('\x1B[93m$text\x1B[0m');
          break;
        case DebugColor.brightBlue:
          print('\x1B[94m$text\x1B[0m');
          break;
        default:
          print('\x1B[35m$text\x1B[0m');
      }
    }
  }
}