import 'package:flutter_poc/models/user.dart';
import 'package:flutter_poc/repositories/data_encrypter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final encrypter = DataEncrypter();

  void saveCountry(String country) async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();
    userDefaults.setString('country', country);
  }

  void saveData(String firstName, String lastName, String birthDate,
      String phone, String email) async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();
    userDefaults.setString('firstName', encrypter.encrypt(firstName));
    userDefaults.setString('lastName', encrypter.encrypt(lastName));
    userDefaults.setString('birthdate', birthDate);
    userDefaults.setString('phone', encrypter.encrypt(phone));
    userDefaults.setString('email', encrypter.encrypt(email));
  }

  Future<User> getUser() async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();
    return User(
      name: encrypter.decrypt(userDefaults.getString('firstName')),
      lastName: encrypter.decrypt(userDefaults.getString('lastName')),
      birthDate: userDefaults.getString('birthdate'),
      phone: encrypter.decrypt(userDefaults.getString('phone')),
      email: encrypter.decrypt(userDefaults.getString('email')),
      country: userDefaults.getString('country'),
    );
  }
}
