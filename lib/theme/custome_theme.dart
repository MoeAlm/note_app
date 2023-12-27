import 'package:flutter/material.dart';
import 'package:note_app/theme/palette.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    final textScale = MediaQuery.textScaleFactorOf(context);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Cairo',
      primarySwatch: MaterialColor(Palette.red500.value, const {
        100: Palette.red100,
        200: Palette.red200,
        300: Palette.red300,
        400: Palette.red400,
        500: Palette.red500,
        600: Palette.red600,
        700: Palette.red700,
        800: Palette.red800,
        900: Palette.red900,
      }),
      scaffoldBackgroundColor: Palette.almostBlack,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Palette.almostBlack,
        titleTextStyle:
            TextStyle(fontSize: textScale * 30, fontFamily: 'Cairo'),
      ),
      sliderTheme: SliderThemeData(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade800,
          thumbColor: Colors.white,
          valueIndicatorColor: Palette.red500,
          inactiveTickMarkColor: Colors.transparent,
          activeTickMarkColor: Colors.transparent),
      textTheme: theme.primaryTextTheme
          .copyWith(
            labelLarge: theme.primaryTextTheme.labelLarge?.copyWith(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )
          .apply(displayColor: Colors.white, fontFamily: 'Cairo'),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.red500,
        foregroundColor: Colors.white,
      ),
    );
  }
}
