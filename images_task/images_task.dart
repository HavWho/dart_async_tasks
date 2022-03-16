import 'dart:io';
import 'package:http/http.dart' as http;

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

  var results = await Future.wait([
    http.get(Uri.parse(links[0])).then((value) => files.elementAt(0).writeAsBytes(value.bodyBytes)),
    http.get(Uri.parse(links[1])).then((value) => files.elementAt(1).writeAsBytes(value.bodyBytes)),
    http.get(Uri.parse(links[2])).then((value) => files.elementAt(2).writeAsBytes(value.bodyBytes)),
    http.get(Uri.parse(links[3])).then((value) => files.elementAt(3).writeAsBytes(value.bodyBytes)),
  ]).then((value) => print("Completed!"));
  
}
