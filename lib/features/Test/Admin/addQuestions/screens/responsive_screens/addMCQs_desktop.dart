import 'dart:io';
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

class AddmcqQuestionDesktop extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String section;

  const AddmcqQuestionDesktop({super.key, required this.batchName, required this.weekNumber,required this.section});

  @override
  State<AddmcqQuestionDesktop> createState() => _AddmcqQuestionDesktopState();
}

class _AddmcqQuestionDesktopState extends State<AddmcqQuestionDesktop> {
  final ImagePicker picker = ImagePicker();
  bool isUploading = false;
  Uint8List? selectedImage;

  Future getImage() async {
   var image = await picker.pickImage(source: ImageSource.gallery);
    if (kIsWeb) {
      selectedImage = await image!.readAsBytes();
    } else {
      selectedImage = File(image!.path).readAsBytesSync();
    }
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null &&
        option1controller.text.isNotEmpty &&
        option2controller.text.isNotEmpty &&
        option3controller.text.isNotEmpty &&
        option3controller.text.isNotEmpty &&
        option4controller.text.isNotEmpty &&
        correctoptioncontroller.text.isNotEmpty) {
      setState(() {
        isUploading = true; // Set isUploading to true
      });    
      String addID = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("Questions").child(addID);
      final UploadTask task = firebaseStorageRef.putData(selectedImage!);
      var downloadURL = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addQuestion = {
        "Image": downloadURL.toString(),
        "Option1": option1controller.text,
        "Option2": option2controller.text,
        "Option3": option3controller.text,
        "Option4": option4controller.text,
        "Correct Option": correctoptioncontroller.text,
        "Batch": widget.batchName,
        "Week": widget.weekNumber,
      };

      await DatabaseService().addQuestion(addQuestion, widget.batchName, widget.weekNumber,widget.section).then((value) {
        Utils().toastMessage("Question successfully added");
      });
       option1controller.clear();
       option2controller.clear();
       option3controller.clear();
       option4controller.clear();
       correctoptioncontroller.clear(); 
    
      selectedImage=null;
      setState(() {
         isUploading = false;
      });
    }
  }

  TextEditingController option1controller = TextEditingController();
  TextEditingController option2controller = TextEditingController();
  TextEditingController option3controller = TextEditingController();
  TextEditingController option4controller = TextEditingController();
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
                      child: Image.memory(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            reusableText("Option 1", Colors.black.withOpacity(0.5)),
            reusableTextfield("Option 1", option1controller),
            reusableText("Option 2", Colors.black.withOpacity(0.5)),
            reusableTextfield("Option 2", option2controller),
            reusableText("Option 3", Colors.black.withOpacity(0.5)),
            reusableTextfield("Option 3", option3controller),
            reusableText("Option 4", Colors.black.withOpacity(0.5)),
            reusableTextfield("Option 4", option4controller),
            reusableText("Correct Option", Colors.black.withOpacity(0.5)),
            reusableTextfield("correct option", correctoptioncontroller),
            SizedBox(height: 30,),
             isUploading
                ? Center(child: CircularProgressIndicator())
                : GestureDetector(onTap: uploadItem, child: Utils().ElevatedButton("Add")),
            SizedBox(height: 30,),
          ],
        ),
      ),
    
    );
  }
}