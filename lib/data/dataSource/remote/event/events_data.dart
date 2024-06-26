import 'dart:typed_data';

import 'package:note_app/core/constatnt/crud.dart';
import 'package:note_app/core/constatnt/statuscode.dart';
import 'package:note_app/core/constatnt/upload_image.dart';

class EventsData {
  Crud crud;
  EventsData(this.crud);
  safeData(
      {required String title,
      required String admin,
      required String startDate,
      required String endDate,
      Uint8List? image,
      required List<String> members,
      required String password}) async {
    String? imageUrl;
    if (image != null) {
      imageUrl = await uploadImageToFirestorage("imageName", image);
    }

    return await crud.postData("Events", {
      "title": title,
      "admin": admin,
      "start_date": startDate,
      "end_date": endDate,
      "image": imageUrl,
      "members": members,
      "password": password,
    });
  }

  getData() async {
    var response = await crud.getLast("Events");
    return response.fold((l) => l, (r) => r);
  }

  getDataTaskDetails() async {
    var response = await crud.getLast("Tasks");
    return response.fold((l) => l, (r) => r);
  }

  getUser() async {
    var response = await crud.getLast("Users");
    return response.fold((l) => l, (r) => r);
  }
}
