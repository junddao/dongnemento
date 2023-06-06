import 'package:base_project/global/theme/ink_highlight.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style/du_colors.dart';
import '../style/du_text_styles.dart';

ThemeData lightTheme() {
  MaterialColor mainColor = createMaterialColor(DUColors.tomato);
  return ThemeData(
    useMaterial3: false,
    primarySwatch: mainColor, // 메인색상
    canvasColor: DUColors.background, // 기본 배경화면 테마
    dividerColor: DUColors.grey4,

    // 터치 이펙트 제거
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,

    // colorScheme: ColorScheme(
    //   primary: mainColor, //* TextFormField icon focus color
    //   // primaryVariant: mainColor[300]!,
    //   secondary: DUColors.white, // floating 버튼 색상
    //   // secondaryVariant: subColor[300]!,
    //   surface: DUColors.background, // card background
    //   background: DUColors.background,
    //   error: DUColors.warning,
    //   onPrimary: DUColors.grey0,
    //   onSecondary: DUColors.grey0,
    //   onSurface: DUColors.grey0, // card text, icon
    //   onBackground: DUColors.grey0,
    //   onError: DUColors.white,
    //   brightness: Brightness.light,
    // ),

    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: DUColors.white,
        statusBarIconBrightness: Brightness.dark, //android
        statusBarBrightness: Brightness.light, //ios
      ),
      backgroundColor: DUColors.background,
      foregroundColor: DUColors.grey0,
      iconTheme: IconThemeData(color: DUColors.grey0),
      actionsIconTheme: IconThemeData(color: DUColors.grey0),
      elevation: 0,
      titleSpacing: 0,
    ),
    // // 텍스트 테마
    // textTheme: TextTheme(
    //   headline4: DUTextStyle.size30.copyWith(color: DUColors.grey0),
    //   headline5: DUTextStyle.size24.copyWith(color: DUColors.grey0),
    //   headline6: DUTextStyle.size20M.copyWith(color: DUColors.grey0), // appBar
    //   subtitle1: DUTextStyle.size16M.copyWith(color: DUColors.grey0),
    //   subtitle2: DUTextStyle.size14M.copyWith(color: DUColors.grey0),
    //   bodyText1: DUTextStyle.size16.copyWith(color: DUColors.grey0),
    //   bodyText2: DUTextStyle.size14.copyWith(color: DUColors.grey0),
    //   caption: DUTextStyle.size12.copyWith(color: DUColors.grey0),
    //   button: DUTextStyle.size14M.copyWith(color: DUColors.grey0),
    //   overline: DUTextStyle.size10.copyWith(color: DUColors.grey0),
    // ),

    //* text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        foregroundColor: mainColor,
        disabledForegroundColor: DUColors.grey2,
      ),
    ),

    // //* elevatedButton theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     minimumSize: const Size(64, 52),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    //     textStyle: DUTextStyle.size16,
    //   ).copyWith(
    //     elevation: MaterialStateProperty.all(0.0),
    //     backgroundColor: materialStateColor(mainColor, DUColors.grey5),
    //     foregroundColor: materialStateColor(DUColors.white, DUColors.grey2),
    //     overlayColor: materialSolidColor(Colors.white38),
    //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //     splashFactory: InkHighlightFactory(),
    //   ),
    // ),

    // //* outlinedButton theme
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     minimumSize: const Size(64, 52),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    //     textStyle: DUTextStyle.size16,
    //   ).copyWith(
    //     backgroundColor: materialStateColor(
    //       DUColors.background,
    //       DUColors.white,
    //     ),
    //     foregroundColor: materialStateColor(mainColor, mainColor.withOpacity(0.5)),
    //     side: materialStateBorder(mainColor, mainColor.withOpacity(0.5)),
    //     overlayColor: materialSolidColor(Colors.black12),
    //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //     splashFactory: InkHighlightFactory(),
    //   ),
    // ),

    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return mainColor;
        } else if (states.contains(MaterialState.disabled)) {
          return DUColors.background;
        }
        return null;
      }),
    ),

    //* bottomNavigationBar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DUColors.background, // 바텀 백그라운드 색상
      selectedItemColor: mainColor, // 선택한 아이콘 색상
      unselectedItemColor: DUColors.grey2, // 선택안한 아이콘 색상
    ),

    //* dialog theme
    dialogTheme: DialogTheme(
      backgroundColor: DUColors.background,
      titleTextStyle: DUTextStyle.size24.black,
      contentTextStyle: DUTextStyle.size14.black,
    ),

    //* snackBar theme
    snackBarTheme: SnackBarThemeData(actionTextColor: Colors.purple[200]),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        sizeConstraints: BoxConstraints.tightFor(
          width: 40.0,
          height: 40.0,
        ),
        smallSizeConstraints: BoxConstraints.tightFor(
          width: 40.0,
          height: 40.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        )),
        elevation: 3,
        focusElevation: 4,
        highlightElevation: 4),

    // //* 인풋 상자 꾸미기
    // inputDecorationTheme: InputDecorationTheme(
    //   // 사이즈
    //   isDense: true,
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),

    //   // 배경 색상
    //   filled: true,
    //   fillColor: Colors.black.withAlpha(0xFF - 0xF8),

    //   // 테두리 색상
    //   enabledBorder: const OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(4))),
    //   disabledBorder: const OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(4))),
    //   focusedBorder: const OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.transparent /* mainColor */),
    //       borderRadius: BorderRadius.all(Radius.circular(4))),
    //   errorBorder: const OutlineInputBorder(
    //       borderSide: BorderSide(color: DUColors.warning, width: 0.7),
    //       borderRadius: BorderRadius.all(Radius.circular(4))),
    //   focusedErrorBorder: const OutlineInputBorder(
    //       borderSide: BorderSide(color: DUColors.warning), borderRadius: BorderRadius.all(Radius.circular(4))),

    //   // 부수적인 글자 크기 & 색상
    //   labelStyle: DUTextStyle.size14.copyWith(color: DUColors.grey1),
    //   floatingLabelBehavior: FloatingLabelBehavior.never,
    //   floatingLabelStyle: DUTextStyle.size12.copyWith(color: DUColors.grey1),
    //   hintStyle: DUTextStyle.size14.copyWith(color: DUColors.grey2),
    //   helperStyle: DUTextStyle.size12.copyWith(color: DUColors.grey1),
    //   errorStyle: DUTextStyle.size12.copyWith(color: DUColors.warning),

    //   prefixStyle: DUTextStyle.size14.grey0.h1_5,
    //   suffixStyle: DUTextStyle.size14.grey0.h1_5,
    // ),
  );
}

