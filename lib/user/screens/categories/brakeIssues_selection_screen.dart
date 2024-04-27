import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_breakdownTypes_listTile.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../navigation/bottom_navBar.dart';
import '../vehicles/venicles_screen.dart';

class BrakeIssuesSelectionScreen extends StatefulWidget {
  @override
  State<BrakeIssuesSelectionScreen> createState() =>
      _BrakeIssuesSelectionScreenState();
}

class _BrakeIssuesSelectionScreenState
    extends State<BrakeIssuesSelectionScreen> {
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
              Text(apkBrakeIssuesTitle,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: apkDefaultSize - 28),
              Text(apkIssueSelectionSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: apkDefaultSize - 10),
              CustomBreakdownTypeListTile(
                title: 'Anti Lock Braking System',
                subtitle: apkBrakeIssuesTitle,
                trailingIcon: Icons.navigate_next_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyVehiclesScreen()),
                  );
                },
              ),
              const SizedBox(height: apkDefaultSize - 15),
              CustomBreakdownTypeListTile(
                title: 'Braking System Issue',
                subtitle: apkBrakeIssuesTitle,
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
