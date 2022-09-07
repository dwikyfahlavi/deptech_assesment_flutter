import 'package:deptech_assesment_flutter/providers/admin_provider.dart';
import 'package:deptech_assesment_flutter/providers/cuti_provider.dart';
import 'package:deptech_assesment_flutter/providers/employee_provider.dart';
import 'package:deptech_assesment_flutter/screens/pegawai_screen.dart';
import 'package:deptech_assesment_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EmployeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CutiProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee App',
        theme: ThemeData(primarySwatch: Colors.blue, textTheme: GoogleFonts.rubikTextTheme()),
        home: const SplashFuturePage(),
      ),
    );
  }
}
