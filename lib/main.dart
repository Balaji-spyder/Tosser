import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text('HEADS OR TAILS',
                style:uiFont,
                )),
          CoinToss(),
        ]),
      )),
    ));
  }
}

class CoinToss extends StatefulWidget {
  const CoinToss({super.key});

  @override
  State<CoinToss> createState() => _CoinTossState();
}

int i = 1;
String dropdownValue = 'Heads';
int fin = 0;
String s = 'Heads';
String last = 'sample';

class _CoinTossState extends State<CoinToss> {
  void playSound() {
    final player = AudioPlayer();
    player.play(AssetSource('call.wav'));
  }

  void act() {
    i = Random().nextInt(100) + 1;
    //print(i);
    if (i % 2 == 0) {
      s = 'Heads';
      if (dropdownValue == 'Heads') {
        fin = 1;
      } else {
        fin = 0;
      }
    } else {
      s = 'Tails';
      if (dropdownValue == 'Tails') {
        fin = 1;
      } else {
        fin = 0;
      }
    }
  }

  void tf() {
    if (fin == 1) {
      last = 'It is ' + s + ' a Correct Guess, You won the Toss.';
    } else {
      last = 'It is ' + s + ' a Wrong Guess, You lose the Toss.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          elevation: 30,
          underline: Container(
            height: 0,
          ),
          dropdownColor: Colors.black87,
          //borderRadius: ,
          items: <String>['Heads', 'Tails']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: uiFont
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
        SizedBox(
          height: 200,
        ),
        TextButton(
            onPressed: () {
              playSound();
              act();
              tf();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Predict()),
              );
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(20)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.orangeAccent),
            ),
            child: const Text(
              'TOSS',
              style:uiFont,
            )),
      ],
    );
  }
}

class Predict extends StatelessWidget {
  const Predict({super.key});
  Image coinImg() {
    if (i % 2 == 0) {
      return Image.asset(
        'images/Heads.png',
        cacheHeight: 200,
        cacheWidth: 200,
      );
    } else {
      return Image.asset(
        'images/Tails.png',
        cacheHeight: 200,
        cacheWidth: 200,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             box,
              coinImg(),
             box,
              Text(
                last,
                style:uiFont
              ),
            ],
          ),
        ),
      ),
    );
  }
}
