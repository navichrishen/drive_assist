import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_breakdownTypes_listTile.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../navigation/bottom_navBar.dart';
import '../vehicles/venicles_screen.dart';

class SafetyIssuesSelectionScreen extends StatefulWidget {
  @override
  State<SafetyIssuesSelectionScreen> createState() =>
      _SafetyIssuesSelectionScreenState();
}

class _SafetyIssuesSelectionScreenState
    extends State<SafetyIssuesSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: apkIssueSelectionAppBarTitle,
        onLeadingPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(apkSafetyIssuesTitle,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: apkDefaultSize - 28),
              Text(apkIssueSelectionSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: apkDefaultSize - 10),
              CustomBreakdownTypeListTile(
                title: 'SRS-Airbag Warning',
                subtitle: apkSafetyIssuesTitle,
                trailingIcon: Icons.navigate_next_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyVehiclesScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
