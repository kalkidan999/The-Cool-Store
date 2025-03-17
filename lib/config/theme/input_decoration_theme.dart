import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import 'theme_constants.dart';

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: inputFillColor,
  filled: true,
  labelStyle: GoogleFonts.urbanist(color: inputLabelColor, fontSize: 15),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius * 2)),
  borderSide: BorderSide(color: inputBorderColor),
);

const OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius * 2)),
  borderSide: BorderSide(color: inputBorderColor),
);

const OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius * 2)),
  borderSide: BorderSide(color: error),
);

OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        const BorderRadius.all(Radius.circular(defaultBorderRadius * 2)),
    borderSide: BorderSide(
        color: Theme.of(context)
            .textTheme
            .bodyLarge!
            .color!
            .withValues(alpha: 0.15)),
  );
}
