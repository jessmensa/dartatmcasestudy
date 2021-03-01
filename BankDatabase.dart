import 'Account.dart';

class BankDatabase {
  List<Account> _accounts;

  BankDatabase() {
    _accounts = List<Account>();
    _accounts[0] = new Account(12345, 54321, 1000.0, 1200.0);
    _accounts[1] = new Account(98765, 56789, 200.0, 200.0);
  }

  Account _getAccount(int accountNumber) {
    for (Account currentAccount in _accounts) {
      if (currentAccount.getAccountNumber == accountNumber) {
        return currentAccount;
      }
    }
    return null;
  }

  bool authenticateUser(int userAccountNumber, int userPin) {
    Account userAccount = _getAccount(userAccountNumber);
    if (userAccount != null) {
      return userAccount.validatePIN(userPin);
    } else {
      return false;
    }
  }

  double getAvailableBalance(int userAccountNumber) {
    return _getAccount(userAccountNumber).getAvailableBalance;
  }

  double getTotalBalance(int userAccountNumber) {
    return _getAccount(userAccountNumber).getTotalBalance;
  }

  void credit(int userAccountNumber, double amount) {
    _getAccount(userAccountNumber).credit(amount);
  }

  void debit(int userAccountNumber, double amount) {
    _getAccount(userAccountNumber).debit(amount);
  }
}
