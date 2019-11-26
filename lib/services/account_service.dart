class AccountService {
  String email;
  String name;
  String password;

  AccountService({this.email, this.name, this.password});

  void saveAccount(String email, String name, String password) {
    print(email);
    print(name);
    print(password);

    print('Save account in Firebase!');
  }
}

final accountService = AccountService();
