import '../../../constants/regex.dart';

String? emailValidator(String? value) {
  final regex = RegExp(emailRegexPatern);

  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  } else if (value.isNotEmpty && !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? passwordValidator(String? value) {
  final regex = RegExp(passWordRegexPatern);

  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.isNotEmpty && !regex.hasMatch(value)) {
    return '''
Enter a valid password
Password must be at least 8 characters
Password must contain numbers
Password must contain special character
    ''';
  }
  return null;
}
