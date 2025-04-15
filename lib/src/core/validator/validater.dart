class MyValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? emalValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? passwrdValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
