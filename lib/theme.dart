import 'dart:ui';

Map<String,Color> colors = {
  "accent" :_colorFromHex("#E95379"),
  "background1": _colorFromHex("#16161C"),
  "background2": _colorFromHex("#1A1C23"),
  "background3": _colorFromHex("#1C1E26"),
  "background4": _colorFromHex("#232530"),
  "background5": _colorFromHex("#2E303E"),
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