import 'package:flutter/material.dart';

class Dimens {
  static double? _diffFactor;
  static double? _screenHeight;

  static initDimens(BuildContext context) {
    _diffFactor = MediaQuery.of(context).size.width / 411.42857142857144;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  static double get screenHeight => _screenHeight ?? 300;

  static double get dimen_0 => getAdjustedDimen(0);
  static double get dimen_0_2 => getAdjustedDimen(0.2);
  static double get dimen_0_3 => getAdjustedDimen(0.3);
  static double get dimen_0_5 => getAdjustedDimen(0.5);
  static double get dimen_0_8 => getAdjustedDimen(0.8);
  static double get dimen_0_7 => getAdjustedDimen(0.7);
  static double get dimen_0_9 => getAdjustedDimen(0.9);
  static double get dimen_1 => getAdjustedDimen(1);
  static double get dimen_1_5 => getAdjustedDimen(1.5);
  static double get dimen_2 => getAdjustedDimen(2);
  static double get dimen_3 => getAdjustedDimen(3);
  static double get dimen_4 => getAdjustedDimen(4);
  static double get dimen_5 => getAdjustedDimen(5);
  static double get dimen_6 => getAdjustedDimen(6);
  static double get dimen_7 => getAdjustedDimen(7);
  static double get dimen_7_5 => getAdjustedDimen(7.5);
  static double get dimen_8 => getAdjustedDimen(8);
  static double get dimen_9 => getAdjustedDimen(9);
  static double get dimen_10 => getAdjustedDimen(10);
  static double get dimen_12 => getAdjustedDimen(12);
  static double get dimen_12_5 => getAdjustedDimen(12.5);
  static double get dimen_13 => getAdjustedDimen(13);
  static double get dimen_14 => getAdjustedDimen(14);
  static double get dimen_15 => getAdjustedDimen(15);
  static double get dimen_16 => getAdjustedDimen(16);
  static double get dimen_18 => getAdjustedDimen(18);
  static double get dimen_19 => getAdjustedDimen(19);
  static double get dimen_20 => getAdjustedDimen(20);
  static double get dimen_21 => getAdjustedDimen(21);
  static double get dimen_22 => getAdjustedDimen(22);
  static double get dimen_23 => getAdjustedDimen(23);
  static double get dimen_24 => getAdjustedDimen(24);
  static double get dimen_25 => getAdjustedDimen(25);
  static double get dimen_28 => getAdjustedDimen(28);
  static double get dimen_29 => getAdjustedDimen(29);
  static double get dimen_30 => getAdjustedDimen(30);
  static double get dimen_32 => getAdjustedDimen(32);
  static double get dimen_35 => getAdjustedDimen(35);
  static double get dimen_38 => getAdjustedDimen(38);
  static double get dimen_40 => getAdjustedDimen(40);
  static double get dimen_44 => getAdjustedDimen(44);
  static double get dimen_45 => getAdjustedDimen(45);
  static double get dimen_46 => getAdjustedDimen(46);
  static double get dimen_48 => getAdjustedDimen(48);
  static double get dimen_50 => getAdjustedDimen(50);
  static double get dimen_52 => getAdjustedDimen(52);
  static double get dimen_54 => getAdjustedDimen(54);
  static double get dimen_55 => getAdjustedDimen(55);
  static double get dimen_60 => getAdjustedDimen(60);
  static double get dimen_67 => getAdjustedDimen(67);
  static double get dimen_70 => getAdjustedDimen(70);
  static double get dimen_80 => getAdjustedDimen(80);
  static double get dimen_90 => getAdjustedDimen(90);
  static double get dimen_94 => getAdjustedDimen(94);
  static double get dimen_100 => getAdjustedDimen(100);
  static double get dimen_120 => getAdjustedDimen(120);
  static double get dimen_150 => getAdjustedDimen(150);
  static double get dimen_160 => getAdjustedDimen(160);
  static double get dimen_170 => getAdjustedDimen(170);
  static double get dimen_180 => getAdjustedDimen(180);
  static double get dimen_200 => getAdjustedDimen(200);
  static double get dimen_216 => getAdjustedDimen(216);
  static double get dimen_320 => getAdjustedDimen(320);
  static double get dimen_220 => getAdjustedDimen(220);
  static double get dimen_250 => getAdjustedDimen(250);
  static double get dimen_280 => getAdjustedDimen(280);
  static double get dimen_300 => getAdjustedDimen(300);
  static double get dimen_400 => getAdjustedDimen(400);
  static double get dimen_500 => getAdjustedDimen(500);

  static double getAdjustedDimen(double orignalDimen) {
    if (_diffFactor != null && _diffFactor! <= 1.5) {
      return orignalDimen * _diffFactor!;
    } else {
      return orignalDimen;
    }
  }
}
