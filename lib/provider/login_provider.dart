import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/auth_services.dart';
import 'package:logger/logger.dart';

class LoginProvider extends ChangeNotifier {
  //-------email text controller
  final _emailController = TextEditingController();

  //-------password text controller
  final _passwordController = TextEditingController();

  //---------loader state
  bool _isLoading = false;

  //----getter for email controller
  TextEditingController get emailController => _emailController;

  //----getter for password controller
  TextEditingController get passwordController => _passwordController;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //---------start signup process
  Future<void> startLogin(BuildContext context) async {
    try {
        //start the loader
        setLoading(true);

        // Logger().i("Validation success");
        await AuthenticationService().signinUser(
          context,
          _emailController.text,
          _passwordController.text,
        );

        //clear text field
        _emailController.clear();
        _passwordController.clear();

        //stop the loader
        setLoading(false);
    } catch (e) {
      setLoading(false);
      Logger().e(e);
      AnimatedSnackBar.material(
        "Cannot login due to an error",
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }
}