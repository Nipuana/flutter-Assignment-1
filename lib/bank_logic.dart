abstract class InterestBearing {
  void calculateInterest();
  double get interestRate;
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

    // Checks if the created object is a interest bearing account
    if (this is InterestBearing) {
      final interestAccount = this as InterestBearing;
      double rate = interestAccount.interestRate;
      double amount = _balance * rate;
      print('Monthly Interest Rate => ${rate * 100}%');
      print('Monthly Interest Amount => \$${amount.toStringAsFixed(2)}');
    }
  }

  String get accountNumber => _accountNumber;

  set accountHolderName(String name) => _accountHolderName = name;
  set balance(double amount) => _balance = amount;
}

class SavingsAccount extends BankAccount implements InterestBearing {
  final double _minimumBalance = 500.0;
  @override
  final double interestRate = 0.02;
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
      print('Cannot withdraw. Minimum balance requirement of $_minimumBalance not met.');
      return;
    }
    _balance -= amount;
    _withdrawalsThisMonth++;
    print('Withdrew \$$amount. New balance: \$$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \$$amount. New balance: \$$_balance');
  }

  @override
  void calculateInterest() {
    double interest = _balance * interestRate;
    _balance += interest;
    print('Interest of \$$interest added. New balance: \$$_balance');
  }
}

class StudentAccount extends BankAccount {
  final double _maxBalance = 5000.0;

  StudentAccount(super._accountNumber, super._accountHolderName, super._balance) {
    if (_balance > _maxBalance) {
      _balance = _maxBalance;
      print('Initial balance capped at \$$_maxBalance for Student Account.');
    }
  }

  @override
  void withdraw(double amount) {
    if (amount > _balance) {
      print('Insufficient funds. Cannot withdraw \$$amount.');
      return;
    }
    _balance -= amount;
    print('Withdrew \$$amount. New balance: \$$_balance');
  }

  @override
  void deposit(double amount) {
    if (_balance + amount > _maxBalance) {
      double allowedAmount = _maxBalance - _balance;
      if (allowedAmount <= 0) {
        print('Deposit denied. Balance already at maximum of \$$_maxBalance.');
        return;
      }
      _balance += allowedAmount;
      print('Deposit capped at \$$allowedAmount to maintain maximum balance of \$$_maxBalance.');
    } else {
      _balance += amount;
      print('Deposited \$$amount. New balance: \$$_balance');
    }
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
    print('Withdrew \$$amount. New balance: \$$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \$$amount. New balance: \$$_balance');
  }
}

class PremiumAccount extends BankAccount implements InterestBearing {
  final double _minimumBalance = 10000.0;
  @override
  final double interestRate = 0.05;

  PremiumAccount(super._accountNumber, super._accountHolderName, super._balance);

  @override
  void withdraw(double amount) {
    if (_balance - amount < _minimumBalance) {
      print('Cannot withdraw. Minimum balance requirement of $_minimumBalance not met.');
      return;
    }
    _balance -= amount;
    print('Withdrew \$$amount. New balance: \$$_balance');
  }

  @override
  void deposit(double amount) {
    _balance += amount;
    print('Deposited \$$amount. New balance: \$$_balance');
  }

  @override
  void calculateInterest() {
    double interest = _balance * interestRate;
    _balance += interest;
    print('Interest of \$$interest added. New balance: \$$_balance');
  }
}

class Bank {
  final Map<String, BankAccount> _accounts = {};

  void createAccount(BankAccount account) {
    _accounts[account.accountNumber] = account;
    print('Account created: ${account.accountNumber}');
  }

  BankAccount? findAccount(String accountNumber) => _accounts[accountNumber];

  void transfer(String fromAccountNumber, String toAccountNumber, double amount) {
    BankAccount? fromAccount = findAccount(fromAccountNumber);
    BankAccount? toAccount = findAccount(toAccountNumber);

    if (fromAccount == null || toAccount == null) {
      print('One or both accounts not found.');
      return;
    }

    fromAccount.withdraw(amount);
    toAccount.deposit(amount);
    print('Transferred \$$amount from $fromAccountNumber to $toAccountNumber');
  }

  void generateReport() {
    print('\n===== Bank Accounts Report =====');
    _accounts.forEach((accountNumber, account) {
      print('--------------------------');
      account.displayAccountInfo(accountNumber);
    });
    print('===============================\n');
  }
}


