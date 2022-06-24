import 'package:correction_tool/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../localauth.dart';

class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LocalAuthPage(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Log-in with FaceID'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  ElevatedButton(
                      key: const Key('localauth_accept'),
                      child: const Text('Allow FaceID'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () => {
                        context
                          .read<LocalAuthBloc>()
                          .add(const LocalAuthAccepted()),
                        Navigator.pop(context)
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      key: const Key('localauth_refuse'),
                      child: const Text('Use email and password'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () => {
                        context
                          .read<LocalAuthBloc>()
                          .add(const LocalAuthRefused()),
                        Navigator.pop(context)
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
