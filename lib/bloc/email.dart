import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynowbloc/utils/constants.dart';


enum FieldError { Empty, Invalid }
abstract class EmailEvent {}


mixin EmailValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? true;

  bool validateEmailAddress(String email) {
    if (email == null) {
      return false;
    }
    return EmailValidator.validate(email);
  }
}


class EmailOnSubmit extends EmailEvent {
  final String email;

  EmailOnSubmit(this.email);
}


class EmailState {
  final bool isBusy;
  final FieldError emailError;
  final bool submissionSuccess;

  EmailState({
    this.isBusy: false,
    this.emailError,
    this.submissionSuccess: false,
  });
}


class EmailBloc extends Bloc<EmailEvent, EmailState> with EmailValidationMixin {
  EmailBloc();

  @override
  EmailState get initialState => EmailState();

  @override
  Stream<EmailState> mapEventToState(EmailEvent event) async* {
    if (event is EmailOnSubmit) {
      yield EmailState(isBusy: true);

      if (this.isFieldEmpty(event.email)) {
        yield EmailState(emailError: FieldError.Empty);
        return;
      }

      if (!this.validateEmailAddress(event.email)) {
        yield EmailState(emailError: FieldError.Invalid);
        return;
      }

      yield EmailState(submissionSuccess: true);
    }
  }
}

