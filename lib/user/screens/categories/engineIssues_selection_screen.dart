import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_breakdownTypes_listTile.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../navigation/bottom_navBar.dart';
import '../vehicles/venicles_screen.dart';

class EngineIssuesSelectionScreen extends StatefulWidget {
  @override
  State<EngineIssuesSelectionScreen> createState() =>
      _EngineIssuesSelectionScreenState();
}

class _EngineIssuesSelectionScreenState
    extends State<EngineIssuesSelectionScreen> {
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
              Text(apkEngineIssuesTitle,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: apkDefaultSize - 28),
              Text(apkIssueSelectionSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: apkDefaultSize - 10),
              CustomBreakdownTypeListTile(
                title: 'Engine Overheating Warning',
                subtitle: apkEngineIssuesTitle,
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
                title: 'Low Engine Oil Warning',
                subtitle: apkEngineIssuesTitle,
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
