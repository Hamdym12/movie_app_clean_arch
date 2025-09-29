import 'package:fluttertoast/fluttertoast.dart';

showToast({
  String? message,
})async{
  await Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message??'',
      toastLength: Toast.LENGTH_LONG,
      fontSize: 16
  );
}