ThemeData darkTheme() {
  MaterialColor mainColor = createMaterialColor(DUColors.subBlue);
  return ThemeData(
    useMaterial3: false,
    primarySwatch: mainColor, // 메인색상
    canvasColor: DUColors.background, // 기본 배경화면 테마
    dividerColor: DUColors.grey5,

    // 터치 이펙트 제거
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,

    colorScheme: ColorScheme(
      primary: mainColor, //* TextFormField icon focus color
      // primaryVariant: mainColor[300]!,
      secondary: DUColors.white, // floating 버튼 색상
      // secondaryVariant: subColor[300]!,
      surface: DUColors.background, // card background
      background: DUColors.background,
      error: DUColors.warning,
      onPrimary: DUColors.grey0,
      onSecondary: DUColors.grey0,
      onSurface: DUColors.grey0, // card text, icon
      onBackground: DUColors.grey0,
      onError: DUColors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: DUColors.white,
        statusBarIconBrightness: Brightness.dark, //android
        statusBarBrightness: Brightness.light, //ios
      ),
      backgroundColor: DUColors.background,
      foregroundColor: DUColors.grey0,
      iconTheme: IconThemeData(color: DUColors.grey0),
      actionsIconTheme: IconThemeData(color: DUColors.grey0),
      elevation: 0,
      titleSpacing: 0,
    ),
    // 텍스트 테마
    textTheme: TextTheme(
      headlineMedium: DUTextStyle.size30.copyWith(color: DUColors.grey0),
      headlineSmall: DUTextStyle.size24.copyWith(color: DUColors.grey0),
      titleLarge: DUTextStyle.size20M.copyWith(color: DUColors.grey0), // appBar
      titleMedium: DUTextStyle.size16M.copyWith(color: DUColors.grey0),
      titleSmall: DUTextStyle.size14M.copyWith(color: DUColors.grey0),
      bodyLarge: DUTextStyle.size16.copyWith(color: DUColors.grey0),
      bodyMedium: DUTextStyle.size14.copyWith(color: DUColors.grey0),
      bodySmall: DUTextStyle.size12.copyWith(color: DUColors.grey0),
      labelLarge: DUTextStyle.size14M.copyWith(color: DUColors.grey0),
      labelSmall: DUTextStyle.size10.copyWith(color: DUColors.grey0),
    ),

    //* text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        // textStyle: DUTextStyle.size14M,
      ).copyWith(
        foregroundColor: materialStateColor(mainColor, DUColors.grey2),
        overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: InkHighlightFactory(),
      ),
    ),

    //* elevatedButton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(64, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        textStyle: DUTextStyle.size16,
      ).copyWith(
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: materialStateColor(mainColor, DUColors.grey5),
        foregroundColor: materialStateColor(DUColors.white, DUColors.grey2),
        overlayColor: materialSolidColor(Colors.white38),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: InkHighlightFactory(),
      ),
    ),

    //* outlinedButton theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(64, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        textStyle: DUTextStyle.size16,
      ).copyWith(
        backgroundColor: materialStateColor(
          DUColors.background,
          DUColors.white,
        ),
        foregroundColor: materialStateColor(mainColor, mainColor.withOpacity(0.5)),
        side: materialStateBorder(mainColor, mainColor.withOpacity(0.5)),
        overlayColor: materialSolidColor(Colors.black12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: InkHighlightFactory(),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return mainColor;
        } else if (states.contains(MaterialState.disabled)) {
          return DUColors.background;
        }
        return null;
      }),
    ),

    //* bottomNavigationBar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DUColors.background, // 바텀 백그라운드 색상
      selectedItemColor: mainColor, // 선택한 아이콘 색상
      unselectedItemColor: DUColors.grey2, // 선택안한 아이콘 색상
    ),

    //* dialog theme
    dialogTheme: DialogTheme(
      backgroundColor: DUColors.background,
      titleTextStyle: DUTextStyle.size24.black,
      contentTextStyle: DUTextStyle.size14.black,
    ),

    //* snackBar theme
    snackBarTheme: SnackBarThemeData(actionTextColor: Colors.purple[200]),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        sizeConstraints: BoxConstraints.tightFor(
          width: 40.0,
          height: 40.0,
        ),
        smallSizeConstraints: BoxConstraints.tightFor(
          width: 40.0,
          height: 40.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        )),
        elevation: 3,
        focusElevation: 4,
        highlightElevation: 4),

    //* 인풋 상자 꾸미기
    inputDecorationTheme: InputDecorationTheme(
      // 사이즈
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),

      // 배경 색상
      filled: true,
      fillColor: Colors.black.withAlpha(0xFF - 0xF8),

      // 테두리 색상
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(4))),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(4))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent /* mainColor */),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: DUColors.warning, width: 0.7),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: DUColors.warning), borderRadius: BorderRadius.all(Radius.circular(4))),

      // 부수적인 글자 크기 & 색상
      labelStyle: DUTextStyle.size14.copyWith(color: DUColors.grey1),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      floatingLabelStyle: DUTextStyle.size12.copyWith(color: DUColors.grey1),
      hintStyle: DUTextStyle.size14.copyWith(color: DUColors.grey2),
      helperStyle: DUTextStyle.size12.copyWith(color: DUColors.grey1),
      errorStyle: DUTextStyle.size12.copyWith(color: DUColors.warning),

      prefixStyle: DUTextStyle.size14.grey0.h1_5,
      suffixStyle: DUTextStyle.size14.grey0.h1_5,
    ),
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

