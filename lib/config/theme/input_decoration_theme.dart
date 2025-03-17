import 'package:flutter/material.dart';

import 'theme_constants.dart';

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    fillColor: inputFillColor,
    filled: true,
    labelStyle: TextStyle(color: inputLabelColor, fontSize: 15),
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedOutlineInputBorder,
    errorBorder: errorOutlineInputBorder);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular((8)),
  borderSide: BorderSide(color: inputBorderColor),
);

OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular((8)),
  borderSide: BorderSide(color: inputBorderColor),
);

OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular((8)),
  borderSide: BorderSide(color: error),
);

OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
        color: Theme.of(context)
            .textTheme
            .bodyLarge!
            .color!
            .withValues(alpha: 0.15)),
  );
}
