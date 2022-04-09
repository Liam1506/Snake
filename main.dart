import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

var colors = [];
int x2 = 3;
int y2 = 3;
int direction = 0;
var positions = [];
int lenghtSnake = 0;
var lenghtX = 18;
var lenghtY = 10;

var random = Random();
int appleY = random.nextInt(lenghtX - 1);

int appleX = random.nextInt(lenghtY - 1);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake🐍',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Snake🐍'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  setBlack() {
    for (var x = 0; x <= lenghtX; x++) {
      for (var y = 0; y <= lenghtY; y++) {
        colors[x][y] = Colors.black;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    for (var x = 0; x <= lenghtX; x++) {
      colors.add([]);
      for (var y = 0; y <= lenghtY; y++) {
        colors[x].add(Colors.black);
      }
    }

    repeat();
  }

  repeat() async {
    Timer(const Duration(milliseconds: 100), () {
      if (direction == -1) {
        direction = 3;
      }
      if (direction == 4) {
        direction = 0;
      }
      if (direction == 1) {
        x2++;
      } else if (direction == 2) {
        y2--;
      } else if (direction == 3) {
        x2--;
      } else if (direction == 0) {
        y2++;
      }
      if (x2 == lenghtY + 1) {
        x2 = 0;
      }
      if (x2 == -1) {
        x2 = lenghtY;
      }
      if (y2 == lenghtX + 1) {
        y2 = 0;
      }
      if (y2 == -1) {
        y2 = lenghtX;
      }
      positions.add([y2, x2]);

      setBlack();
      if (x2 == appleX && y2 == appleY) {
        appleY = random.nextInt(lenghtX.toInt());

        appleX = random.nextInt(lenghtY.toInt());
        lenghtSnake++;
      }

      colors[appleY][appleX] = Colors.red;
      if (positions.length - 1 > lenghtSnake) {
        colors[y2][x2] = Colors.green;
        for (var i = 0; i < lenghtSnake; i++) {
          int y3 = positions[positions.length - (i + 2)][0];
          int x3 = positions[positions.length - (i + 2)][1];
          if (x3 == x2 && y2 == y3) {
            lenghtSnake = 0;
            positions.clear();
            setBlack();
          }
          colors[y3][x3] = Colors.green;
        }
      } else {
        colors[y2][x2] = Colors.green;
      }
      setState(() {});
      repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (lenghtSnake + 1).toString(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            for (var x = 0; x <= lenghtX; x++)
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var y = 0; y <= lenghtY; y++)
                    Container(
                      decoration: BoxDecoration(
                          color: colors[x][y],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      margin: const EdgeInsets.all(2),
                      height: 30,
                      width: 30,
                    )
                ],
              ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => direction--,
                  child: SizedBox(
                    // color: Colors.red,
                    height: 100,
                    width: (MediaQuery.of(context).size.width) / 2,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 80,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => direction++,
                  child: SizedBox(
                    //  color: Colors.green,
                    height: 100,
                    width: (MediaQuery.of(context).size.width) / 2,
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 80,
                    ),
                  ),
                ),
              ],
            ),
          ]),
    ));
  }
}
