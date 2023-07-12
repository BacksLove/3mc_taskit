import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:taks_3mc/core/constants/enums/auth_enum.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';

import 'package:taks_3mc/core/route/routes.dart' as route;
import 'package:taks_3mc/core/util/snackbar.dart';
import 'package:taks_3mc/injection_container.dart' as di;
import 'package:taks_3mc/features/authentication/presentation/bloc/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final authBloc = di.sl<AuthenticationBloc>();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => authBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localized(context).signIn),
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.errorType == AuthErrorEnum.notRegistered) {
              showFloatingFlushbar(
                  context, null, localized(context).notRegistred);
            }
            if (state.steps == AuthSteps.codeSent) {
              Navigator.pushReplacementNamed(context, route.otpPage,
                  arguments: state.userVerificationId);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    vSpace100,
                    Text(
                      localized(context).pleaseLogIn,
                      style: textTheme.headlineLarge,
                    ),
                    vSpace50,
                    Text(localized(context).enterPhoneNumber),
                    vSpace10,
                    IntlPhoneField(
                      controller: null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        authBloc.add(AddPhoneNumberEvent(
                            phoneNumber: value.completeNumber));
                      },
                    ),
                    vSpace25,
                    if (state.steps == AuthSteps.loading &&
                        state.errorType == AuthErrorEnum.none) ...{
                      const CircularProgressIndicator(),
                    } else ...{
                      ElevatedButton(
                        onPressed: () {
                          authBloc.add(SignInWithPhoneEvent());
                        },
                        child: Text(localized(context).sendOtp),
                      ),
                    },
                    vSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(localized(context).dontHaveAccount),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, route.signupPage);
                          },
                          child: Text(localized(context).signUp),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
