import 'package:budget_app_starting/components.dart';
import 'package:budget_app_starting/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart';

class LoginViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailField = useTextEditingController();
    TextEditingController _passwordField = useTextEditingController();

    final viewModelProvider = ref.watch(viewModel);
    final double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: deviceHeight / 5.5),
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                width: 210.0,
              ),
              SizedBox(height: 30.0),
              SizedBox(
                width: 350.0,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: _emailField,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 30.0,
                    ),
                    hintText: "Email",
                    hintStyle: GoogleFonts.openSans(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // PASSWORD
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textAlign: TextAlign.center,
                  controller: _passwordField,
                  obscureText: viewModelProvider.isObscure,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {
                        viewModelProvider.toogleObscure();
                      },
                      icon: Icon(
                        viewModelProvider.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                    hintText: "Password",
                    hintStyle: GoogleFonts.openSans(),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // REGISTER BUTTON
                  SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: MaterialButton(
                      child: OpenSans(
                        text: "Register",
                        size: 25.0,
                        color: Colors.white,
                      ),
                      splashColor: Colors.grey,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        await viewModelProvider.createUserWithEmailAndPassword(
                          context,
                          _emailField.text,
                          _passwordField.text,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    "Or",
                    style: GoogleFonts.pacifico(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(width: 20.0),

                  // LOGIN BUTTON
                  SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: MaterialButton(
                      child: OpenSans(
                        text: "Login",
                        size: 25.0,
                        color: Colors.white,
                      ),
                      splashColor: Colors.grey,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        await viewModelProvider.signInWithEmailAndPassword(
                          context,
                          _emailField.text,
                          _passwordField.text,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),

              /// GOOGLE SIGN IN
              SignInButton(
                buttonType: ButtonType.google,
                btnColor: Colors.black,
                btnTextColor: Colors.white,
                buttonSize: ButtonSize.medium,
                onPressed: () async {
                  if (kIsWeb) {
                    await viewModelProvider.signInWithGoogleWeb(context);
                  } else {
                    await viewModelProvider.signInWithGoogleMobile(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
