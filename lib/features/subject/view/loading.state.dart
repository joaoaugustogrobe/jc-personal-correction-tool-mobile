import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/subject.dart';
import '../bloc/subject_bloc.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key, required this.subject}) : super(key: key);

  static Route route({required Subject subject}) {
    return MaterialPageRoute<void>(builder: (_) => LoadingState(subject: subject));
  }

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: CircularProgressIndicator(),
        ),
        const SizedBox(height: 32),
        BlocBuilder<SubjectBloc, SubjectState>(builder: (context, state) {
          return ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            child: const Text('Refresh'),
            onPressed: () => {
              context.read<SubjectBloc>().add(SubjectPageLoad(subject.id)),
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
