import 'package:driver_app/ui/screens/dummy_navigation.dart';
import 'package:driver_app/ui/screens/home/home_screen.dart';
import 'package:driver_app/ui/screens/signin/signin_screen.dart';
import 'package:driver_app/ui/screens/signup/signup_screen.dart';
import 'package:driver_app/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: FirebaseAuth.instance.currentUser,
      value: FirebaseAuth.instance.authStateChanges(),
      child: MyMaterialApp(),
    );
  }
}


class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WidgetTree(),
      routes: {
        HomeScreen.TAG: (_) => HomeScreen(),
        SignUpScreen.TAG: (_) => SignUpScreen(),
        SignInScreen.TAG: (_) => SignInScreen(),
        DummyNavigation.TAG: (_) => DummyNavigation(),
      },
    );
  }
}
