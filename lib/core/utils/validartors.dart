class Validators {


  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field cannot be empty";
    }
    return null;
  }
}