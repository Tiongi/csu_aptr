import 'package:flutter/material.dart';
import 'package:quizzle/configs/configs.dart';

import '../../constants/constant.dart';

const kOnSurfaceTextColor = Colors.white;
const kCorrectAnswerColor = violet;
const kWrongAnswerColor = Color.fromARGB(255, 230, 24, 24);
const kNotAnswerColor = Color.fromARGB(255, 120, 50, 80);

Color customScaffoldColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 14, 20, 44)
        : const Color.fromARGB(255, 240, 237, 255);

Color answerBorderColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 20, 46, 158)
        : const Color.fromARGB(255, 221, 221, 221);

Color answerSelectedColor(BuildContext context) =>
    Theme.of(context).primaryColor;
