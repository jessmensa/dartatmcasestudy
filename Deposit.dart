import 'BankDatabase.dart';
import 'DepositSlot.dart';
import 'Transaction.dart';
import 'Keypad.dart';
import 'Screen.dart';

class Deposit extends Transaction {
  double _amount;
  Keypad _keypad;
  DepositSlot _depositSlot;

  static final int _CANCELED = 0;

  // Constructor
  Deposit(int userAccountNumber, Screen atmScreen, BankDatabase atmBankDatabase,
      Keypad atmKeypad, DepositSlot atmDepositSlot)
      : _keypad = atmKeypad,
        _depositSlot = atmDepositSlot,
        super(userAccountNumber, atmScreen, atmBankDatabase);

  // prompt user to enter deposit amount
  double promptForDepositAmount() {
    Screen screen = getScreen;
    screen.displayMessageLine(
        "\nPlease enter a deposit amount in " + "CENTS(or 0 to cancel)");
    int input = _keypad.getInput;
    if (input == _CANCELED) {
      return _CANCELED.toDouble();
    } else {
      return input.toDouble() / 100;
    }
  }

  @override
  void execute() {
    BankDatabase bankDatabase = getBankDatabase;
    Screen screen = getScreen;
    _amount = promptForDepositAmount();

    if (_amount != _CANCELED) {
      screen.displayMessage("\nPlease insert a deposit envelope containing ");
      screen.displayDollarAmount(_amount);
      screen.displayMessageLine(".");

      bool envelopeRecieved = _depositSlot.isEnvelopedRecieved();

      if (envelopeRecieved) {
        screen.displayMessageLine("Your envelope has been " +
            "recieved\nNOTE: The money just deposited will not " +
            "be available until we verify the amount of any " +
            "enclosed cash and your checks clear");
        bankDatabase.credit(getAccountNumber, _amount);
      } else {
        screen.displayMessageLine("\nYou did not insert an " +
            "envelope, so the ATM has cancelled your transactions");
      }
    } else {
      screen.displayMessageLine("\nCanceling transaction...");
    }
  }
}
