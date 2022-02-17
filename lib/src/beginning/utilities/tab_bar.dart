import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

List<Tab> tabsData(double width, double? height) {
  double letterspace = width / 250;
  double tabBarFontSize = orientedCar ? width / 18 : height! / 35.5;

  return [
    Tab(
      child: Text(
        "GEZİNTİLER",
        style: TextStyle(
          fontSize: tabBarFontSize,
          letterSpacing: letterspace,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        "ŞARKILAR",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        "ALBÜMLER",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        "SANATÇILAR",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        "TÜRLER",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        "ÇALMA LİSTELERİ",
        style: TextStyle(
          letterSpacing: letterspace,
          fontSize: tabBarFontSize,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ];
}
