import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedprefrence_example2/home_screen.dart';
import 'package:sharedprefrence_example2/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          child: Text(
            "press",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue,
          onPressed: () async {
            bool visitingFlag = await getVisitingFlag();
            setVisitingFlang();

            if (visitingFlag == true) {
              //not first time visit
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
              //first time visiting
            }
          },
        ),
      ),
    );
  }
}

setVisitingFlang() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("alreadyVisited", true);
}

getVisitingFlag() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool? alreadyVisited = pref.getBool('alreadyVisited') ?? false;
  return alreadyVisited;
}
