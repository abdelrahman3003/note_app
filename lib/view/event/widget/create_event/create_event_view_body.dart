import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:note_app/controller/event_controller.dart';
import 'package:note_app/core/constatnt/app_color.dart';
import 'package:note_app/core/constatnt/validation.dart';
import 'package:note_app/core/shared/app_button.dart';

class CreateEventViewBody extends StatelessWidget {
  const CreateEventViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: GetBuilder<CeateEventControllerImp>(builder: (controller) {
          return Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.textEditingTitleController,
                  decoration: InputDecoration(
                    hintText: "Type title",
                    fillColor: AppColor.third,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.third, width: 1.3.h),
                        borderRadius: BorderRadius.circular(25)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.third, width: 1.3.h),
                        borderRadius: BorderRadius.circular(250)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.third, width: 1.3.h),
                        borderRadius: BorderRadius.circular(250)),
                  ),
                  validator: (val) {
                    return validation(type: "Username", val: val!);
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  "Start Event",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                TextFormField(
                    controller: controller.textEditingSatrtDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Date of start event ",
                      fillColor: AppColor.third,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.third, width: 1.3.h),
                          borderRadius: BorderRadius.circular(25)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.third, width: 1.3.h),
                          borderRadius: BorderRadius.circular(250)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.third, width: 1.3.h),
                          borderRadius: BorderRadius.circular(250)),
                    ),
                    onTap: () {
                      controller.selectStartDate(context);
                    }),
                const SizedBox(height: 12),
                Text(
                  "End Event",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                TextFormField(
                    readOnly: true,
                    controller: controller.textEditingEndDateController,
                    decoration: InputDecoration(
                      hintText: "Date of end event",
                      fillColor: AppColor.third,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.third, width: 1.3.h),
                          borderRadius: BorderRadius.circular(25)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.third, width: 1.3.h),
                          borderRadius: BorderRadius.circular(250)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.third, width: 1.3.h),
                          borderRadius: BorderRadius.circular(250)),
                    ),
                    onTap: () {
                      controller.selectEndDate(context);
                    }),
                const SizedBox(height: 12),
                Text(
                  "Password",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.textEditingPassordController,
                  obscureText: controller.isSecurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: AppColor.third,
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.onSecure();
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.third, width: 1.3.h),
                        borderRadius: BorderRadius.circular(25)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.third, width: 1.3.h),
                        borderRadius: BorderRadius.circular(250)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.third, width: 1.3.h),
                        borderRadius: BorderRadius.circular(250)),
                  ),
                  validator: (val) {
                    return validation(type: "Password", val: val!);
                  },
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "insert image (optional) ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: controller.selectImage,
                    child: Container(
                        height: 177.h,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: AppColor.third,
                            borderRadius: BorderRadius.circular(30)),
                        child: controller.image == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,
                                      size: 45, color: AppColor.secondry),
                                  Icon(Icons.remove,
                                      size: 45, color: AppColor.secondry),
                                ],
                              )
                            : Image.memory(
                                controller.image!,
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                Center(
                  child: SizedBox(
                      height: 180.h,
                      child: Image.asset("assets/images/test1.png")),
                ),
                Center(
                  child: Container(
                      width: 260.w,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.secondry,
                      ),
                      child: AppButton(
                        name: "Create event",
                        textSize: 20,
                        onPressed: () {
                          controller.safeData();
                        },
                      )),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
