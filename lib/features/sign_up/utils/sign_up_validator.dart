String? signUpValidator(String? value, String validatorFor) {
  if (value == null || value.isEmpty) {
    return '$validatorFor cannot be empty';
  }
  return null;
}
