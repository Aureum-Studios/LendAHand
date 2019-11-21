class AccountService {

  String email;
  String name;
  String password;

  AccountService({this.email, this.name, this.password});

  void saveAccount() {
    print('Save account in Firebase!');
  }
}