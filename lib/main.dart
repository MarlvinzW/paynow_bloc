import 'package:flutter/material.dart';
import 'package:paynowbloc/ui/launcher.dart';
import 'package:paynowbloc/utils/constants.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      color: appColor,
      title: appTitle,
      home: Splash(),
    )
);