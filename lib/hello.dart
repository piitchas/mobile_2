import 'dart:io';
import 'dart:math';


void main() {
  print('╔════════════════════════════════════════');
  print('║           GUESS THE NUMBER             ');
  print('╟────────────────────────────────────────');
    stdout.write('║ Enter max number you want to guess : ');
    String? inputRandom = stdin.readLineSync();
    var maxRandom = int.tryParse(inputRandom!);
    Game game = Game(maxRandom!);
  print('╟────────────────────────────────────────');
  var isCorrect = false;
  do {
    stdout.write('║ Guess the number between 1 and $maxRandom: ');
    var input = stdin.readLineSync();
    var guess = int.tryParse(input!);

    if (guess != null) {
      Map resultMap = game.doGuess(guess);
      isCorrect = resultMap['isCorrect'];
      var message = resultMap['text'];
      print('║ ➜ $guess : $message');
      print('╟────────────────────────────────────────');
    }
  } while (!isCorrect);
  var total = game.getTotalGuesses();
  print('║ Total guess: $total');
  print('╟────────────────────────────────────────');
  print('║                THE END                  ');
  print('╚════════════════════════════════════════');

}

class Game{
  late int answer;
  int count =0;
  static const List feedbackList = [
    {
      'text': 'TOO HIGH! ▲',
      'isCorrect': false,
    },
    {
      'text': 'TOO LOW! ▼',
      'isCorrect': false,
    },
    {
      'text': 'CORRECT! ❤',
      'isCorrect': true,
    },
  ];

  Game(int max) {
    this.answer = Random().nextInt(max)+1;

  }

  Map doGuess(int num) {
    count++;
    if (num > this.answer) {
      return feedbackList[0];
    } else if (num < this.answer) {
      return feedbackList[1];
    } else {
      return feedbackList[2];
    }
  }
  getTotalGuesses(){
    return count;
  }

}

void _main() {
  const MAX_RANDOM = 100;
  var r = Random();
  var answer = r.nextInt(MAX_RANDOM) + 1;
  var guess;
  var count = 0;
  print('╔════════════════════════════════════════');
  print('║           GUESS THE NUMBER             ');
  print('╟────────────────────────────────────────');
  do {
    stdout.write('║ Guess the number between 1 and $MAX_RANDOM: ');
    String? input = stdin.readLineSync();
    if (input == null) return;
    guess = int.tryParse(input);
      count++;
    if (guess == null) continue;
      if (answer == guess) {
        print('║ ➜ $guess is CORRECT ❤, total guesses: $count');
        print('╟────────────────────────────────────────');
      }
      else if (answer < guess) {
        print('║ ➜ $guess is TOO HIGH ▲ ');
        print('╟────────────────────────────────────────');
      } else {
        print('║ ➜ $guess is TOO LOW ▼');
        print('╟────────────────────────────────────────');
      }

  } while(guess != answer);
  print('║                THE END                  ');
  print('╚════════════════════════════════════════');
}
