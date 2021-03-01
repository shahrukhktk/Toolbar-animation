import 'package:flutter/material.dart';
import 'package:tabbar_project/Screens/mainscreen.dart';

void main() => runApp(new MaterialApp(
  theme: ThemeData(
    // primaryColor: AppColors.grey_color,
    // accentColor: AppColors.red_color,
    fontFamily: "OpenSans",
  ),
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));