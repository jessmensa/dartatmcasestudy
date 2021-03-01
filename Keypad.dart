import 'dart:io';

class Keypad {
  Stdin _input;

  Keypad(this._input);

  int get getInput => _input.readByteSync();
}
