import 'package:paynowbloc/bloc/amount.dart';
import 'package:paynowbloc/bloc/email.dart';
import 'package:paynowbloc/bloc/payments.dart';
import 'package:paynowbloc/bloc/phone_number.dart';

class AppBloc {
  AmountBloc _amount;
  EmailBloc _email;
  PaymentsBloc _payments;
  PhoneBloc _phone;

  AppBloc()
      : _amount = AmountBloc(),
        _email = EmailBloc(),
        _payments = PaymentsBloc(),
        _phone = PhoneBloc();

  AmountBloc get amountBloc => _amount;

  EmailBloc get emailBloc => _email;

  PaymentsBloc get paymentsBloc => _payments;

  PhoneBloc get phoneBloc => _phone;
}
