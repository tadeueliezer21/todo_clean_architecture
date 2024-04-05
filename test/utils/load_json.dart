import 'dart:io';

String getJSON(String name) =>
    File('test/utils/resource/$name.json').readAsStringSync();
