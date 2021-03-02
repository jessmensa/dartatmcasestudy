import 'CashDispenser.dart';
import 'Transaction.dart';
import 'Keypad.dart';
import 'Screen.dart';
import 'BankDatabase.dart';

class Withdrawal extends Transaction {
  int _amount;
  Keypad _keypad;
  CashDispenser _cashDispenser;

  static const int CANCELED = 6;

  Withdrawal(
    int userAccountNumber,
    Screen atmScreen,
    BankDatabase atmBankDatabase,
    Keypad atmKeypad,
    CashDispenser atmCashDispenser,
  )   : _keypad = atmKeypad,
        _cashDispenser = atmCashDispenser,
        super(userAccountNumber, atmScreen, atmBankDatabase);

  int _displayMenyOfAmounts() {
    int userChoice = 0;
    Screen screen = getScreen;
    List<int> amounts = [0, 20, 40, 100, 200];
    while (userChoice == 0) {
      screen.displayMessageLine("\nWithdrawal Menu: ");
      screen.displayMessageLine(r"1 - $20");
      screen.displayMessageLine(r"1 - $40");
      screen.displayMessageLine(r"1 - $60");
      screen.displayMessageLine(r"1 - $100");
      screen.displayMessageLine(r"1 - $200");
      screen.displayMessageLine(r"6 - Cancel transaction");
      screen.displayMessageLine("\nChoose a withdrawal amount: ");

      int input = _keypad.getInput;

      switch (input) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          userChoice = amounts[input];
          break;
        case CANCELED:
          userChoice = CANCELED;
          break;
        default:
          screen.displayMessageLine("\nInvalud Selection. Try again");
      }
    }
    return userChoice;
  }

  @override
  void execute() {
    bool cashDispensed = false;
    double availableBalance;

    BankDatabase bankDatabase = getBankDatabase;
    Screen screen = getScreen;

    do {
      _amount = _displayMenyOfAmounts();

      if (_amount != CANCELED) {
        availableBalance = bankDatabase.getAvailableBalance(getAccountNumber);
        if (_amount <= availableBalance) {
          if (_cashDispenser.isSufficientCashAvailable(_amount)) {
            bankDatabase.debit(getAccountNumber, _amount.toDouble());
            _cashDispenser.dispenseCash(_amount);
            cashDispensed = true;
            screen.displayMessageLine("\nYour cash has been" +
                "dispensed. Please take your cash now");
          } else {
            screen.displayMessageLine(
                "\nInsufficient cash available in the ATM" +
                    "\n\nPlease choose a smaller amount");
          }
        } else {
          screen.displayMessageLine("\nInSufficient funds in your account" +
              "\n\nPlease choose a smaller amount");
        }
      } else {
        screen.displayMessageLine("\nCancelling transaction");
        return;
      }
    } while (!cashDispensed);
  }
}
