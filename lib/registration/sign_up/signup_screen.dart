import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telo/constants.dart';
import 'package:telo/registration/sign_up/signup_cubit.dart';
import 'package:telo/registration/sign_up/signup_state.dart';

class SignupScreen extends StatelessWidget {
  // const SignupScreen({super.key});
  final formkey = GlobalKey<FormState>();

  late String _email;
  late String _phone;
  late String _name;
  late String _password;
  late String _confirmpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formkey,
              child: BlocConsumer<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        _emailFeild(!(state is SignUpSubmitting),
                            state is SignUpFailed ? state.message : null),
                        SizedBox(
                          height: 28,
                        ),
                        _phoneFeild(!(state is SignUpSubmitting),
                            state is SignUpFailed ? state.message : null),
                        SizedBox(
                          height: 28,
                        ),
                        _nameFeild(!(state is SignUpSubmitting)),
                        SizedBox(
                          height: 28,
                        ),
                        _passwordFeild(!(state is SignUpSubmitting)),
                        SizedBox(
                          height: 28,
                        ),
                        _confirmpasswordFeild(!(state is SignUpSubmitting)),
                        SizedBox(
                          height: 28,
                        ),
                        if (state is SignUpSubmitting)
                          CircularProgressIndicator(),
                        SizedBox(
                          height: 28,
                        ),
                        ElevatedButton(
                            //continue.....
                            onPressed: (state is SignUpSubmitting)
                                ? null
                                : () {
                                    if (formkey.currentState!.validate()) {
                                      BlocProvider.of<SignUpCubit>(context)
                                          .requestotp(_email, _phone);
                                    }
                                  },
                            child: Text("Create Account"))
                      ],
                    );
                  },
                  listener: (context, state) {}),
            ),
          ),
        ),
      ),
    );
  }

  //email address textFeild

  Widget _emailFeild(enableForm, error) {
    return TextFormField(
      enabled: enableForm,
      validator: (value) {
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)) {
          return 'please enter  valid email address!';
        }
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        enabledBorder: ENABLED_BORDER,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_BORDER,
        errorText: error,
        errorStyle: TextStyle(height: 1),
        hintText: "Enter your email address",
        labelText: "Email address",
        suffixIcon: const Icon(Icons.email),
      ),
    );
  }

//phone number textFeild

  Widget _phoneFeild(enableForm, error) {
    return TextFormField(
      maxLength: 10,
      enabled: enableForm,
      validator: (value) {
        if (value!.length != 10) {
          return 'please enter  valid phone number!';
        }
        _phone = value;
      },
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 14,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        enabledBorder: ENABLED_BORDER,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_BORDER,
        errorText: error,
        errorStyle: TextStyle(height: 1),
        hintText: "Enter your phone number",
        labelText: "Phone number",
        suffixIcon: const Icon(Icons.call),
      ),
    );
  }

  //name textFeild

  Widget _nameFeild(enableForm) {
    return TextFormField(
      enabled: enableForm,
      validator: (value) {
        if (value!.length <= 1) {
          return 'please enter  valid email address!';
        }
        _name = value;
      },
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        enabledBorder: ENABLED_BORDER,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_BORDER,
        errorStyle: TextStyle(height: 1),
        hintText: "Enter your  name",
        labelText: "Email name",
        suffixIcon: const Icon(Icons.person),
      ),
    );
  }

  // password textFeild

  Widget _passwordFeild(enableForm) {
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value) {
        if (value!.length < 8) {
          return 'at least 8 character';
        }
        _password = value;
      },
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        enabledBorder: ENABLED_BORDER,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_BORDER,
        errorStyle: TextStyle(height: 1),
        hintText: "Enter password",
        labelText: "Password",
        suffixIcon: const Icon(Icons.lock),
      ),
    );
  }

//confirm password textFeild

  Widget _confirmpasswordFeild(enableForm) {
    return TextFormField(
      enabled: enableForm,
      obscureText: true,
      validator: (value) {
        if (value != _password) {
          return 'password missmatch';
        }
        _confirmpassword = value!;
      },
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        enabledBorder: ENABLED_BORDER,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_BORDER,
        errorStyle: TextStyle(height: 1),
        hintText: "Enter password again",
        labelText: "Confirm password",
        suffixIcon: const Icon(Icons.lock),
      ),
    );
  }
}
