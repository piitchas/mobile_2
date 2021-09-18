import 'dart:math';

class Game{
  final int _answer;
  int _totalGuess = 0;
  List<int> gogo = [];

  Game() : _answer = Random().nextInt(100) + 1{
    print ('The answer is $_answer');
  }

  /* getTotalGuess(){
    return _totalGuess; // java style
  }*/
  int get totalGuess {
    return _totalGuess; //Dart Style
  }




  doGuess(int num){
    _totalGuess++;
    gogo.add(num);
    if (num>_answer){
      return 1;
    }else if (num<_answer) {
      return -1;
    }else{
      return 0;
    }
  }
  String topath(){
    String str = "";
    for(int i=0;i<gogo.length;++i){
      str += gogo[i].toString();
      if(i+1 != gogo.length)
        str += " -> ";
    }
    return str;
  }


}