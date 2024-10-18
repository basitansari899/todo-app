import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/app/theme/colors.dart';

export 'colors.dart';

final appTheme = _createAppTheme(ThemeData.light());

ThemeData _createAppTheme(ThemeData baseTheme) {
  final textTheme = _createTextTheme(baseTheme.textTheme);
  return baseTheme.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white,surfaceTintColor:Colors.white, ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    inputDecorationTheme: _createInputDecorationTheme(textTheme),
    tabBarTheme: createTabBarTheme(textTheme),
     bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
     dialogTheme: const DialogTheme(backgroundColor:Colors.white),
    dropdownMenuTheme:  DropdownMenuThemeData(
      menuStyle:
        MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.white),surfaceTintColor:WidgetStateProperty.all(Colors.white)),
  ),
  canvasColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.white,
  )
  );
}

InputDecorationTheme _createInputDecorationTheme(TextTheme textTheme) {
  return InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 14, color: XColors.black.withOpacity(0.5)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    enabledBorder: _borderColor(XColors.gray4),
    focusedBorder: _borderColor(XColors.gray4),
    errorBorder: _borderColor(XColors.error),
    focusedErrorBorder: _borderColor(XColors.error),
    errorStyle: textTheme.bodyText3?.copyWith(color: XColors.error),
  );
}

OutlineInputBorder _borderColor(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
  );
}

TabBarTheme createTabBarTheme(TextTheme textTheme) {
  return TabBarTheme(
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(width: 2, color: XColors.primaryColor),
      insets: EdgeInsets.symmetric(horizontal: 48),
    ),
    labelStyle: textTheme.bodyText2Bold,
    labelColor: XColors.blue,
    unselectedLabelColor: XColors.gray4,
  );
}

TextTheme _createTextTheme(TextTheme baseTheme) {
  return GoogleFonts.robotoTextTheme(baseTheme).copyWith(
    displayLarge: const TextStyle(fontSize: 40, color: XColors.black, fontWeight: FontWeight.w500),
    displayMedium: const TextStyle(fontSize: 32, color: XColors.black, fontWeight: FontWeight.w500),
    displaySmall: const TextStyle(fontSize: 28, color: XColors.black, fontWeight: FontWeight.w500),
    headlineMedium: const TextStyle(fontSize: 24, color: XColors.black, fontWeight: FontWeight.w500),
    headlineSmall: const TextStyle(fontSize: 20, color: XColors.black, fontWeight: FontWeight.w500),
    titleLarge: const TextStyle(fontSize: 16, color: XColors.black, fontWeight: FontWeight.w500),
    bodyLarge: const TextStyle(fontSize: 16, color: XColors.black),
    bodyMedium: const TextStyle(fontSize: 14, color: XColors.black),
    labelSmall: const TextStyle(fontSize: 12, color: XColors.black, fontWeight: FontWeight.w600),
  );
}

extension XTextThemeExtension on TextTheme {
  TextStyle? get headline40Bold => displayLarge?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get headline2Bold => displayMedium?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get headline5Bold => headlineSmall?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get bodyText1SemiBold => bodyLarge?.copyWith(fontWeight: FontWeight.w500);

  TextStyle? get bodyText1Bold => bodyLarge?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get bodyText2SemiBold => bodyMedium?.copyWith(fontWeight: FontWeight.w500);

  TextStyle? get bodyText2Bold => bodyMedium?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get bodyText2BoldNumeral => bodyMedium?.copyWith(fontWeight: FontWeight.w700);

  TextStyle? get bodyText3 => bodyMedium?.copyWith(fontSize: 12);

  TextStyle? get bodyText4 => bodyMedium?.copyWith(fontSize: 10);

  TextStyle? get bodyText3SemiBold => bodyText3?.copyWith(fontWeight: FontWeight.w500);

  TextStyle? get bodyText3Bold => bodyText3?.copyWith(fontWeight: FontWeight.w600);

  TextStyle? get bodyText3BoldNumeral => bodyText3?.copyWith(fontWeight: FontWeight.w700);

  TextStyle get buttonText => const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  TextStyle get buttonTextExtraSmallNormal => const TextStyle(fontSize: 12, fontWeight: FontWeight.normal);

  TextStyle get buttonTextExtraSmall => const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  TextStyle get bodyTextExtraSmall => const TextStyle(fontSize: 10, fontWeight: FontWeight.w700);


}