import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/pages/intro_page.dart';
import 'package:pet_boarding_space/pages/payment_page.dart';
import 'package:pet_boarding_space/pages/space_list_page.dart';
import 'package:pet_boarding_space/pages/test_page.dart';
import 'package:pet_boarding_space/pages/user_form_page.dart';
import 'package:pet_boarding_space/theme/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _meowoofTheme,
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/userformpage': (context) => const UserFormPage(),
        '/spacelistpage': (context) => const SpaceListPage(),
        '/paymentpage': (context) => const PaymentPage(),
        '/testpage': (context) => const TestPage(),
      },
    );
  }
}

final ThemeData _meowoofTheme = _buildMeowoofTheme();

ThemeData _buildMeowoofTheme() {
  final ThemeData base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    primaryColor: primaryColor,
    colorScheme: base.colorScheme.copyWith(
      primary: primaryColor,
      error: errorColor,
    ),
    textTheme: _buildMeowoofTextTheme(
      GoogleFonts.nunitoSansTextTheme(base.textTheme),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: transparentColor,
      elevation: 0,
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

TextTheme _buildMeowoofTextTheme(TextTheme base) {
  return base.copyWith(
    headlineLarge: base.headlineLarge!.copyWith(
      fontWeight: FontWeight.w900,
    ),
    headlineSmall: base.headlineSmall!.copyWith(
      fontWeight: FontWeight.w900,
    ),
    titleMedium: base.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: base.bodyLarge!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    labelLarge: base.labelLarge!.copyWith(
      fontWeight: FontWeight.w900,
      color: Colors.grey[100],
    ),
  );
}
