class AppStrings {
  static final AppStrings _singleton = AppStrings._internal();

  factory AppStrings() {
    return _singleton;
  }

  AppStrings._internal();

  final Map<String, String> _localizedStrings = {
    "app_name": "DevRonins",
    "dashboard": "Dashboard",
    "employees": "Employees",
    "designations": "Designations",
    "departments": "Departments",
    "select_designations": "Select Designations",
    "create_account": "Create Account",
    "submit": "Submit",
    "forgot_password": "Forgot Password?",
    "validation_empty_password": "Enter Password",
    "validation_password_length": "Password should be greater then 6 characters",
    "password": "Password",
    "validation_email": "Enter Valid Email",
    "email": "Email",
    "login": "Login",
    "login_sub_heading": "Hello! Login with your Email",
    "add_employee": "Add Employee",
    "first_name": "First Name",
    "validation_first_name": "Enter First Name",
    "last_name": "Last Name",
    "validation_last_name": "Enter Last Name",
    "cancel": "Cancel",
    "save": "Save",
    "edit": "Edit",
    "delete": "Delete",
    "send": "Send",
    "add_designation": "Add Designation",
    "title": "Title",
    "actions": "Actions",
    "validation_designation": "Enter Designation",
    "please_wait": "Please Wait...",
    "user_not_found": "There is no user associated with this email",
    "wrong-password": "You have entered wrong password",
    "enter_email_for_forgot_password": "Enter your email below to get reset password link",
    "reset_password_link_sent": "We have sent reset password link to given email.",
    "enter_designation_title": "Enter Designation Title",
    "designation": "Designation"
  };

  String translate(String key) {
    return _localizedStrings[key] ?? 'No Key Available';
  }

}
