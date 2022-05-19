import 'package:correction_tool/features/subjects/bloc/subjects_bloc.dart';
import 'package:correction_tool/features/subjects/view/loading.state.dart';
import 'package:correction_tool/repositories/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../../models/subject.dart';
import '../subject/view/subject_page.dart';

class Subjects extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => Subjects(subjectRepository: SubjectRepository()));
  }

  // List<Subject> subjects = SubjectRepository.getSubjects();
  final SubjectRepository subjectRepository;

  Subjects({Key? key, required this.subjectRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
        //logout button
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: RepositoryProvider(
            create: (context) => SubjectRepository(),
            child: BlocProvider(
              create: (context) => SubjectsBloc(
                subjectRepository: subjectRepository,
                // RepositoryProvider.of<SubjectRepository>(context),
              )..add(const SubjectsPageLoad()),
              child: const SubjectsContentWrapper(),
            ),
          ),
        ),
      ),
    );
  }
}

class SubjectsContentWrapper extends StatefulWidget {
  const SubjectsContentWrapper({Key? key}) : super(key: key);

  @override
  State<SubjectsContentWrapper> createState() => _SubjectsContentWrapperState();
}

class _SubjectsContentWrapperState extends State<SubjectsContentWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        switch (state.status) {
          case SubjectsStatus.empty:
            return LoadingState();
          case SubjectsStatus.fetching:
            return LoadingState();
          case SubjectsStatus.listview:
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(RepositoryProvider.of<SubjectRepository>(context).getSubjects()[index].name),
                subtitle: Text(RepositoryProvider.of<SubjectRepository>(context).getSubjects()[index].teacher.name),
                onTap: () {
                  showSubjectDetails(context, RepositoryProvider.of<SubjectRepository>(context).getSubjects()[index]);
                }
              ),
              itemCount: RepositoryProvider.of<SubjectRepository>(context).getSubjects().length
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
    );
  }

  showSubjectDetails(BuildContext context, Subject subject) {
    Navigator.push(
      context,
      SubjectPage.route(subject: subject),
    );
  }
}