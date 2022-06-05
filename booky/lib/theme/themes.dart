import 'package:booky/theme/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData _globalTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.blue500,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: AppColors.blue500,
            centerTitle: true,
            titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                ),
          ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.blue500,
            secondary: AppColors.purple500,
            tertiary: AppColors.pink500,
          ),
    );
  }

  static ThemeData darkTheme(context) {
    var base = _globalTheme(context);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        background: AppColors.gray900,
        surfaceVariant: const Color(0xFF49454F),
        onSurface: AppColors.gray50,
        onSurfaceVariant: const Color(0xFF8E8993),
      ),
      scaffoldBackgroundColor: AppColors.gray900,
      textTheme: base.textTheme
          .apply(bodyColor: AppColors.gray50, displayColor: AppColors.gray50),
    );
  }

  static ThemeData lightTheme(context) {
    var base = _globalTheme(context);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        background: AppColors.gray50,
        surfaceVariant: const Color(0xFFE3E0E5),
        onSurface: AppColors.gray900,
        onSurfaceVariant: const Color(0xFF49454F),
      ),
      scaffoldBackgroundColor: AppColors.gray50,
      textTheme: base.textTheme
          .apply(bodyColor: AppColors.gray900, displayColor: AppColors.gray900),
    );
  }
}
