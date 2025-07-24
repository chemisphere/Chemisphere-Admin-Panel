
import 'package:flutter/material.dart';






//Add Questions image and text section
Widget reusableText(String text,Color textcolor){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: textcolor),)
      ],
    ),
  );
}

  
Widget reusableTextfield(String hintText,TextEditingController controller){
  return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.grey.shade300,
            )
          ]),
      child: SizedBox(
          height: 50,
          width: 270,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
           
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              
            ),
          )));
}


