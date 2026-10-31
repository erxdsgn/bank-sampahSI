import 'transaction.dart'; 

class HomeData {
  final String userName;
  final String balance;
  final String accountNumber;
  final List<Transaction> transactions; 
  
  HomeData({
    required this.userName,
    required this.balance,
    required this.accountNumber,
    required this.transactions,
  });
}
