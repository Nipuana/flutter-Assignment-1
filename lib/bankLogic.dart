// Create an abstract base class BankAccount that includes:
// • Private fields for account number, account holder name, and balance
// • Abstract methods for withdraw() and deposit()
// • A method to display account information
// • Proper encapsulation with getters/setters
// // 2. Implement three types of accounts that inherit from BankAccount:


// SavingsAccount:
// • Minimum balance requirement of $500
// • 2% interest calculation method
// • Withdrawal limit of 3 transactions per month
// CheckingAccount:
// • No minimum balance
// • $35 overdraft fee if balance goes below $0
// • No withdrawal limits
// PremiumAccount:
// • Minimum balance of $10,000
// • 5% interest calculation
// • Unlimited free withdrawals
// 3. Create an interface/abstract class InterestBearing for accounts that earn interest
// 4. Implement a Bank class that can:
// • Create new accounts
// • Find accounts by account number
// • Transfer money between accounts
// • Generate reports of all accounts

abstract class BankAccount {
  final String _accountNumber;
  String _accountHolderName;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolderName, this._balance);

  void withdraw(double amount);
  
  void deposit(double amount);
  
  void displayAccountInfo(String accountNumber) {
    print('Account Number => $_accountNumber');
    print('Account Holder Name => $_accountHolderName');
    print('Balance => $_balance');
  }
  String get accountNumber {
    return _accountNumber;
  } 
 
  set accountHolderName(String name) {
    _accountHolderName = name;
  }
  
  set balance(double amount) {
    _balance = amount;
  }
  
}