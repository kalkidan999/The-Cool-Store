import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double defaultPadding = 16.0;
printDebug(dynamic message) {
  //if (DEBUG) log(message.toString());
  try {
    if (!kReleaseMode) log(message.toString());
  } catch (_) {}
}

SizedBox sizedHeight(double height) => SizedBox(height: height);

SizedBox sizedWidth(double width) => SizedBox(width: width);
