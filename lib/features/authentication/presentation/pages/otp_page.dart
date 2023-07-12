import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:taks_3mc/core/constants/enums/auth_enum.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';

import 'package:taks_3mc/core/route/routes.dart' as route;
import 'package:taks_3mc/core/util/snackbar.dart';
import 'package:taks_3mc/injection_container.dart' as di;
import 'package:taks_3mc/features/authentication/presentation/bloc/authentication_bloc.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.verificationId});

  final String verificationId;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final authBloc = di.sl<AuthenticationBloc>();
    TextEditingController otpController = TextEditingController();

    return BlocProvider(
      create: (context) => authBloc,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
        if (state.errorType == AuthErrorEnum.badCode) {
          showFloatingFlushbar(context, null, localized(context).badCode);
        }
        if (state.steps == AuthSteps.loggedIn) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.homePage, (route) => false);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                vSpace50,
                Text(
                  localized(context).enterOtp,
                  style: textTheme.headlineLarge,
                ),
                vSpace100,
                Text("${localized(context).weSentCode} ${state.phoneNumber}"),
                vSpace10,
                Pinput(
                  controller: otpController,
                  length: 6,
                ),
                vSpace25,
                ElevatedButton(
                  onPressed: () {
                    authBloc.add(VerifyOtpEvent(
                        code: otpController.text,
                        verificationId: verificationId));
                  },
                  child: Text(localized(context).verify),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
