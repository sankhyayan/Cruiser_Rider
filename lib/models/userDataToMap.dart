class UserDataToMap {
  String name, email, phone;
  UserDataToMap({required this.name, required this.email, required this.phone});
  static Map<String, dynamic> toMap(UserDataToMap userData) {
    Map<String, dynamic> userMap = Map<String, dynamic>();
    userMap["name"] = userData.name;
    userMap["email"] = userData.email;
    userMap["phone"] = userData.phone;
    return userMap;
  }
}
