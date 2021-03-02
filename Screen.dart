import 'dart:io';

class Screen {
  void displayMessage(String message) => stdout.write(message);

  void displayMessageLine(String message) => stdout.writeln(message);

  void displayDollarAmount(double amount) => stdout.write("$amount");
}
