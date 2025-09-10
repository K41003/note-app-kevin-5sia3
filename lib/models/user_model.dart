class UserModel {
  final int? userId;
  final String userName;
  final String userPassword;

  UserModel({
    this.userId,
    required this.userName,
    required this.userPassword,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      userId: json['userId'],
      userName: json['userName'],
      userPassword: json['userPassword'],
    );

  Map<String, dynamic> toMap() {
    if (userId == null) {
      // When creating a new user, don't include userId as it's auto-generated
      return {
        'userName': userName,
        'userPassword': userPassword,
      };
    } else {
      // When updating or querying, include userId
      return {
        'userId': userId,
        'userName': userName,
        'userPassword': userPassword,
      };
    }
  }
}