

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/Models/addQwidgets.dart';
import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:education_web_admin_panel/features/Test/utils/Utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddNumericalQuestionDesktop extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String section;

  const AddNumericalQuestionDesktop(
      {super.key,
      required this.batchName,
      required this.weekNumber,
      required this.section});

  @override
  State<AddNumericalQuestionDesktop> createState() =>
      _AddNumericalQuestionDesktopState();
}

class _AddNumericalQuestionDesktopState extends State<AddNumericalQuestionDesktop> {
  final ImagePicker picker = ImagePicker();
  bool isUploading=false;
  Uint8List? selectedImage;

  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (kIsWeb) {
      selectedImage = await image!.readAsBytes();
      setState(() {}); // Move setState here
    } else {
      selectedImage = await image!.readAsBytes();
      setState(() {}); // Move setState here
    }
  }

  uploadItem() async {
    if (selectedImage != null && correctoptioncontroller.text.isNotEmpty) {
      setState(() {
        isUploading=true;
      });
      String addID = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("Questions").child(addID);
      final UploadTask task = firebaseStorageRef.putData(selectedImage!);
      var downloadURL = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addQuestion = {
        "Image": downloadURL.toString(),
        "Correct Option": correctoptioncontroller.text,
        "Batch": widget.batchName,
        "Week": widget.weekNumber,
      };

      await DatabaseService()
          .addQuestion(
              addQuestion, widget.batchName, widget.weekNumber, widget.section)
          .then((value) {
        Utils().toastMessage("Question successfully added");
      });

      correctoptioncontroller.clear();
      selectedImage = null;
      setState(() {isUploading=false;});
    }
  }

  TextEditingController correctoptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Add Questions'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              reusableText("Add Question Image", Colors.black),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                          child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: Icon(Icons.camera_alt),
                        ),
                      )),
                    )
                  : GestureDetector(
                      child: Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        child: selectedImage != null
                            ? Image.memory(
                                selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ),
                    )),
              reusableText("Correct Option", Colors.black.withOpacity(0.5)),
              reusableTextfield("correct option", correctoptioncontroller),
              SizedBox(
                height: 30,
              ),
             isUploading
                ? Center(child: CircularProgressIndicator())
                : GestureDetector(onTap: uploadItem, child: Utils().ElevatedButton("Add")),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      
    );
  }
}
