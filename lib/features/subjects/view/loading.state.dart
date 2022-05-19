import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/subjects_bloc.dart';

class LoadingState extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoadingState());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: CircularProgressIndicator(),
        ),
        const SizedBox(height: 32),
        BlocBuilder<SubjectsBloc, SubjectsState>(builder: (context, state) {
          return ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            child: const Text('Refresh'),
            onPressed: () => {
              context.read<SubjectsBloc>().add(const SubjectsPageLoad()),
            }
          );
        }),
      ],
    );
    // return const Center(
    //   child: CircularProgressIndicator(),
    // );
  }
}
