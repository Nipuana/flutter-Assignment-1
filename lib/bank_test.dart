import 'package:assignment_1/bankLogic.dart';

void main() {
  final bank = Bank();

  // Create accounts
  final saving = SavingsAccount('SAA-011', 'Kanchha', 1000);
  final checking = CheckingAccount('SHA-111', 'Bhunte', 100);
  final premium = PremiumAccount('MRI-122', 'Ankit', 15000);
  final student = StudentAccount('S123', 'bidharthi', 1000);

  bank.createAccount(saving);
  bank.createAccount(checking);
  bank.createAccount(premium);
  bank.createAccount(student); 

  // Perform transactions on savings account
  saving.withdraw(400);
  saving.withdraw(200);
  saving.calculateInterest();

  // Perform transactions on checking account
  checking.withdraw(150);
  checking.deposit(300);

  // Perform transactions on premium account
  premium.withdraw(6000);
  premium.withdraw(4000);
  premium.calculateInterest();

    // Test deposit and withdrawal
  student.deposit(700);  // Will cap deposit
  student.withdraw(600);
  student.deposit(1000); // Should print cap message again

  // Transfer funds between Kanchha and Bhunte
  bank.transfer('SAA-011', 'SHA-111', 300);

  // Generate report of all accounts
  bank.generateReport();
}
