import 'package:correction_tool/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../reset_password.dart';

class ResetPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ResetPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _SVGCodeTop(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: BlocProvider(
                create: (context) {
                  return ResetPasswordBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  );
                },
                child: ResetForm(),
              ),
            ),
            _SVGCodeBottom()
          ],
        ),
      ),
    );
  }
}

class _SVGCodeTop extends StatelessWidget {
  const _SVGCodeTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: SvgPicture.asset('assets/images/code-skeleton.svg'),
      top: 0,
      right: 10,
    );
  }
}

class _SVGCodeBottom extends StatelessWidget {
  const _SVGCodeBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: SvgPicture.asset('assets/images/code-skeleton.svg'),
      bottom: 0,
      left: 10,
    );
  }
}
