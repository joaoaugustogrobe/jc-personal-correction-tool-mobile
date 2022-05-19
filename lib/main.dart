import 'package:correction_tool/features/subjects/subjects.page.dart';
import 'package:correction_tool/repositories/authentication_repository.dart';
import 'package:correction_tool/repositories/subject_repository.dart';
import 'package:correction_tool/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'features/login/login.dart';
import 'features/reset_password/reset_password.dart';
import 'features/splash/splash.page.dart';

void main() {
  runApp(CorrectionTool());
}

class CorrectionTool extends StatelessWidget {
  const CorrectionTool({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider<SubjectRepository>(
          create: (context) => SubjectRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Correction Tool',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          // fontFamily: 'Monaco',
          // scaffoldBackgroundColor: Colors.black12,
          textTheme: GoogleFonts.sourceCodeProTextTheme(
            ThemeData.light().textTheme,
          )),
      darkTheme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF282A36),
        textTheme: GoogleFonts.sourceCodeProTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          displayColor: const Color(0xFFf8f8f2),
        ),
        /* dark theme settings */
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  Subjects.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.resettingPassword:
                _navigator.pushAndRemoveUntil<void>(
                  ResetPasswordPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
