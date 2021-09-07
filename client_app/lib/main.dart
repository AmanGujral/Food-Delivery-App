import 'package:client_app/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:client_app/components/bottom_nav_bar.dart';
import 'package:client_app/screens/home/home_screen.dart';
import 'package:client_app/screens/onboarding/onboarding_scrreen.dart';
import 'package:client_app/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: MaterialAppTree(),
    );
  }
}


class MaterialAppTree extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food UI Kit',
      theme: buildThemeData(),

      /// On first screen must call [SizeConfig().init(context)]
      home: WidgetTree(),
      // home: HomeScreen(),
      // home: BottomNavBar(),
    );
  }
}
