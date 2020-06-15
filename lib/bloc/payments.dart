import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynowbloc/utils/constants.dart';


abstract class PhoneEvent {}


mixin PaymentsValidationMixin {
  bool validatePayment(paymentOptions option , String phoneNumber){
    if ((option==paymentOptions.ecocash) & (phoneNumber.startsWith('071'))){
      return false;
    }
    if ((option==paymentOptions.onemoney) & ((phoneNumber.startsWith('078')) | (phoneNumber.startsWith('077')))){
      return false;
    }

    return true;
  }
}


class PaymentOnSubmit extends PhoneEvent {
  final paymentOptions option;
  final String phoneNumber;
  PaymentOnSubmit (this.option, this.phoneNumber);
}


class PaymentsState {
  final bool isBusy;
  final FieldError emailError;
  final bool submissionSuccess;

  PaymentsState({
    this.isBusy: false,
    this.emailError,
    this.submissionSuccess: false,
  });
}


class PaymentsBloc extends Bloc<PhoneEvent, PaymentsState> with PaymentsValidationMixin {
  PaymentsBloc();

  @override
  PaymentsState get initialState => PaymentsState();

  @override
  Stream<PaymentsState> mapEventToState(PhoneEvent event) async* {
    if (event is PaymentOnSubmit) {
      yield PaymentsState(isBusy: true);


      if (!this.validatePayment(event.option, event.phoneNumber)) {
        yield PaymentsState(emailError: FieldError.Invalid);
        return;
      }

      yield PaymentsState(submissionSuccess: true);
    }
  }
}

