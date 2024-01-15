import 'package:earthquake_visualiser/screens/information1868.dart';
import 'package:earthquake_visualiser/screens/information1906.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:xml/xml_events.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  static const _colors = [
    Colors.green,
    Colors.blue,
  ];

  static const _durations = [
    4000,
    4000,
  ];

  static const _heightPercentages = [
    -0.05,
    0.0,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: WaveButton(
            colors: _colors,
            durations: _durations,
            heightPercentages: _heightPercentages),
      ),
    );
  }
}

class WaveButton extends StatelessWidget {
  const WaveButton({
    super.key,
    required List<Color> colors,
    required List<int> durations,
    required List<double> heightPercentages,
  })  : _colors = colors,
        _durations = durations,
        _heightPercentages = heightPercentages;

  final List<Color> _colors;
  final List<int> _durations;
  final List<double> _heightPercentages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), border: Border.all()),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height * .8),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bay Area Faults",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "The San Francisco Bay Area is transected by a series of subparallel faults that together accommodate the relative motion between the Pacific and North American plates. The San Andreas Fault and 6 other significant fault zones are present in the Bay Area: the Calaveras, Concord-Green Valley, Greenville, Hayward, Rodgers Creek, and San Gregorio Faults. The faults shown here are represented by simple lines which do not convey how complicated they can be. In reality, active faults can be very complex, consisting of multiple breaks along curved, complex traces. See for yourself by examining the detailed mapping of the Hayward Fault.",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        print("pressend");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoScreen1868()));
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
