class User {
  final String id;
  final String token;
  final String userName;

  final String email;
  final String phoneNumber;
  final String userType;
  User(
      {this.token,
      this.id,
      this.userName,
      this.email,
      this.phoneNumber,
      this.userType});
}
