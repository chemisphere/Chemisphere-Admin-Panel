
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/user_form.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
          padding:EdgeInsets.all(TSizes.spaceBtwItems16),
         child:Column(
             children:[
             /// NEW USER CREATE FORM HARE
             TCreateUserForm(),
             SizedBox(height:TSizes.sm8),
           ]
         )
      );
  }
}
