import 'package:drive_assist/models/detection.dart';
import 'package:flutter/material.dart';
import 'package:drive_assist/constants/sizes.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_text_field.dart';
import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../navigation/bottom_navBar.dart';
import '../navigation/dashboard.dart';
import '../auth/user_registration_screen.dart';

class ScanReportScreen extends StatefulWidget {
  final DetectionResponse response;
  const ScanReportScreen({super.key, required this.response});

  @override
  State<ScanReportScreen> createState() => _ScanReportScreenState();
}

class _ScanReportScreenState extends State<ScanReportScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: apkScannReportAppBarTitle,
          onLeadingPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDashboard()),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(apkDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.22,
                  child: Center(
                    child: Image(
                      image: AssetImage(apkLogo),
                    ),
                  ),
                ),
                Text(apkScannReportTitle,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: apkDefaultSize - 28),
                Text(apkScannReportSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: apkDefaultSize - 10),
                // report container
                Container(
                  height: 600,
                  width: 300,
                  child: ListView.builder(
                    itemCount: widget.response.detections.length,
                    itemBuilder: (context, index) {
                      return ReportContainer(
                          widget.response.detections[index].faultDetails);
                    },
                  ),
                ),
                const SizedBox(height: apkDefaultSize - 20),
                Align(alignment: Alignment.center, child: const Text(apkOrTxt)),
                const SizedBox(height: apkDefaultSize - 20),
                Align(
                    alignment: Alignment.center,
                    child: const Text(
                      apkScannReportUncertainTxt,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: apkDefaultSize - 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          foregroundColor: const Color.fromARGB(255, 0, 29, 61),
                          side: BorderSide(
                            color: const Color.fromARGB(255, 0, 29, 61),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDashboard()),
                          );
                        },
                        child: Text(apkCloseTxt),
                      ),
                    ),
                    // SizedBox(height: apkDefaultSize - 20),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(apkContinueTxt),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReportContainer extends StatelessWidget {
  final Fault faultDetails;
  ReportContainer(this.faultDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 19, 53, 123),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              faultDetails.fault,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Causes',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              faultDetails.causes,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Solution',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              faultDetails.solution,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  final String sampleParagraph =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus vitae urna tincidunt tincidunt eget ut justo. Nulla facilisi. Maecenas non sodales magna, id viverra quam.  ";
}
