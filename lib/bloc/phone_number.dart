import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynowbloc/utils/constants.dart';


enum FieldError { Empty, Invalid }
abstract class PhoneEvent {}


mixin PhoneValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? true;

  bool validateLength(String phoneNumber) {
    if (phoneNumber == null) {
      return false;
    }
    if (phoneNumber.length != 10){
      return false;
    }
    return true;
  }
}


class PhoneOnSubmit extends PhoneEvent {
  final String phoneNumber;

  PhoneOnSubmit(this.phoneNumber);
}


class PhoneState {
  final bool isBusy;
  final FieldError phoneError;
  final bool submissionSuccess;

  PhoneState({
    this.isBusy: false,
    this.phoneError,
    this.submissionSuccess: false,
  });
}


class PhoneBloc extends Bloc<PhoneEvent, PhoneState> with PhoneValidationMixin {
  PhoneBloc();

  @override
  PhoneState get initialState => PhoneState();

  @override
  Stream<PhoneState> mapEventToState(PhoneEvent event) async* {
    if (event is PhoneOnSubmit) {
      yield PhoneState(isBusy: true);

      if (this.isFieldEmpty(event.phoneNumber)) {
        yield PhoneState(phoneError: FieldError.Empty);
        return;
      }

      if (!this.validateLength(event.phoneNumber)) {
        yield PhoneState(phoneError: FieldError.Invalid);
        return;
      }

      yield PhoneState(submissionSuccess: true);
    }
  }
}

