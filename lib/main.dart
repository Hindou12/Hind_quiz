//import mateeial app package the first thing
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //run the runApp method

  runApp(
    const MyApp(), //I will create this below
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //remove the debug banner ::
      title: 'Hello to the quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home:
          const HomeScreen(), //  we will create this in separate file it's the scaffold
    );
  }
}
