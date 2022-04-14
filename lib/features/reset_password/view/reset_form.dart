import 'package:correction_tool/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../reset_password.dart';

class ResetForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Reset password email sent')),
            );
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _ResetPasswordButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('resetForm_emailInput_textField'),
          onChanged: (email) => context
              .read<ResetPasswordBloc>()
              .add(ResetPasswordEmailChanged(email)),
          decoration: InputDecoration(
            errorText: state.email.invalid ? 'Invalid email' : null,
            labelText: 'Email',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('resetForm_continue_raisedButton'),
                child: const Text('Change Password'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<ResetPasswordBloc>()
                            .add(const ResetPasswordSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
            key: const Key('resetForm_resePassword_textButton'),
            child: const Text('Go back to Login'),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationForgotPasswordBackToLoginRequested());
            });
      },
    );
  }
}
