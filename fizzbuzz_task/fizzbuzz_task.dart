import 'dart:io';
//import 'package:path/path.dart' as p - for resolving of path hardcoding;

void fizzBuzz(List<int> fizzBuzzList) {
  var resList = <String>[];
  for (int i = 0; i < fizzBuzzList.length; i++) {
    if (fizzBuzzList.elementAt(i) % 3 == 0 &&
        fizzBuzzList.elementAt(i) % 5 == 0)
      resList.add("FizzBuzz");
    else if (fizzBuzzList.elementAt(i) % 5 == 0)
      resList.add("Buzz");
    else if (fizzBuzzList.elementAt(i) % 3 == 0)
      resList.add("Fizz");
    else
      resList.add(fizzBuzzList.elementAt(i).toString());
  }
  print(resList);
}

Future<String>? readFile() {
  var filePath =
      "C:\\Users\\Sanya\\Desktop\\FlutterDevTraining\\async_in_dart_tasks\\fizzbuzz_task\\numbers_input.txt";
  return File(filePath).readAsString();
}

void main() async {
  var input = await readFile();
  var matches = RegExp(r'\d+').allMatches(input!);
  var numbersList = matches.map<int>((e) => int.parse(e.group(0)!)).toList();
  fizzBuzz(numbersList);
}