MaterialStateProperty<Color?>? materialStateColor(Color? normal, Color? disabled, {Color? pressed, Color? selected}) =>
    MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (disabled != null && states.contains(MaterialState.disabled)) {
          return disabled;
        }
        if (pressed != null && states.contains(MaterialState.pressed)) {
          return pressed;
        }
        if (selected != null && states.contains(MaterialState.selected)) {
          return selected;
        }
        return normal;
      },
    );

MaterialStateProperty<Color?>? materialSolidColor(Color? solid) => MaterialStateProperty.all<Color?>(solid);

MaterialStateProperty<T> materialAll<T>(T all) => MaterialStateProperty.all<T>(all);

MaterialStateProperty<BorderSide?>? materialStateBorder(Color normal, Color? disabled,
        {Color? pressed, Color? selected, double width = 1.0}) =>
    MaterialStateProperty.resolveWith<BorderSide?>(
      (Set<MaterialState> states) {
        final Color borderColor;
        if (disabled != null && states.contains(MaterialState.disabled)) {
          borderColor = disabled;
        } else if (pressed != null && states.contains(MaterialState.pressed)) {
          borderColor = pressed;
        } else if (selected != null && states.contains(MaterialState.selected)) {
          borderColor = selected;
        } else {
          borderColor = normal;
        }
        return BorderSide(color: borderColor, width: width);
      },
    );
