import 'package:flutter/material.dart';
import 'package:flui/flui.dart';
import 'package:paynow/paynow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynowbloc/utils/constants.dart';
import 'package:paynowbloc/bloc/bloc_initialiser.dart';


class Payment extends StatefulWidget {
  Payment({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  TextEditingController _amount = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  final bloc = AppBloc();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amount.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}

