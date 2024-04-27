import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_breakdownTypes_listTile.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../navigation/bottom_navBar.dart';
import '../vehicles/venicles_screen.dart';

class ElectricalIssuesSelectionScreen extends StatefulWidget {
  @override
  State<ElectricalIssuesSelectionScreen> createState() =>
      _ElectricalIssuesSelectionScreenState();
}

class _ElectricalIssuesSelectionScreenState
    extends State<ElectricalIssuesSelectionScreen> {
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
              Text(apkElectricalIssuesTitle,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: apkDefaultSize - 28),
              Text(apkIssueSelectionSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: apkDefaultSize - 10),
              CustomBreakdownTypeListTile(
                title: 'Charging System Issue',
                subtitle: apkElectricalIssuesTitle,
                trailingIcon: Icons.navigate_next_rounded,
                onTap: () {},
              ),
              const SizedBox(height: apkDefaultSize - 15),
              CustomBreakdownTypeListTile(
                title: 'Check Engine',
                subtitle: apkElectricalIssuesTitle,
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
                title: 'Master warning',
                subtitle: apkElectricalIssuesTitle,
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
                title: 'Electronic Stability Problem (ESP)',
                subtitle: apkElectricalIssuesTitle,
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
