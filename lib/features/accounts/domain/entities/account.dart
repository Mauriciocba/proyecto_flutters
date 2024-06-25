final class Account {
  final int accountId;
  final String mail;
  final String? name;
  final String? image;
  final String? companyName;

  Account({
    required this.accountId,
    required this.mail,
    this.name,
    this.image,
    this.companyName,
  });
}
