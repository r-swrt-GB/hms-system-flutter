import 'package:email_validator/email_validator.dart';

String? emailValidator(String? email) {
  return email != null && !EmailValidator.validate(email)
      ? 'Enter a valid email'
      : null;
}

String? passwordValidator(String? password) {
  return password != null && password.length < 6
      ? 'Enter a minimum of 6 characters'
      : null;
}

String? numberValidator(String? number) {
  return number != null && number.length != 10
      ? "Enter a valid phone number"
      : null;
}

String? nameValidator(String? name) {
  return name != null && name.isEmpty ? "Enter your name" : null;
}

String? lastNameValidator(String? lastName) {
  return lastName != null && lastName.isEmpty
      ? "Enter enter your surname"
      : null;
}
