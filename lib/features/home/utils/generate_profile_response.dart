String userName(String? firstName, String? lastName) {
  return firstName != null || lastName != null ? 'Hello, $firstName $lastName!' : 'Error...';
}
