class CashDispenser {
  static final int _INITIAL_COUNT = 500;
  int _count;

  CashDispenser() {
    _count = _INITIAL_COUNT;
  }

  void dispenseCash(int amount) {
    int billsRequired = amount ~/ 20;
    _count -= billsRequired;
  }

  bool isSufficientCashAvailable(int amount) {
    int billsRequired = amount ~/ 20;
    if (_count >= billsRequired) {
      return true;
    } else {
      return false;
    }
  }
}
