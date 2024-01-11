import 'package:earthquake_visualiser/api/usgsController.dart';
import 'package:earthquake_visualiser/widget/connection_flag.dart';
import 'package:earthquake_visualiser/widget/constants.dart';
import 'package:earthquake_visualiser/widget/reusable_card.dart';
import 'package:flutter/material.dart';
// TODO 12: Import connections/ssh.dart
import 'package:earthquake_visualiser/connections/ssh.dart';

bool connectionStatus = false;
// TODO 17: Initialize const String searchPlace
const String place = "India";

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  // TODO 13: Initialize SSH instance just like you did in the settings_page.dart, just uncomment the lines below, this time use the same instance for each of the tasks
  late SSH ssh;

  @override
  void initState() {
    super.initState();
    ssh = SSH();
    _connectToLG();
  }

  Future<void> _connectToLG() async {
    bool? result = await ssh.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }

  USGSController usgs = USGSController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LG Connection'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.pushNamed(context, '/settings');
              _connectToLG();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: ConnectionFlag(
                status: connectionStatus,
              )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: Colors.blue,
                    onPress: () async {
                      // TODO 14: Implement relaunchLG() as async task
                      await ssh.relaunchLG();
                    },
                    cardChild: const Center(
                      child: Text(
                        'RELAUNCH LG',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: Colors.blue,
                    onPress: () async {
                      // TODO 15: Implement shutdownLG() as async task
                      await ssh.shutdownLG();
                    },
                    cardChild: const Center(
                      child: Text(
                        'SHUT DOWN LG',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: Colors.blue,
                    onPress: () async {
                      // TODO 16: Implement clearKML() as async task and test
                      await ssh.clearKML();
                    },
                    cardChild: const Center(
                      child: Text(
                        'CLEAN KML',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: Colors.blue,
                    onPress: () async {
                      // TODO 21: Implement rebootLG() as async task and test
                      await ssh.rebootLG();
                    },
                    cardChild: const Center(
                      child: Text(
                        'REBOOT LG',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: Colors.blue,
                    onPress: () async {
                      // TODO 19: Implement searchPlace(String searchPlace) as async task and test
                      await ssh.searchPlace(place);
                    },
                    cardChild: const Center(
                      child: Text(
                        // TODO 18: Add searchPlace variable to the button
                        'SEARCH = $place',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: Colors.blue,
                    onPress: () async {
                      //   TODO 20: Implement sendKML() as async task
                      // await usgs
                      //     .getKML("2023-10-01", "2023-11-01", 2);
                          // .then((value) async {
                        await ssh.sendKML(kmlValue);
                      // }
                      // );
                      // await ssh.sendKML(res);
                    },
                    cardChild: const Center(
                      child: Text(
                        'SEND KML',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
