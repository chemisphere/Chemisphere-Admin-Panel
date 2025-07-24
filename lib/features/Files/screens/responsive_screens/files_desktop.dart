import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:education_web_admin_panel/features/Files/screens/widgets/Banner_Screen.dart';
import 'package:education_web_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../widgets/Live_Lacture_section.dart';
import '../widgets/Notes_Screen.dart';
import '../widgets/PYQ_Screen.dart';

class FilesDesktopScreen extends StatelessWidget {
  const FilesDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SingleChildScrollView(
      child:  Padding(
        padding:  EdgeInsets.all(10),
        child: Column(
          children: [
            /// LIVE LACTURE SECTION
            TLiveLactureSection(),

            SizedBox(height:TSizes.ms12),
             /// FILE UPLOAD SECTION
             Row(
              children:[
                Expanded(child: TRoundedContainer(child:TNotesScreen())),
                SizedBox(width:TSizes.sm8),
                Expanded(child: TRoundedContainer(child:TPYQ_Screen())),
                SizedBox(width:TSizes.sm8),
                Expanded(child: TRoundedContainer(child:BannerScreen())),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

