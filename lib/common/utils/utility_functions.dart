import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (error) {
    debugPrint(error.toString());
  }
  return images;
}

Future<List<Map<dynamic, String>>> pickWebImages() async {
  List<Map<dynamic, String>> images = [];
  try {
    var results = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (results != null && results.files.isNotEmpty) {
      for (var i = 0; i < results.files.length; i++) {
        final fileBytes = results.files[i].bytes;
        final fileName = results.files[i].name;
        images.add(<dynamic, String>{fileBytes: fileName});
      }
    }
  } catch (error) {
    debugPrint(error.toString());
  }
  return images;
}
