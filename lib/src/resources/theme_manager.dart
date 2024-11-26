import 'package:flutter/material.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/font_manager.dart';
import 'package:my_peopler/src/resources/styles_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      useMaterial3: false,
      //main colors of the app
      primaryColor: ColorManager.primaryCol,
      primaryColorLight: ColorManager.primaryColorLight,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      //ripple color
      splashColor: ColorManager.primaryOpacity70,

      //for example will be used incase of disabled button
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

      //card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primaryCol,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryCol,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      
      

      //button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primaryCol,
          splashColor: ColorManager.primaryCol),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.primaryCol,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      //
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.primaryCol,
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      //text theme
      textTheme: TextTheme(
          displayLarge: getBoldTextStyle(
            fontSize: FontSize.s18,
            color: ColorManager.black,
          ),
          displayMedium: getSemiBoldTextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
          displaySmall: getMediumTextStyle(
            color: ColorManager.primaryCol,
            fontSize: FontSize.s14,
          ),

          headlineLarge: getBoldTextStyle(
            color: ColorManager.white,
            fontSize: FontSize.s20,
          ),
          
          headlineSmall: getRegularStyle(
            color: ColorManager.white,
            fontSize: FontSize.s14,
          ),

          headlineMedium: getRegularStyle(
            color: ColorManager.primaryCol,
            fontSize: FontSize.s14,
          ),
          titleLarge: getBoldTextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
          titleMedium: getMediumTextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14,
          ),
          titleSmall: getMediumTextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s12,
          ),
          bodySmall: getRegularStyle(
            color: ColorManager.black,
          ),
          bodyLarge: getRegularStyle(
            color: ColorManager.black,
          ),
          
          bodyMedium: getMediumTextStyle(
            color: ColorManager.black,
          )),

      //input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),

          //hint style
          hintStyle: getRegularStyle(color: ColorManager.grey1),

          //label style
          labelStyle: getMediumTextStyle(color: ColorManager.darkGrey),

          //error style
          errorStyle: getRegularStyle(color: ColorManager.error),

          //enabled border
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          //focused border
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryCol, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          //error border
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.error,
                width: AppSize.s1_5,
              ),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          //focused error border
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryCol, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8)))));
}
