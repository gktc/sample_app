import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter_application_1/constants.dart';
import 'widgetscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/controller.dart';

class Homepage extends StatelessWidget {
  final controller = Get.put(Controller());
  XFile? file;
  late TextEditingController _textEditingController = TextEditingController();
  ImagePicker imagepicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = controller.textFieldText.value.toString();

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(
            () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                        child: Text(
                      "Assignment App",
                      style: textStyle,
                    )),
                  ),
                  Container(
                    height: 500,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      children: [
                        controller.dialog.value
                            ? const Center(
                                child: CustomTextWidget(
                                  text: "Add at-least a widget to save.",
                                ),
                              )
                            : Container(),
                        Positioned(
                          top: 40,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 350,
                            height: 30,
                            child: controller.textfield.value
                                ? TextField(
                                    style: textStyle,
                                    controller: _textEditingController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter the text",
                                      hintStyle: textStyle,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Positioned(
                          top: 100,
                          child: controller.imagefield.value
                              ? GestureDetector(
                                  onTap: chooseImage,
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 80),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 10,
                                              color: const Color.fromARGB(
                                                  255, 176, 172, 172)),
                                          color: const Color.fromARGB(
                                              255, 176, 172, 172)),
                                      child: controller.pickedImage.value &&
                                              file != null
                                          ? Image(
                                              image: XFileImage(file!),
                                              fit: BoxFit.cover,
                                            )
                                          : controller.imageURL.value == ""
                                              ? const Icon(
                                                  Icons.image_search,
                                                  size: 150,
                                                )
                                              : Image.network(
                                                  controller.imageURL.value,
                                                  fit: BoxFit.cover,
                                                )),
                                )
                              : Container(),
                        ),
                        controller.savebutton.value
                            ? Positioned(
                                left: 150,
                                bottom: 30,
                                child: ElevatedButton(
                                  style: buttonStyle,
                                  onPressed: () {
                                    controller.checkWidget();
                                    if (controller.pickedImage.value == true) {
                                      if (file != null) {
                                        controller.sendImage(file!);
                                      }
                                    }
                                    controller.notstored.value = true;
                                    if (controller.textfield.value &&
                                        _textEditingController.text != "") {
                                      controller.updateFirebase(
                                          _textEditingController.text, 'text');
                                    }
                                    if (controller.dialog.value == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(succesSnackBar);
                                    }
                                  },
                                  child: const CustomTextWidget(
                                    text: "Save",
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    // color: Colors.red,
                    width: 200,

                    child: Center(
                      child: ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            controller.dialog.value = false;
                            controller.readImageURLFromFirebase();
                            controller.readTextFromFirebase();

                            Get.to(() => Widgetscreen());
                          },
                          child: const CustomTextWidget(
                            text: "Add Widgets",
                          )),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }

  void chooseImage() async {
    controller.pickedImage.value = false;
    file = (await imagepicker.pickImage(source: ImageSource.gallery));
    controller.pickedImage.value = true;
    print("Choose image ${controller.pickedImage.value}");
  }
}
