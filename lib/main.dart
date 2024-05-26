import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:telo/constants.dart';
import 'package:telo/home/home_screen.dart';
import 'package:telo/registration/authentication/auth_cubit.dart';
import 'package:telo/registration/authentication/auth_repository.dart';
import 'package:telo/registration/authentication/auth_state.dart';
import 'package:telo/registration/authentication/authenticating_screen.dart';
import 'package:telo/registration/sign_up/signup_cubit.dart';
import 'package:telo/registration/sign_up/signup_screen.dart';

final AuthRepository authRepository = AuthRepository();
final storage = FlutterSecureStorage();
final AuthCubit authCubit =
    AuthCubit(storage: storage, authRepository: authRepository);

void main() async {
  if (authCubit.state is AuthInitial) {
    await authCubit.authenticate();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: BlocBuilder<AuthCubit, AuthSate>(
        builder: ((context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: PRIMARY_SWATCH,
            ),
            home: state is Authenticated ? HomeScreen():state is AuthenticationFailed 
            || state is Authenticating? AuthenticatingScreen():BlocProvider<SignUpCubit>(create: (_)=>SignUpCubit(), child: SignupScreen()),
          );
        }),
      ),
    );
  }
}
