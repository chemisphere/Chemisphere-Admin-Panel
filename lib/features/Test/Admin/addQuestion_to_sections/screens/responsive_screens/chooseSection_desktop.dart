
import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/screens/addNumerical.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/screens/addMCQs.dart';
import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosesectionDesktop extends StatefulWidget {
  final String batchName;
  final String weekNumber;

 ChoosesectionDesktop({required this.batchName, required this.weekNumber});

  @override
  _ChoosesectionDesktopState createState() => _ChoosesectionDesktopState();
}

class _ChoosesectionDesktopState extends State<ChoosesectionDesktop> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Questions to Week ${widget.weekNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Section:'),
            SizedBox(height: 20),
           
            TRoundedContainer(
              height: 50,
              width: double.maxFinite,
              showBorder: true,
              borderColor: Colors.black,
              onTap: (){
               Get.to(()=>AddmcqQuestionPage(batchName: widget.batchName, weekNumber: widget.weekNumber, section: 'MCQquestions'));
              },
              child: const Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Questions to MCQ section "),
                  Icon(Icons.arrow_forward_rounded),
                ],

              ),),
            ), 
            
            SizedBox(height: 20),
           TRoundedContainer(
            height: 50,
            width: double.maxFinite,
            showBorder: true,
            borderColor: Colors.black,
            onTap: () {
               Get.to(()=>AddNumericalQuestionPage(batchName: widget.batchName, weekNumber: widget.weekNumber, section: 'Numericalquestions'));
            },
             child: const Center(child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,              
                children: [
                  Text("Add Questions to Numerical section "),
                  Icon(Icons.arrow_forward_rounded),
                ],
              ),),

           ),
          ],
        ),
      ),
   
    );
  }
}