import 'dart:io' as io;
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Controller extends GetxController {
  Reference ref = FirebaseStorage.instance.ref().child('pics');
  DatabaseReference database = FirebaseDatabase.instance.ref();
  late UploadTask uploadTask;
  var textFieldText = "".obs;
  var pickedImage = false.obs;
  var imageURL = "".obs;
  var textfield = false.obs;
  var imagefield = false.obs;
  var savebutton = false.obs;
  var dialog = false.obs;
  var notstored = true.obs;

  void updateFirebase(String value, String key) async {
    await database.update({key: value});
  }

  Future<Object?> readImageURLFromFirebase() async {
    final snapshot = await database.child('text').get();
    if (snapshot.exists) {
      textFieldText.value = snapshot.value.toString();
      print(snapshot.value);
      return snapshot.value;
    } else {
      print('No data available.');
      return "No value found";
    }
  }

  Future<Object?> readTextFromFirebase() async {
    final snapshot = await database.child('imageURL').get();
    if (snapshot.exists) {
      imageURL.value = snapshot.value.toString();
      print(snapshot.value);
      return snapshot.value;
    } else {
      print('No data available.');
      return "No value found";
    }
  }

  void checkWidget() {
    if (textfield.value == false && imagefield.value == false) {
      dialog.value = true;
    } else {
      dialog.value = false;
    }
  }

  void sendImage(XFile file) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    uploadTask = ref.putFile(io.File(file.path), metadata);
    notstored.value = false;
    var dowurl = await (await uploadTask).ref.getDownloadURL();
    imageURL.value = dowurl.toString();
    updateFirebase(imageURL.value, "imageURL");
    print(imageURL.value);
  }
}
