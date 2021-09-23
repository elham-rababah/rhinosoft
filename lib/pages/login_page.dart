import 'package:flutter/material.dart';
import 'package:pizaaelk/utils/styles.dart';
import 'package:pizaaelk/widget/request_button_widget.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {


  LoginPage({Key key})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();


  bool _isLoading = false;
  String error = "";
  String userErrorMsg = "";


  void signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .googleSignIn();


    } catch (e) {
      try {
        setState(() {
          _isLoading = false;
          error = e["code"];
          if (error == "ERROR_USER_NOT_FOUND")
            userErrorMsg= "User doesn't exist. Try again.";
          else if (error == "ERROR_WRONG_PASSWORD")
            userErrorMsg = "Password entered is incorrect.";
          else userErrorMsg = error;
        });
      } catch (_) {
        setState(() {
          _isLoading = false;
          error = e.code;


          if (error== "ERROR_USER_NOT_FOUND")
          userErrorMsg= "User doesn't exist. Try again.";
          else if (error == "ERROR_WRONG_PASSWORD")
          userErrorMsg = "Password entered is incorrect.";
          else userErrorMsg = error;


        });
      }

    }
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 0.10),
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height*.2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Log In",
                        style: Styles.titleTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.2,),

                  //TODO Elham# add google icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      AppButtonWidget(label: "Login Via Google",onPressed: signIn,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

