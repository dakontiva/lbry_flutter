import 'dart:ui';

Map colors = {
  "accent" :_colorFromHex("#E95379"),
  "background1": _colorFromHex("#1A1C23"),
  "background2": _colorFromHex("#232530"),
  "textColor": _colorFromHex("#FFFFFF")
  };

Color _colorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  } else {
    throw("Bad hex color length");
  }
}