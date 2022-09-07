import 'package:flutter/material.dart';

var bkgColLt = Colors.grey.shade100;
var bkgColDk = Colors.grey.shade900;
var primColLt = Colors.tealAccent;
var primColDk = Colors.lightBlue[800];

const h1fntSz = 52.0;
const h1fntWt = FontWeight.bold;
const h6fntSz = 36.0;
const h6FntStl = FontStyle.normal;
const b1FntSz = 24.0;
const b1FntFam = 'Hind';
const b2FntSz = 14.0;
const b2FntFam = 'Hind';
const b1ColLt = Colors.black;
const b1ColDk = Colors.white;
const b2ColLt = Colors.black;
const b2ColDk = Colors.white;

const appBarTtlFntSz = 24.0;
const appBarTtlFntWt = FontWeight.w600;
const appBarColLt = Colors.black;
var appBarColDk = Colors.grey[900];
const appBarTtlColLt = Colors.white;
const appBarTtlColDk = Colors.white;
const appBarTtlIconColLt = Colors.white;
const appBarTtlIconColDk = Colors.white;

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    backgroundColor: bkgColDk,
    brightness: Brightness.dark,
    primaryColor: primColDk,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: h1fntSz,
        fontWeight: h1fntWt,
      ),
      headline6: TextStyle(
        fontSize: h6fntSz,
        fontStyle: h6FntStl,
      ),
      bodyText1: TextStyle(
        fontSize: b1FntSz,
        fontFamily: b1FntFam,
        color: b1ColDk,
      ),
      bodyText2: TextStyle(
        fontSize: b2FntSz,
        fontFamily: b2FntFam,
        color: b2ColDk,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: appBarColDk,
      titleTextStyle: const TextStyle(
        fontSize: appBarTtlFntSz,
        color: appBarTtlColDk,
        fontWeight: appBarTtlFntWt,
      ),
      iconTheme: const IconThemeData(color: appBarTtlIconColDk),
    ),
  );
}

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    backgroundColor: bkgColLt,
    brightness: Brightness.light,
    primaryColor: primColLt,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: h1fntSz,
        fontWeight: h1fntWt,
      ),
      headline6: TextStyle(
        fontSize: h6fntSz,
        fontStyle: h6FntStl,
      ),
      bodyText1: TextStyle(
        fontSize: b1FntSz,
        fontFamily: b1FntFam,
        color: b1ColLt,
      ),
      bodyText2: TextStyle(
        fontSize: b2FntSz,
        fontFamily: b2FntFam,
        color: b2ColLt,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: appBarColLt,
      titleTextStyle: TextStyle(
        fontSize: appBarTtlFntSz,
        color: appBarTtlColLt,
        fontWeight: appBarTtlFntWt,
      ),
      iconTheme: IconThemeData(color: appBarTtlIconColLt),
    ),
  );
}
