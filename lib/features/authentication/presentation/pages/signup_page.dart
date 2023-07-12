import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:taks_3mc/core/component/textfield.dart';
import 'package:taks_3mc/core/constants/enums/auth_enum.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';

import 'package:taks_3mc/injection_container.dart' as di;
import 'package:taks_3mc/core/route/routes.dart' as route;
import 'package:taks_3mc/features/authentication/presentation/bloc/authentication_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = di.sl<AuthenticationBloc>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    TextEditingController nameController = TextEditingController();

    return BlocProvider(
      create: (context) => authBloc,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.steps == AuthSteps.codeSent) {
            Navigator.pushNamed(context, route.otpPage,
                arguments: state.userVerificationId);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(localized(context).signUp),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  vSpace100,
                  Text(
                    localized(context).signUp,
                    style: textTheme.headlineLarge,
                  ),
                  vSpace50,
                  Text(localized(context).enterYourName),
                  vSpace10,
                  CustomTextField(controller: nameController),
                  vSpace30,
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
                  vSpace20,
                  ListTile(
                    leading: Checkbox(value: true, onChanged: (value) {}),
                    title: Text(localized(context).acceptTerms),
                  ),
                  vSpace25,
                  ElevatedButton(
                    onPressed: () {
                      authBloc.add(SignUpEvent(name: nameController.text));
                    },
                    child: Text(localized(context).sendOtp),
                  ),
                  vSpace10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(localized(context).haveAnAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, route.loginPage);
                        },
                        child: Text(localized(context).signIn),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
