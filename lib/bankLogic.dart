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

abstract class InterestBearing {
  void calculateInterest();
}

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

class SavingsAccount extends BankAccount implements InterestBearing {
  final double _minimumBalance = 500.0;
  final double _interestRate = 0.02;
  final int _withdrawalLimit = 3;
  int _withdrawalsThisMonth = 0;

  SavingsAccount(super._accountNumber, super._accountHolderName, super._balance);

  @override
  void withdraw(double amount) {
    if (_withdrawalsThisMonth >= _withdrawalLimit) {
      print('Withdrawal limit reached for this month.');
      return;
    }
    if (_balance - amount < _minimumBalance) {
      print('Cannot withdraw. Minimum balance requirement of \\ $_minimumBalance not met.');
      return;
    }
    _balance -= amount;
    _withdrawalsThisMonth++;
    print('Withdrew \\$amount. New balance: \\$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \\$amount. New balance: \\$_balance');
  }

  @override
  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance += interest;
    print('Interest of \\$interest added. New balance: \\$_balance');
  }
}

class CheckingAccount extends BankAccount {
  final double _overdraftFee = 35.0;

  CheckingAccount(super._accountNumber, super._accountHolderName, super._balance);

  @override
  void withdraw(double amount) {
    _balance -= amount;
    if (_balance < 0) {
      _balance -= _overdraftFee;
      print('Overdraft! An overdraft fee of \$$_overdraftFee has been applied.');
    }
    print('Withdrew \\$amount. New balance: \\$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \\$amount. New balance: \\$_balance');
  }
}

class PremiumAccount extends BankAccount implements InterestBearing {
  final double _minimumBalance = 10000.0;
  final double _interestRate = 0.05;

  PremiumAccount(super._accountNumber, super._accountHolderName, super._balance);

  @override
  void withdraw(double amount) {
    if (_balance - amount < _minimumBalance) {
      print('Cannot withdraw. Minimum balance requirement of \\ $_minimumBalance not met.');
      return;
    }
    _balance -= amount;
    print('Withdrew \\$amount. New balance: \\$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \\$amount. New balance: \\$_balance');
  }

  @override
  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance += interest;
    print('Interest of \\$interest added. New balance: \\$_balance');
  }
}

class Bank {
  final Map<String, BankAccount> _accounts = {};

  void createAccount(BankAccount account) {
    _accounts[account.accountNumber] = account;
    print('Account created: ${account.accountNumber}');
  }

  BankAccount? findAccount(String accountNumber) {
    return _accounts[accountNumber];
  }

  void transfer(String fromAccountNumber, String toAccountNumber, double amount) {
    BankAccount? fromAccount = findAccount(fromAccountNumber);
    BankAccount? toAccount = findAccount(toAccountNumber);

    if (fromAccount == null || toAccount == null) {
      print('One or both accounts not found.');
      return;
    }

    fromAccount.withdraw(amount);
    toAccount.deposit(amount);
    print('Transferred \\$amount from $fromAccountNumber to $toAccountNumber');
  }

  void generateReport() {
    print('Bank Accounts Report:');
    _accounts.forEach((accountNumber, account) {
      print("--------------------------");
      account.displayAccountInfo(accountNumber);
    });
  }
}
