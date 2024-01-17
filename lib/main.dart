import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_vote/firebase_options.dart';
import 'package:live_vote/presentation/screens/user/home/home.dart';
import 'package:live_vote/route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'NicoMoji',
          ),
          routes: routes,
          // home: HomePage(),
        );
      },
    );
  }
}
