import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/fetch_user_record.dart';
import '../widgets/user_form.dart';




class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
        body: Padding(
            padding: EdgeInsets.all(TSizes.spaceBtwItems16),
              child: Row(
              children: [
                /// CREATE NEW USER RECORD FROM HARE
                Expanded(child: TRoundedContainer(child:TCreateUserForm())),
                SizedBox(width: TSizes.sm8),
                /// FETCH ALL USER DETAILS FROM THE HARE
                Expanded(child:TRoundedContainer(child: TFetchUserBatchRecord())),

              ],
            )
        )
    );
  }
}


