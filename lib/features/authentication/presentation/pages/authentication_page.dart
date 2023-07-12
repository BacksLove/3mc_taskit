import 'package:flutter/material.dart';
import 'package:taks_3mc/core/constants/images.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';

import 'package:taks_3mc/core/route/routes.dart' as route;

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(180, 242, 239, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            vSpace100,
            Text(localized(context).authWelcomeText,
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge?.copyWith(color: Colors.black)),
            vSpace20,
            Image.asset(authScreenImage),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Color.fromARGB(255, 83, 82, 82),
              ),
              child: Column(
                children: [
                  vSpace30,
                  Text(
                    localized(context).authMessage,
                    textAlign: TextAlign.center,
                  ),
                  vSpace20,
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, route.loginPage);
                    },
                    child: Text(localized(context).signIn),
                  ),
                  vSpace10,
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, route.signupPage);
                    },
                    child: Text(
                      localized(context).signUp,
                    ),
                  ),
                  vSpace100,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
