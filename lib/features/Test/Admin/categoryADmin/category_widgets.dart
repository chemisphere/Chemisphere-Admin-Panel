
import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';


Widget category(String subject,{double height=200,double width=200}){
  return TRoundedContainer(
    borderColor: Colors.black,
    showBorder: true,
    radius: 10,
    backgroundColor: Colors.white,
    height: height,
    width: width,
    child:SizedBox(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(subject),
          const SizedBox(height: 10,),
          const Icon(Icons.arrow_forward_rounded)
        ],
      ),
    ) ,
  );
}