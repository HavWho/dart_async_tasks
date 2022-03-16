import 'dart:io';
import 'package:http/http.dart';

void main() async {
  var links = <String>[];
  links.add("https://img04.urban3p.ru/up/o/27312/preview.jpg");
  links.add("https://img04.urban3p.ru/up/o/27768/preview.jpg");
  links.add("https://img04.urban3p.ru/up/o/27519/preview.jpg");
  links.add("https://img04.urban3p.ru/up/o/27983/preview.jpg");

  var files = <File>[];
  files.add(File("image1.jpg"));
  files.add(File("image2.jpg"));
  files.add(File("image3.jpg"));
  files.add(File("image4.jpg"));

  for (var i = 0; i < links.length; i++) {
    Response response = await get(Uri.parse(links.elementAt(i)));
    files.elementAt(i).writeAsBytes(response.bodyBytes);
    if (i == 3) {
      print("Complete!");
    }
  }
}
