import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constatnt/app_color.dart';
import 'package:note_app/core/constatnt/handling%20_data.dart';
import 'package:note_app/core/constatnt/routApp.dart';
import 'package:note_app/core/constatnt/services.dart';
import 'package:note_app/core/constatnt/statuscode.dart';
import 'package:note_app/data/dataSource/remote/event/join_event_data.dart';

abstract class JoinEventController extends GetxController {
  changePage();
  securePassword();
  join();
  addUser();
  checkAdmin();
  getMebers();
}

class JoinEventControllerImp extends JoinEventController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isJoined = true;
  bool isScurePassword = true;
  bool test = true;
  JoinEvent joinEvent = JoinEvent(Get.find());
  AppServices appServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController textEditingTitlController = TextEditingController();
  TextEditingController textEditingPasswordController = TextEditingController();
  List<String> members = [];
  StatusRequest statusRequest1 = StatusRequest.none;
  @override
  changePage() {
    isJoined = !isJoined;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  securePassword() {
    isScurePassword = !isScurePassword;
    update();
  }

  @override
  join() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await joinEvent.join(
        title: textEditingTitlController.text,
        password: textEditingPasswordController.text,
      );

      statusRequest = handlingApiData(response);

      if (statusRequest == StatusRequest.success) {
        CollectionReference collectionReference = response;
        QuerySnapshot querySnapshot = await collectionReference
            .where('title', isEqualTo: textEditingTitlController.text)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
      
          if (querySnapshot.docs.first['password'] ==
              textEditingPasswordController.text) {
            Get.offAllNamed(kBottomNavigationScreen,
                arguments: {'title': textEditingTitlController.text});
            appServices.sharedPreferences
                .setString("event", textEditingTitlController.text);
            await checkAdmin();
            await addUser();
            Get.rawSnackbar(
                title: "Sucess",
                backgroundColor: Colors.grey,
                messageText: const Text(
                  "now you is event admin",
                  style: TextStyle(color: AppColor.white),
                ));
          } else {
            statusRequest = StatusRequest.failure;

            Get.defaultDialog(
              title: "error",
              middleText: "incorrect password",
            );
          }
        } else {
          Get.defaultDialog(
            title: "error",
            middleText: "this event is not found",
          );
          statusRequest = StatusRequest.failure;
        }
      } else {
        Get.defaultDialog(
          title: "error",
          middleText: "invalid data",
        );
        update();
      }
      update();
    }
  }

  @override
  addUser() async {
    statusRequest = StatusRequest.loading;
    try {
      // Query for the document with the matching title
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Events')
          .where('title', isEqualTo: textEditingTitlController.text)
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Update the document
        await docRef.update({
          'members': FieldValue.arrayUnion(
              [appServices.sharedPreferences.getString("id")])
        });
      } else {
        print('Document with title "title" not found');
      }
    } catch (e) {
      print('Error adding item to list: $e');
    }
  }

  @override
  checkAdmin() async {
    print("================ check admin");
    try {
      // Query for the document with the matching title
      var user = appServices.sharedPreferences.getString("id");
      print("=================== $user");
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Events')
          .where("admin", isEqualTo: user)
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document
        print("================ admin excute");

        await appServices.sharedPreferences.setBool("admin", true);
      } else {
        print("================ admin excute   false");
        await appServices.sharedPreferences.setBool("admin", false);
      }
      update();
    } catch (e) {
      print('Error adding item to admin email: $e');
    }
  }

  @override
  getMebers() async {
    try {
      // Query for the document with the matching title
      statusRequest1 = StatusRequest.loading;
      update();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Events') // Replace with your collection name
          .where('title',
              isEqualTo: appServices.sharedPreferences.getString("event"))
          .get();
      statusRequest1 = handlingApiData(querySnapshot);
      // Check if the document exists
      if (statusRequest1 == StatusRequest.success) {
        if (querySnapshot.docs.isNotEmpty) {
          // Get the first document from the query result
          DocumentSnapshot docSnapshot = querySnapshot.docs.first;

          // Cast the data to a Map<String, dynamic>
          Map<String, dynamic>? data =
              docSnapshot.data() as Map<String, dynamic>?;

          // Check if the data is not null and contains the list field
          if (data != null && data.containsKey('members')) {
            // Access the value of the list field
            members = List<String>.from(data['members']);
            update();
            return members;
          } else {
            print(
                'List field members not found in document with title members');
            return []; // Return an empty list if list field not found
          }
        } else {
          print('Document with title event not found');
          return []; // Return an empty list if document not found
        }
      }
      update();
    } catch (e) {
      print('Error getting items from list: $e');
      return []; // Return an empty list if there's an error
    }
  }
}
