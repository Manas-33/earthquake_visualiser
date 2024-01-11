import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSH {
  late String _host;
  late String _port;
  late String _username;
  late String _passwordOrKey;
  late String _numberOfRigs;
  SSHClient? _client;

  Future<void> initConnectionDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('ipAddress') ?? 'default_host';
    _port = prefs.getString('sshPort') ?? '22';
    _username = prefs.getString('username') ?? 'lg';
    _passwordOrKey = prefs.getString('password') ?? 'lg';
    _numberOfRigs = prefs.getString('numberOfRigs') ?? '3';
  }

  // Connect to the Liquid Galaxy system
  Future<bool?> connectToLG() async {
    await initConnectionDetails();

    try {
      _client = SSHClient(await SSHSocket.connect(_host, int.parse(_port)),
          username: _username, onPasswordRequest: () => _passwordOrKey);
      return true;
    } on SocketException catch (e) {
      print('Failed to connect: $e');
      return false;
    }
  }

  Future<SSHSession?> execute() async {
    try {
      if (_client == null) {
        print('SSH client is not initialized.');
        return null;
      }

      final execResult =
          await _client!.execute('echo "search=Lleida" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      print('An error occurred while executing the command: $e');
      return null;
    }
  }

//   TODO 11: Make functions for each of the tasks in the home screen
  Future<SSHSession?> relaunchLG() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      final execResult = await _client!.execute("""RELAUNCH_CMD="\\
          if [ -f /etc/init/lxdm.conf ]; then
            export SERVICE=lxdm
          elif [ -f /etc/init/lightdm.conf ]; then
            export SERVICE=lightdm
          else
            exit 1
          fi
          if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
            echo $_passwordOrKey | sudo -S service \\\${SERVICE} start
          else
            echo $_passwordOrKey | sudo -S service \\\${SERVICE} restart
          fi
          " && sshpass -p $_passwordOrKey ssh -x -t lg@lg1 "\$RELAUNCH_CMD\"""");
      return execResult;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  Future<SSHSession?> shutdownLG() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }

      for (int i = int.parse(_numberOfRigs); i > 0; i--) {
        await _client!.execute(
            'sshpass -p $_passwordOrKey ssh -t lg$i "echo $_passwordOrKey | sudo -S poweroff"');
      }
      return null;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  Future<SSHSession?> rebootLG() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }

      for (int i = int.parse(_numberOfRigs); i > 0; i--) {
        await _client!.execute(
            'sshpass -p $_passwordOrKey ssh -t lg$i "echo $_passwordOrKey | sudo -S reboot"');
      }
      return null;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  Future<SSHSession?> clearKML() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      String kml = '';

      final execResult =
          await _client!.execute("echo '$kml' > /var/www/html/kml/slave_3.kml");
      print(
          "chmod 777 /var/www/html/kmls.txt; echo '$kml' > /var/www/html/kml/slave_3.kml");
      return execResult;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  Future<SSHSession?> sendKML(String kml) async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      double factor = 300 * (6190 / 6854);
      final execResult =
          await _client!.execute("echo '$kml' > /var/www/html/kml/slave_3.kml");
      print(
          "chmod 777 /var/www/html/kmls.txt; echo '$kml' > /var/www/html/kml/slave_3.kml");
      return execResult;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  Future<SSHSession?> searchPlace(String place) async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }

      final execResult =
          await _client!.execute('echo "search=$place" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }
}
