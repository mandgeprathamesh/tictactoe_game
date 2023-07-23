import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  String resultDeclaration = '';
  bool onturn = true;
  bool winnerfound = false;
  int filledbox = 0;
  int xscore = 0;
  int oscore = 0;
  int attemps = 0;

  List<int> matcheditems = [];

  static const maxseconds = 30;
  int seconds = maxseconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stoptimer();
        }
      });
    });
  }

  void stoptimer() {
    resettimer();
    timer?.cancel();
  }

  void resettimer() {
    seconds = maxseconds;
  }

  List<String> displayxo = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 159, 26),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Player O",
                            style: customFontWhite,
                          ),
                          Text(
                            oscore.toString(),
                            style: customFontWhite,
                          )
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Player X",
                            style: customFontWhite,
                          ),
                          Text(xscore.toString(), style: customFontWhite)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 5,
                              color: Color.fromARGB(255, 236, 159, 26),
                            ),
                            color: matcheditems.contains(index)
                                ? Color.fromARGB(255, 121, 219, 234)
                                : Color.fromARGB(255, 115, 98, 223),
                          ),
                          child: Center(
                            child: Text(displayxo[index],
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 64,
                                  ),
                                )),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          resultDeclaration,
                          style: customFontWhite,
                        ),
                        SizedBox(height: 30),
                        _buildtimer(),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  void _tapped(int index) {
    final isrunning = timer == null ? false : timer!.isActive;
    if (isrunning) {
      setState(() {
        if (onturn && displayxo[index] == '') {
          displayxo[index] = '0';
          filledbox++;
        } else if (!onturn && displayxo[index] == '') {
          displayxo[index] = 'X';
          filledbox++;
        }
        onturn = !onturn;
        _checkwinner();
      });
    }
  }

  void _checkwinner() {
    if (displayxo[0] == displayxo[1] &&
        displayxo[0] == displayxo[2] &&
        displayxo[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[0] + ' Wins !';
        _updatescore(displayxo[0]);
        matcheditems.addAll([0, 1, 2]);
        stoptimer();
      });
    }

    // check 2nd row
    if (displayxo[3] == displayxo[4] &&
        displayxo[3] == displayxo[5] &&
        displayxo[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[3] + ' Wins !';
        _updatescore(displayxo[3]);
        matcheditems.addAll([3, 4, 5]);
        stoptimer();
      });
    }

    // check 3rd row
    if (displayxo[6] == displayxo[7] &&
        displayxo[6] == displayxo[8] &&
        displayxo[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[6] + ' Wins !';
        _updatescore(displayxo[6]);
        matcheditems.addAll([6, 7, 8]);
        stoptimer();
      });
    }

    // check 1st column
    if (displayxo[0] == displayxo[3] &&
        displayxo[0] == displayxo[6] &&
        displayxo[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[0] + ' Wins !';
        _updatescore(displayxo[0]);
        matcheditems.addAll([0, 3, 6]);
        stoptimer();
      });
    }

    // check 2nd column
    if (displayxo[1] == displayxo[4] &&
        displayxo[1] == displayxo[7] &&
        displayxo[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[1] + ' Wins !';
        _updatescore(displayxo[1]);
        matcheditems.addAll([1, 4, 7]);
        stoptimer();
      });
    }

    // check 3rd column
    if (displayxo[2] == displayxo[5] &&
        displayxo[2] == displayxo[8] &&
        displayxo[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[2] + ' Wins !';
        _updatescore(displayxo[2]);
        matcheditems.addAll([2, 5, 8]);
        stoptimer();
      });
    }

    // check diagonal
    if (displayxo[0] == displayxo[4] &&
        displayxo[0] == displayxo[8] &&
        displayxo[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[0] + ' Wins !';
        _updatescore(displayxo[0]);
        matcheditems.addAll([0, 4, 8]);
        stoptimer();
      });
    }

    // check diagonal
    if (displayxo[6] == displayxo[4] &&
        displayxo[6] == displayxo[2] &&
        displayxo[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayxo[6] + ' Wins !';
        _updatescore(displayxo[6]);
        matcheditems.addAll([6, 4, 2]);
        stoptimer();
      });
    }
    if (!winnerfound && filledbox == 9) {
      setState(() {
        resultDeclaration = "Nobody Wins !";
        stoptimer();
      });
    }
  }

  void _updatescore(String winner) {
    if (winner == '0') {
      oscore++;
    } else if (winner == 'X') {
      xscore++;
    }
    winnerfound = true;
  }

  void _clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayxo[i] = '';
      }
      resultDeclaration = '';
      filledbox = 0;
      matcheditems = [];
    });
  }

  Widget _buildtimer() {
    final isrunning = timer == null ? false : timer!.isActive;
    return isrunning
        ? SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 76, 171, 218),
                  value: 1 - seconds / maxseconds,
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                  strokeWidth: 5,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                    onPressed: () {
                      startTimer();
                      _clearboard();
                      attemps++;
                    },
                    child: Text(
                      attemps == 0 ? "Start" : "Play Again ",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                    onPressed: () {
                      _clearboard();
                      oscore = 0;
                      xscore = 0;
                    },
                    child: Text(
                      "Exit",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
