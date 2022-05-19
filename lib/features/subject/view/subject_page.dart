import 'package:correction_tool/features/subject/view/loading.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/exercice.dart';
import '../../../models/subject.dart';
import '../../../repositories/subject_repository.dart';
import '../../exercice/view/exercice_page.dart';
import '../bloc/subject_bloc.dart';

class SubjectPage extends StatelessWidget {
  static Route route({required Subject subject}) {
    return MaterialPageRoute<void>(
        builder: (_) => SubjectPage(subject: subject));
  }

  final Subject subject;
  SubjectPage({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
            create: (context) =>
                SubjectBloc(subjectRepository: SubjectRepository()
                    // RepositoryProvider.of<SubjectRepository>(context),
                    )
                  ..add(SubjectPageLoad('1')),
            child: BlocConsumer<SubjectBloc, SubjectState>(
              builder: (context, state) {
                switch (state.status) {
                  case SubjectsStatus.empty:
                    return LoadingState(subject: subject);
                  case SubjectsStatus.fetching:
                    return LoadingState(subject: subject);
                  case SubjectsStatus.listview:
                    return ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                              title: Text(
                                SubjectRepository().getExercices()[index].title,
                                style: const TextStyle(
                                  color: Color(0xfff1fa8c),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      //badge if due
                                      if (SubjectRepository()
                                          .getExercices()[index]
                                          .isDue)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 6),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child:
                                              SizedBox(height: 12, width: 12),
                                        ),
                                      Text(SubjectRepository()
                                          .getExercices()[index]
                                          .dueOn),
                                    ],
                                  ),
                                  Text(
                                    SubjectRepository()
                                        .getExercices()[index]
                                        .description
                                        .replaceAll(RegExp(r"\n.*"), ''),
                                    style: const TextStyle(
                                        color: Color(0xfff8f8f2)),
                                  ),
                                ],
                              ),
                              onTap: () {
                                showExerciceDetails(context,
                                    SubjectRepository().getExercices()[index]);
                              },
                            ),
                        itemCount: SubjectRepository().getExercices().length);
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
