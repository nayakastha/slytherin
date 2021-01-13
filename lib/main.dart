import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];

  static var randomNumber = Random();
  int food = randomNumber.nextInt(250);
  var direction = 'down';
  bool showNav = false;
  void startGame(int numberOfSquares) {
    snakePosition = [45, 65, 85, 105, 125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      setState(() {
        showNav = true;
        food = updateSnake(numberOfSquares, snakePosition, food, direction);
      });

      if (gameOver(snakePosition)) {
        timer.cancel();
        setState(() {
          showNav = false;
        });
        _showGameOverScreen(numberOfSquares);
      }
    });
  }

  void _showGameOverScreen(int numberOfSquares) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'GAME OVER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromRGBO(48, 71, 94, 1),
            content: Text(
              'You scored ' + snakePosition.length.toString(),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    startGame(numberOfSquares);
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //double approx = (MediaQuery.of(context).size.longestSide / 20) - 4;
    //int numberOfSquares = approx.toInt() * 20;
    final int numberOfSquares = 280;
    return Scaffold(
      backgroundColor: Color.fromRGBO(34, 40, 49, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePosition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    if (index == food) {
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(color: Colors.green)),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                color: Color.fromRGBO(48, 71, 94, 0.3))),
                      );
                    }
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              child: !showNav
                  ? Center(
                      child: InkWell(
                          onTap: () {
                            startGame(numberOfSquares);
                          },
                          child: Text(
                            'S T A R T',
                            style: TextStyle(
                                color: Color.fromRGBO(221, 221, 221, 1),
                                fontSize: 30),
                          )),
                    )
                  : Center(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              size: 40,
                            ),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                if (direction != 'right') {
                                  direction = 'left';
                                }
                              });
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_upward_rounded,
                                  size: 40,
                                ),
                                iconSize: 40,
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    if (direction != 'down') {
                                      direction = 'up';
                                    }
                                  });
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_downward_rounded,
                                  size: 40,
                                ),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  setState(() {
                                    if (direction != 'up') {
                                      direction = 'down';
                                    }
                                  });
                                }),
                          ],
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              size: 40,
                            ),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                if (direction != 'left') {
                                  direction = 'right';
                                }
                              });
                            }),
                      ],
                    )),
            ),
          )
        ],
      ),
    );
  }

  int updateSnake(int numberOfSquares, List<int> snakePosition, int food,
      String direction) {
    switch (direction) {
      case 'down':
        if (snakePosition.last > (numberOfSquares - 20)) {
          snakePosition.add(snakePosition.last + 20 - numberOfSquares);
        } else {
          snakePosition.add(snakePosition.last + 20);
        }

        break;

      case 'up':
        if (snakePosition.last < 20) {
          snakePosition.add(snakePosition.last - 20 + numberOfSquares);
        } else {
          snakePosition.add(snakePosition.last - 20);
        }
        break;

      case 'left':
        if (snakePosition.last % 20 == 0) {
          snakePosition.add(snakePosition.last - 1 + 20);
        } else {
          snakePosition.add(snakePosition.last - 1);
        }

        break;

      case 'right':
        if ((snakePosition.last + 1) % 20 == 0) {
          snakePosition.add(snakePosition.last + 1 - 20);
        } else {
          snakePosition.add(snakePosition.last + 1);
        }
        break;

      default:
    }

    if (snakePosition.last == food) {
      food = Random().nextInt(numberOfSquares);
      return food;
    } else {
      snakePosition.removeAt(0);
    }

    return food;
  }

  bool gameOver(List<int> snakePosition) {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }
}
