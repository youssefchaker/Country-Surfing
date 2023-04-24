import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/pages/time.dart';
import 'package:test/pages/info.dart';
import 'package:test/models/country.dart';
import 'package:test/pages/quiz.dart';
import 'package:test/pages/request.dart';
import 'package:test/models/users.dart';
import 'package:test/wrapper.dart';
import 'package:test/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
        catchError: (_, __) => null,
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
          routes: {
            '/': (context) => Wrapper(),
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
            '/quiz': (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments as Country;
              return CountryQuiz(country: args);
            },
            '/request': (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments as Country;
              return CountryRequest(country: args);
            },
          },
        ));
  }
}
