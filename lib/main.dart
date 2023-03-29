import 'package:flutter/material.dart';
import 'package:test/pages/choose_location.dart';
import 'package:test/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/time.dart';
import 'package:test/info.dart';
import 'package:test/models/country.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //wrap the app with stream provider to be able to get the user info anywhere
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => StartPage(),
      '/location': (context) => ChooseLocation(),
      '/time': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Country;
        return CountryTime(country: args);
      },
      '/info': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Country;
        return CountryInfo(country: args);
      },
    });
  }
}

