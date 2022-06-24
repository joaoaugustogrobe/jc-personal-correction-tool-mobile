import 'package:correction_tool/features/subject/view/loading.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/exercice.dart';
import '../../../models/subject.dart';
import '../../../models/test.dart';
import '../../../repositories/subject_repository.dart';
import '../bloc/exercice_bloc.dart';

class ExercicePage extends StatelessWidget {
  static Route route({required Exercice exercice}) {
    return MaterialPageRoute<void>(
      builder: (_) => ExercicePage(exercice: exercice),
      fullscreenDialog: true,
      );
  }

  final Exercice exercice;
  ExercicePage({Key? key, required this.exercice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercice.title),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
            create: (context) =>
                ExerciceBloc(subjectRepository: SubjectRepository()
                    // RepositoryProvider.of<SubjectRepository>(context),
                    )
                  ..add(ExercicePageLoad(exercice.id)),
            child: BlocConsumer<ExerciceBloc, ExerciceState>(
              builder: (context, state) {
                switch (state.status) {
                  case SubjectsStatus.empty:
                  // return LoadingState(subject: subject);
                  case SubjectsStatus.fetching:
                  // return LoadingState(subject: subject);
                  case SubjectsStatus.listview:
                    return Row(
                      children: [
                        Card(
                            child: ListTile(
                          title: Text(exercice.title),
                          subtitle: Text(exercice.description),
                        ))
                      ],
                    );
                  case SubjectsStatus.unknown:
                    return const Text('unknown');
                  default:
                    return const Text('default');
                }
              },
              listener: (context, state) {
                print(state.status);
              },
            )),
      )),
    );
  }

  showExerciceDetails(BuildContext context, Exercice exercice) {
    Navigator.push(
      context,
      ExercicePage.route(exercice: exercice),
    );
  }
}
