import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:synchronized/synchronized.dart';

void main() async {
  var links = <String>[];
  links.add(
      "https://devby.io/storage/images/12/94/24/17/derived/311f1ec3601470f9c2b61e62259f04bc.jpg");
  links.add(
      "https://devby.io/storage/images/24/71/83/72/derived/05011ec5788e5884ab2f44918dc5067e.jpg");
  links.add(
      "https://devby.io/storage/images/59/19/20/75/derived/6cb99d7cee21de2f68db245ee4a91d6c.jpg");
  links.add(
      "https://devby.io/storage/images/23/59/22/68/derived/271f50bf6a81ebfe2a8fe10fd1734d50.jpg");

  links.add(
      "https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg");
  links.add("https://icatcare.org/app/uploads/2018/07/Elderly-cats.png");
  links.add(
      "https://idsb.tmgrup.com.tr/ly/uploads/images/2022/03/03/187370.jpg");
  links.add(
      "https://www.rd.com/wp-content/uploads/2021/01/GettyImages-675916328-1153806803.jpg");

  var filesSync = <File>[];
  filesSync.add(File("image1Sync.jpg"));
  filesSync.add(File("image2Sync.jpg"));
  filesSync.add(File("image3Sync.jpg"));
  filesSync.add(File("image4Sync.jpg"));

  var filesAsync = <File>[];
  filesAsync.add(File("image1Async.jpg"));
  filesAsync.add(File("image2Async.jpg"));
  filesAsync.add(File("image3Async.jpg"));
  filesAsync.add(File("image4Async.jpg"));

  //synchronized block
  var lock = Lock();

  await lock.synchronized(() async {
    Future.wait({
      http
          .get(Uri.parse(links[4]))
          .then((value) => filesSync.elementAt(0).writeAsBytes(value.bodyBytes))
          .then((value) => print("Downlpaded picture 1")),
      http
          .get(Uri.parse(links[5]))
          .then((value) => filesSync.elementAt(1).writeAsBytes(value.bodyBytes))
          .then((value) => print("Downlpaded picture 2")),
      http
          .get(Uri.parse(links[6]))
          .then((value) => filesSync.elementAt(2).writeAsBytes(value.bodyBytes))
          .then((value) => print("Downlpaded picture 3")),
      http
          .get(Uri.parse(links[7]))
          .then((value) => filesSync.elementAt(3).writeAsBytes(value.bodyBytes))
          .then((value) => print("Downlpaded picture 4")),
    }).then((value) => print("Complete!"));
  });

  print(
      "--------------------------------------------------------------------------------");

  //asynchronous code block
  var client = http.Client();

  for (var i = 0; i < filesAsync.length; i++) {
    http.StreamedResponse response =
        await client.send(http.Request("GET", Uri.parse(links.elementAt(i))));

    var len = response.contentLength;
    var received = 0;
    var sink = filesAsync.elementAt(i).openWrite();

    await response.stream.map((s) {
      received += s.length;
      print("${(received / len!) * 100} %");
      return s;
    }).pipe(sink);

    print("<------------------------------->");
  }
}
