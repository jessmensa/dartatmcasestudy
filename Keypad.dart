import 'dart:io';

// this class is changed and used inside app.
class Keypad {
  Stdin _input;

  Keypad();

  int get getInput => stdin.readByteSync();
}
