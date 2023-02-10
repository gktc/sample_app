import 'package:flutter_application_1/constants.dart';
import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';

class Widgetscreen extends StatelessWidget {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: green,
        body: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Checkbox(
                    value: controller.imagefield.value,
                    onChanged: (value) {
                      // imageChecked = value!;
                      controller.imagefield.value = value!;
                      if (controller.imagefield.value == false) {
                        controller.pickedImage.value = false;
                      }
                      print(value);
                    },
                  ),
                  Text(
                    "Imagefield",
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Checkbox(
                    value: controller.textfield.value,
                    onChanged: (value) {
                      controller.textfield.value = value!;
                      print(value);
                    },
                  ),
                  Text(
                    "Textfield",
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Checkbox(
                    value: controller.savebutton.value,
                    onChanged: (value) {
                      controller.savebutton.value = value!;
                    },
                  ),
                  Text(
                    "Save",
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Get.to(() => Homepage());
                  },
                  child: CustomTextWidget(
                    text: "Import Widget",
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
