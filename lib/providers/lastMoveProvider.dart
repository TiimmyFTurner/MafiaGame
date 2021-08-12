import 'package:flutter/foundation.dart';
import 'package:mafia/data/lastMoves.dart';
import 'package:mafia/models/lastMove.dart';

class LastMoveProvider extends ChangeNotifier {
  List<LastMove> _cards = [];
  newGame() {
    _cards = List.of(LastMoves.moves);
    _cards.shuffle();
  }
  LastMove pickCard(){
    final card = _cards.last;
    _cards.removeLast();
    return card;
  }
}
