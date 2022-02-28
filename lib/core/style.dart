import '../import.dart';

const pagePadding = EdgeInsets.all(16);

appBar() => AppBar(
      title: appText(appName, clr: Colors.white, isBold: true, size: 24),
      centerTitle: true,
    );

appText(
  String txt, {
  double size = 16,
  Color clr = Colors.black87,
  bool isBold = false,
}) =>
    Text(
      txt,
      style: TextStyle(
        color: clr,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );

appButton(String txt, Function() fun) {
  final ButtonStyle btnStyle = TextButton.styleFrom(
    primary: Colors.white,
    padding: pagePadding,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.blue,
  );

  return TextButton(
    style: btnStyle,
    onPressed: fun,
    child: appText(txt, isBold: true, clr: Colors.white),
  );
}
