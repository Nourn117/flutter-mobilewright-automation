import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';

class UserModel {
  const UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.isLocked = false,
  });

  final String name;
  final String email;
  final String password;
  final bool isLocked;

  AppUser toEntity() => AppUser(name: name, email: email);
}
