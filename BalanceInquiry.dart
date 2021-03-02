import 'BankDatabase.dart';
import 'Transaction.dart';
import 'Screen.dart';

class BalanceInquiry extends Transaction {
  BalanceInquiry(
    int userAccountNumber,
    Screen atmScreen,
    BankDatabase atmBankDatabase,
  ) : super(userAccountNumber, atmScreen, atmBankDatabase);

  @override
  void execute() {
    BankDatabase bankDatabase = getBankDatabase;
    Screen screen = getScreen;

    double availableBalance =
        bankDatabase.getAvailableBalance(getAccountNumber);

    double totalBalance = bankDatabase.getTotalBalance(getAccountNumber);

    screen.displayMessageLine("\nBalance Information:");
    screen.displayMessage("- Available Balance: ");
    screen.displayDollarAmount(availableBalance);
    screen.displayMessage("\n - Total Balance:  ");
    screen.displayDollarAmount(totalBalance);
    screen.displayMessageLine("");
  }
}
