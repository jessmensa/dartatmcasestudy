import 'Screen.dart';
import 'BankDatabase.dart';

// why abstract class ??
abstract class Transaction {
  int _accountNumber;
  Screen _screen;
  BankDatabase _bankDatabase;

  Transaction(
      int userAccountNumber, Screen atmScreen, BankDatabase atmBankDatabase) {
    this._accountNumber = userAccountNumber;
    this._screen = atmScreen;
    this._bankDatabase = atmBankDatabase;
  }

  int get getAccountNumber => _accountNumber;

  Screen get getScreen => _screen;

  BankDatabase get getBankDatabase => _bankDatabase;

  void execute();
}
