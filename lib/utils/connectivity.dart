import 'dart:io';

connectivityCheck() async {
  //call loading dialog here
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //network is available
    }
  } on SocketException catch (_) {
   //call error dialog
  }
}