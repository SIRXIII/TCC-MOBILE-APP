// models/account_type_model.dart
class AccountType {
  final String title;
  final String description;
  final String icon;
  final AccountTypeEnum type;

  AccountType({
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
  });
}

enum AccountTypeEnum { traveler, rider }