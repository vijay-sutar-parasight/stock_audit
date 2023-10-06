import 'package:flutter/material.dart';
import 'package:stock_audit/splash_screen.dart';
import 'package:stock_audit/util/constants.dart' as constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Audit',
      theme: ThemeData(
        useMaterial3: true,
          appBarTheme: AppBarTheme(
            color: constants.mainColor,
          ),
      ),
      //home: const MyHomePage(title: 'Stock Audit'),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.mainColor,
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
    }
  }
}
