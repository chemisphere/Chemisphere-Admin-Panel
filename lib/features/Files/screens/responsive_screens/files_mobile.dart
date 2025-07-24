import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:education_web_admin_panel/features/Files/screens/widgets/Banner_Screen.dart';
import 'package:education_web_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../widgets/Live_Lacture_section.dart';
import '../widgets/Notes_Screen.dart';
import '../widgets/PYQ_Screen.dart';


class FilesMobileScreen extends StatelessWidget {
  const FilesMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
            children:[
              TLiveLactureSection(),
              SizedBox(width:TSizes.sm8),
              TRoundedContainer(child:TNotesScreen()),
              SizedBox(width:TSizes.sm8),
              TRoundedContainer(child:TPYQ_Screen()),
              SizedBox(width:TSizes.sm8),
              TRoundedContainer(child:BannerScreen()),

            ]
        ),
      ),
    );
  }
}
