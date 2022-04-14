import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum ErrorCode { errorWrongEmailOrPassword, errorInvalidEmail }

class _SignUpPageState extends State<SignUpPage> {
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';
  ErrorCode? errorCode;
  final formEmailKey = GlobalKey<FormState>();
  final formPasswordKey = GlobalKey<FormState>();
  final formPasswordConfirmationKey = GlobalKey<FormState>();

  void formValidateAndSubmit() {
    errorCode = null;
    formValidateAndSave();
    return;

    // try {
    //   if (formValidateAndSave()) {
    //     String userId =
    //         await widget.auth.signInWithEmailAndPassword(_email, _password);
    //     print('Signed in: $userId');
    //     widget.signIn();
    //   }
    // } on PlatformException catch (e) {
    //   if (e.code == "ERROR_WRONG_PASSWORD" || e.code == "ERROR_USER_NOT_FOUND")
    //     errorCode = ErrorCode.error_wrong_email_or_password;
    //   formEmailKey.currentState.validate();
    //   if (e.code == "ERROR_INVALID_EMAIL")
    //     errorCode = ErrorCode.error_invalid_email;
    //   formEmailKey.currentState.validate();
    // }
  }

  bool formValidateAndSave() {
    return formEmailValidateAndSave() && formPasswordValidateAndSave() && formPasswordConfirmationValidateAndSave();
  }

  bool formEmailValidateAndSave() {
    if (formEmailKey.currentState!.validate()) {
      formEmailKey.currentState!.save();
      return true;
    }
    return false;
  }

  void formEmailResetValidation() {
    final form = formEmailKey.currentState!;
    form.reset();
  }

  bool formPasswordValidateAndSave() {
    if (formPasswordKey.currentState!.validate()) {
      formPasswordKey.currentState!.save();
      return true;
    }
    return false;
  }

  bool formPasswordConfirmationValidateAndSave() {
    if (formPasswordConfirmationKey.currentState!.validate()) {
      formPasswordConfirmationKey.currentState!.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: SvgPicture.asset('assets/images/code-skeleton.svg'),
          top: 0,
          right: 10,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //add padding horizontally

            children: [
              Center(
                child: Text('> Bem vindo!',
                    style: Theme.of(context).textTheme.headline4),
              ),
              const SizedBox(height: 20),
              Form(
                key: formEmailKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    final bool hasMatch = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(value!);

                    if (!hasMatch) {
                      return 'Email inválido';
                    }

                    return null;
                  },
                  onSaved: (value){
                    _email = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formPasswordKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _password = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formPasswordConfirmationKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirme sua senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) {

                    if (value != _password) {
                      return 'As senhas não conferem';
                    }

                    if (errorCode == ErrorCode.errorWrongEmailOrPassword) {
                      return 'Email ou senha incorretos';
                    }

                    return null;
                  },
                  onSaved: (value){
                    _passwordConfirmation = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    child: Text('Já possui uma conta? Entrar',
                        style: Theme.of(context).textTheme.bodyText1),
                    onPressed: () => {},
                  ),
                ],
              ),
              //sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => {formValidateAndSubmit()},
                    child: Text('Cadastrar',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          child: SvgPicture.asset('assets/images/code-skeleton.svg'),
          bottom: 20,
          left: 10,
        ),
      ],
    ));
  }
}
