import 'package:flutter_poc/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  void saveCountry(String country) async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();
    userDefaults.setString('country', country);
  }

  void saveUser(User user) async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();
    userDefaults.setString('firstName', user.name);
    userDefaults.setString('lastName', user.lastName);
    userDefaults.setString('birthdate', user.birthDate);
    userDefaults.setString('phone', user.phone);
    userDefaults.setString('email', user.email);
    userDefaults.setString('country', user.country);
  }

  Future<User> getUser() async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();
    return User(
      name: userDefaults.getString('name'),
      lastName: userDefaults.getString('lastName'),
      birthDate: userDefaults.getString('birthdate'),
      phone: userDefaults.getString('phone'),
      email: userDefaults.getString('email'),
      country: userDefaults.getString('country'),
    );
  }
}
