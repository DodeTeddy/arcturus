String? validator(String? value) {
  if (value != null && value.isNotEmpty) {
    return null;
  }

  return 'Cannot be empty';
}
