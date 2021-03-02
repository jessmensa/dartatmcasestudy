import 'dart:io';

import 'BalanceInquiry.dart';
import 'Deposit.dart';
import 'Screen.dart';
import 'Keypad.dart';
import 'CashDispenser.dart';
import 'DepositSlot.dart';
import 'BankDatabase.dart';
import 'dart:io';

import 'Transaction.dart';
import 'Withdrawal.dart';

class ATM {
  bool _userAuthenticated;
  int _currentAccountNumber;
  Screen _screen;
  Keypad _keypad;
  CashDispenser _cashDispenser;
  DepositSlot _depositSlot;
  BankDatabase _bankDatabase;

  static const int BALANCE_ENQUIRY = 1;
  static const int WITHDRAWAL = 2;
  static const int DEPOSIT = 3;
  static const int EXIT = 4;

  ATM() {
    _userAuthenticated = false;
    _currentAccountNumber = 0;
    _screen = Screen();
    _keypad = new Keypad();
    _cashDispenser = new CashDispenser();
    _depositSlot = new DepositSlot();
    _bankDatabase = new BankDatabase();
  }

  void _authenticateUser() {
    _screen.displayMessage("\nPlease enter your account number: ");
    int accountNumber = _keypad.getInput;
    _screen.displayMessage("\nEnter your PIN: ");
    int pin = _keypad.getInput;
    _userAuthenticated = _bankDatabase.authenticateUser(accountNumber, pin);
    if (_userAuthenticated) {
      _currentAccountNumber = accountNumber;
    } else {
      _screen.displayMessageLine(
          "Invalid account number or PIN. Please try again");
    }
  }

  int displayMenu() {
    _screen.displayMessageLine("\nMain Menu: ");
    _screen.displayMessageLine("1 - View my balance");
    _screen.displayMessageLine("2 - Withdraw cash");
    _screen.displayMessageLine("3 - Deposit funds");
    _screen.displayMessageLine("4 - Exit\n");
    _screen.displayMessageLine("Enter a choice");
    return _keypad.getInput;
  }

  Transaction _createTransaction(int type) {
    Transaction temp; // variable default value is null
    switch (type) {
      case BALANCE_ENQUIRY:
        temp =
            new BalanceInquiry(_currentAccountNumber, _screen, _bankDatabase);
        break;
      case WITHDRAWAL:
        temp = new Withdrawal(_currentAccountNumber, _screen, _bankDatabase,
            _keypad, _cashDispenser);
        break;
      case DEPOSIT:
        temp = new Deposit(_currentAccountNumber, _screen, _bankDatabase,
            _keypad, _depositSlot);
        break;
    }
    return temp;
  }

  void _performTransaction() {
    Transaction _currentTransaction;
    bool userExited = false;
    while (!userExited) {
      int mainMenuSelection = displayMenu();
      switch (mainMenuSelection) {
        case BALANCE_ENQUIRY:
        case WITHDRAWAL:
        case DEPOSIT:
          _currentTransaction = _createTransaction(mainMenuSelection);
          _currentTransaction.execute();
          break;
        case EXIT:
          _screen.displayMessageLine("\nExiting the System");
          userExited = true;
          break;
        default:
          _screen.displayMessageLine(
              "\nYou did not enter a valid selection. Try again");
          break;
      }
    }
  }

  void run() {
    while (true) {
      while (!_userAuthenticated) {
        _screen.displayMessageLine("\nWelcome!");
        _authenticateUser();
      }
      _performTransaction();
      _userAuthenticated = false;
      _currentAccountNumber = 0;
      _screen.displayMessageLine("Thank You! Good Bye");
    }
  }
}
