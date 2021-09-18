
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Game _game;
  final _controller = TextEditingController();
  String? _guessNumber;
  String? _feedback;
  var check = 0;

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('GUSS THE NUMBER',style: TextStyle(
              color: Colors.black),
          )
      ),
      body: Container(
        color: Colors.blueGrey.shade100,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildInputPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_number.png',
          width: 240.0, // 160 = 1 inch
        ),
        Text(
          'GUESS THE NUMBER',
          style: GoogleFonts.kanit(fontSize: 22.0),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    if (_guessNumber == null) {
      return startShow();
    } else {
      return Column(
        children: [
          Text(_guessNumber!,
              style: GoogleFonts.kanit(fontSize: 80.0)
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (check == 1) ?
              Icon(
                Icons.check,
                color: Colors.green,
                size: 40.0,
              ):Icon(
                Icons.clear,
                color: Colors.red,
                size: 40.0,
              ),
              Text(_feedback!,
                  style: GoogleFonts.kanit(fontSize: 40.0)),
            ],
          ),
          if(check == 1)
            TextButton(
                onPressed: (){setState(() {
                  _game = Game();
                  check = 0 ;
                  _guessNumber = null;

                });
                }
                , child: Column(
              children: [
                Text('NEW GAME'),
              ],
            )
            )

        ],

      );
    }
  }

  Widget startShow() {
    return Column(
      children: [
        Text("I'm Thinking of Number"
            , style: GoogleFonts.sarabun(fontSize: 30.0)),
        Text('between 1 to 100.'
            , style: GoogleFonts.sarabun(fontSize: 30.0)),
        Text(''),
        Text('Can you guess it? ♥'
            , style: GoogleFonts.sarabun(fontSize: 30.0))
      ],
    );
  }

  Widget _buildInputPanel() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellowAccent.shade100,
          border: Border.all(width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(5.0,5.0),
              color: Colors.grey,
              spreadRadius: 3,
            )
          ]

      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child:
              (check != 1 ) ?
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 10.0),
                  ),
                ),
              ):
              TextField(
                enabled: false,
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 10.0),
                  ),
                ),
              ),
            ),
            (check != 1 ) ?
            TextButton(
              onPressed: () {
                setState(() {
                  _guessNumber = _controller.text;
                  _controller.clear();
                  int? guess = int.tryParse(_guessNumber!);
                  if (guess != null) {
                    var result = _game.doGuess(guess);
                    if (result == 0) {
                      //ทายถูก
                      check = 1;
                      _feedback = 'CORRECT!!';
                      _showMaterialDialog();
                    } else if (result == 1) {
                      //ทายมากไป
                      _feedback = 'TOO HIGH!';
                    } else {
                      //ทายน้อยไป
                      _feedback = 'TOO LOW!';
                    }
                  }
                });
              },
              child: Text('GUESS'),
            ):TextButton(
              onPressed: null,
              child: Text('GUESS'),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int count = _game.totalGuess;
        String path = _game.topath();
        return AlertDialog(
          title: Text('GOOD JOB! ♥'),
          content: Text('The answer is $_guessNumber\nYou have made $count guesses\n$path'
          ),


          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
