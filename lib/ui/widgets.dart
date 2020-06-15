import 'package:email_validator/email_validator.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:paynowbloc/utils/constants.dart';

String defaultMsg = "";
Color defaultColor = Colors.white;

TextEditingController amount = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phone = TextEditingController();

paymentOptions payment = paymentOptions.ecocash;

Widget amountField() => Padding(
  padding: EdgeInsets.all(5),
  child: TextFormField(
    controller: amount,
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.white),
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter a valid amount';
      }
      if (int.parse(value) <= 0) {
        return 'Invalid Amount';
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: "Amount",
      hintText: '',
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20)),
      //fillColor: Colors.green
    ),
  ),
);


Widget emailField() => Padding(
  padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
  child: TextFormField(
    controller: email,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(color: Colors.white),
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter an email address';
      }
      if (value.length == 0) {
        setState(() {
          defaultMsg = "";
        });
      }
      return null;
    },
    onChanged: (value) {
      if (EmailValidator.validate(value) != true) {
        setState(() {
          defaultMsg = "Email Is Not Valid";
          defaultColor = Colors.white;
        });
      } else if (EmailValidator.validate(value) == true) {
        setState(() {
          defaultMsg = "";
          defaultColor = Colors.white;
        });
      }
    },
    decoration: InputDecoration(
      labelText: "Email",
      hintText: '',
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20)),
      //fillColor: Colors.green
    ),
  ),
);

Widget emailErrorBox() => Container(
  child: Padding(
    padding: EdgeInsets.all(5),
    child: Text(defaultMsg, style: TextStyle(color: defaultColor)),
  ),
);

Widget phoneField() => Padding(
  padding: defaultMsg.length == 0
      ? EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5)
      : EdgeInsets.all(5),
  child: TextFormField(
    controller: phone,
    keyboardType: TextInputType.number,
    maxLength: 10,
    style: TextStyle(color: Colors.white),
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter your phone number';
      }
      if (value.length != 10) {
        return 'Invalid Length';
      }
      if (value.startsWith('07') == false) {
        return 'Invalid Number';
      }
//            if ((value.startsWith('071') == false) |
//                (value.startsWith('077') == false) |
//                (value.startsWith('078') == false)) {
//              return 'Number not supported';
//            }
      return null;
    },
    onChanged: (value) {
      if (value.startsWith('07') == false) {
        debugPrint('invalid number');
      }
    },
    decoration: InputDecoration(
      labelText: "Phone Number",
      hintText: 'eg 0777777777',
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20)),
      //fillColor: Colors.green
    ),
  ),
);

Widget paymentTypes() => Padding(
    padding: EdgeInsets.only(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: <Widget>[
              Radio(
                value: paymentOptions.ecocash,
                groupValue: payment,
                onChanged: (paymentOptions value) {
                  setState(() {
                    payment = value;
                  });
                },
              ),
              Text(
                'EcoCash',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              Radio(
                value: paymentOptions.onemoney,
                groupValue: payment,
                onChanged: (paymentOptions value) {
                  setState(() {
                    payment = value;
                  });
                },
              ),
              Text(
                'OneMoney',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    ));

Widget submitButton() => Padding(
  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
  child: FLFlatButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: Colors.white)),
      padding: EdgeInsets.all(5),
      expanded: true,
      color: Colors.white,
      textColor: appColor,
      child: Text(
        'Process Payment',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onPressed: () {
        verification();
      }),
);

verification() {
 if ((phone.text.startsWith('071')) &
  (payment.toString().split('.').last == 'ecocash')) {
    setState(() {
      verificationErrorMsg =
      "Invalid phone number for payment method selected";
    });
  } else if (((phone.text.startsWith('077')) |
  (phone.text.startsWith('078'))) &
  (payment.toString().split('.').last == 'onemoney')) {
    setState(() {
      verificationErrorMsg =
      "Invalid phone number for payment method selected";
    });
  } else if ((payment.toString().split('.').last == 'onemoney') &
  (double.parse(amount.text) > 5000)) {
    setState(() {
      verificationErrorMsg = "Amount exceeds the \$5000 limit";
    });
  } else if ((payment.toString().split('.').last == 'ecocash') &
  (double.parse(amount.text) > 3000)) {
    setState(() {
      verificationErrorMsg = "Amount exceeds the \$3000 limit";
    });
  } else {
    processPayment();
  }
}