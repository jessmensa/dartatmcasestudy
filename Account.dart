class Account {
  // Instance Variables
  int _accountNumber;
  int _pin;
  double _availableBalance;
  double _totalBalance;
  // constructor
  Account(int theAccountNumber, int thePIN, double theAvailableBalance,
      double theTotalBalance) {
    this._accountNumber = theAccountNumber;
    this._pin = thePIN;
    this._availableBalance = theAvailableBalance;
    this._totalBalance = theTotalBalance;
  }
  // authenticate account based on userPIN.
  bool validatePIN(int userPIN) {
    if (userPIN == _pin) {
      return true;
    } else {
      return false;
    }
  }

  // returns available balance
  double get getAvailableBalance => _availableBalance;
  // show user total balance when requested
  double get getTotalBalance => _totalBalance;
  // credit an amount to the user account
  void credit(double amount) => _totalBalance += amount;
  // debit amount from the user account
  void debit(double amount) {
    _availableBalance -= amount;
    _totalBalance -= amount;
  }

  // returns account number
  int get getAccountNumber => _accountNumber;
}
