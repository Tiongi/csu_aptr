import 'package:flutter/material.dart';
import 'package:quizzle/configs/configs.dart';

//CODES FOR THE EXAMINATION SCREEN TEXT STYLES USER INTERFACE

const kHeaderTS = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black);

const kDetailsTS = TextStyle(fontSize: 12);

TextStyle cardTitleTs(context) => TextStyle(
    color: UIParameters.isDarkMode(context)
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
    fontSize: MediaQuery.of(context).size.width * 0.040,
    fontWeight: FontWeight.bold);

const kQuizeTS = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);

const kAppBarTS = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: kOnSurfaceTextColor);

TextStyle countDownTimerTs(context) => TextStyle(
    letterSpacing: 2,
    color: UIParameters.isDarkMode(context)
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.bold);

const kQuizeNumberCardTs = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w500, color: kOnSurfaceTextColor);
