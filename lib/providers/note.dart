import 'package:flutter/foundation.dart';

class Note extends ChangeNotifier {
  String note = '';
  void clearNote() => note = '';
}
