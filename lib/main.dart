// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:jobs_link/screens/Build.dart';
import 'package:jobs_link/auth/login.dart';
import 'package:jobs_link/auth/register.dart';
import 'package:jobs_link/models/ProfileModel.dart';
import 'package:jobs_link/screens/education.dart';
import 'package:jobs_link/screens/experience.dart';
import 'package:jobs_link/screens/help.dart';
import 'package:jobs_link/screens/objectives.dart';
import 'package:jobs_link/screens/profile.dart';
import 'package:jobs_link/screens/settings.dart';
import 'package:jobs_link/screens/skills.dart';
import 'package:jobs_link/screens/userpage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utility/globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static _MyAppState? of (BuildContext context)=> context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Builder',
      debugShowCheckedModeBanner: false,
      theme: changeTheme(globals.isDarkMode),
     // Provider.of<ThemeProvider>(context).isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Settings(onThemeChanged: (bool ) { 
        
       },),
      initialRoute: '/auth/register',
      routes: {
        '/auth/register': (context) => Register(),
        '/auth/login': (context) => Login(),
        '/userpage': (context) => Userpage(),
        '/settings': (context) => Settings(onThemeChanged: (bool ) {  },),
        '/profile': (context) => Profile(),
        '/build': (context) => Build(),
        '/objective': (context) => Objectives(),
        '/personal': (context) => Profile(),
        '/education': (context) => Education(),
        '/experience': (context) => Experience(),
        '/skills': (context) => Skills(),
        '/help': (context) => Help(),
      },
    );
  }
  dynamic changeTheme(bool? value){
    print("-----------------------");
   setState((){
    globals.isDarkMode == true?ThemeData.dark():ThemeData.light();
      });
      if(globals.isDarkMode){return ThemeData.dark();} else {
        return ThemeData.light();
      }
      
}
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = globals.isDarkMode;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}




 