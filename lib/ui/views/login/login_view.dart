import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:food_payed/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Entscheide dich mit was du\ndich einloggen möchtest!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GoogleAuthButton(
                text: "Sign in with Google",
                onPressed: () => viewModel.loginWithGoogle(),
                themeMode: ThemeMode.light,
                style: const AuthButtonStyle(
                  buttonType: AuthButtonType.icon,
                  iconSize: 64,
                  width: 100,
                  height: 100,
                  borderRadius: mediumSize,
                ),
              ),
              AppleAuthButton(
                text: "Sign in with Apple",
                onPressed: () => viewModel.loginWithApple(),
                themeMode: ThemeMode.light,
                style: const AuthButtonStyle(
                  buttonType: AuthButtonType.icon,
                  iconSize: 64,
                  width: 100,
                  height: 100,
                  borderRadius: mediumSize,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
