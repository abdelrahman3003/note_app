import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
Future<String?> uploadImageToFirestorage(
    String imageName, Uint8List file) async {
  try {
    Reference reference = firebaseStorage.ref().child(imageName);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } on Exception catch (e) {
   
    print("error ========= $e");
    return null;
  }
}