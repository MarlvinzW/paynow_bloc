import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynowbloc/utils/constants.dart';


abstract class AmountEvent {}


mixin AmountValidationMixin {
  bool isFieldNegative(double fieldValue) => fieldValue?.isNegative ?? true;

  bool validateAmount(double amount, paymentOptions option) {
    if ((amount < 0) | (amount > 5000)){
      return false;
    }
    if ((option==paymentOptions.ecocash) & (amount > 3000)){
      return false;
    }
    if ((option==paymentOptions.onemoney) & (amount > 5000)){
      return false;
    }
    return true;
  }
}


class AmountOnSubmit extends AmountEvent {
  final double amount;
  final paymentOptions option;
  AmountOnSubmit(this.amount, this.option);
}


class AmountState {
  final bool isBusy;
  final FieldError amountError;
  final bool submissionSuccess;

  AmountState({
    this.isBusy: false,
    this.amountError,
    this.submissionSuccess: false,
  });
}


class AmountBloc extends Bloc<AmountEvent, AmountState> with AmountValidationMixin {
  AmountBloc();

  @override
  AmountState get initialState => AmountState();

  @override
  Stream<AmountState> mapEventToState(AmountEvent event) async* {
    if (event is AmountOnSubmit) {
      yield AmountState(isBusy: true);

      if (this.isFieldNegative(event.amount)) {
        yield AmountState(amountError: FieldError.Invalid);
        return;
      }

      if (!this.validateAmount(event.amount, event.option)) {
        yield AmountState(amountError: FieldError.Invalid);
        return;
      }

      yield AmountState(submissionSuccess: true);
    }
  }
}

