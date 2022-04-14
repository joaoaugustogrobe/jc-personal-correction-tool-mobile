import 'package:correction_tool/repositories/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../../models/subject.dart';

class Subjects extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Subjects());
  }

  List<Subject> subjects = SubjectRepository.getSubjects();

  Subjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar with logout button
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
      //list view for each subject
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subjects[index].name),
            subtitle: Text(subjects[index].teacher.name),
            onTap: () => showSubjectDetails(context, subjects[index]),
          );
        },
      ),
    );
  }

  showSubjectDetails(BuildContext context, Subject subject) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute.route(),
    // );
  }
}
