import 'dart:async';

import 'package:belarus_exchange_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:belarus_exchange_app/utils/utils.dart';

class InitialTitle extends StatefulWidget {

@override
  State<InitialTitle> createState() => _InitialTitleState();
}

class _InitialTitleState extends State<InitialTitle> {


  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _resetTimeEverySecond(DateTime.now()),
      style: AppStyles.headerTextStyle,
    );
  }

  String _resetTimeEverySecond (DateTime actualTime) {
    Timer? timer;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {

        });
      });
    
    return actualTime.toStringFormattedHoursAndSecondsOnly();
  }
}