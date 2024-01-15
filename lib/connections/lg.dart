import 'dart:io';
import 'package:earthquake_visualiser/models/flyto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssh2/ssh2.dart';

class LGConnection {
  late String _host;
  late String _port;
  late String _username;
  late String _passwordOrKey;
  late String _numberOfRigs;
  SSHClient? _client;

  Future<void> initConnectionDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('ipAddress') ?? '192.168.56.10';
    _port = prefs.getString('sshPort') ?? '22';
    _username = prefs.getString('username') ?? 'lg';
    _passwordOrKey = prefs.getString('password') ?? 'lg';
    _numberOfRigs = prefs.getString('numberOfRigs') ?? '3';
  }

  Future<bool?> connectToLG() async {
    await initConnectionDetails();

    try {
      _client = SSHClient(
          host: _host,
          port: int.parse(_port),
          username: _username,
          passwordOrKey: _passwordOrKey);

      await _client!.connect();
      return true;
    } on SocketException catch (e) {
      print('Failed to connect: $e');
      return false;
    }
  }

  searchPlace(String placeName) async {
    try {
      if (_client == null) {
        print('SSH client is not initialized.');
        return null;
      }
      final execResult =
          await _client?.execute('echo "search=$placeName" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      print('An error occurred while executing the command: $e');
      return null;
    }
  }

  relaunchLG() async {
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

  Future shutdownLG() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      for (var i = int.parse(_numberOfRigs); i >= 1; i--) {
        await _client!.execute(
            'sshpass -p ${_passwordOrKey} ssh -t lg$i "echo ${_passwordOrKey} | sudo -S poweroff"');
      }
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  rebootLG() async {
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

  cleanVisualization() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      // var a = await _client!.execute('> /var/www/html/kmls.txt');
      // return a;
      await _client!.execute("echo '' > /var/www/html/kmls.txt");
      
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future sendToLG(String kml, String projectname, FlyToView ftv) async {
    if (kml.isNotEmpty) {
      return _createLocalFile(kml, projectname, ftv);
    }
    return Future.error('nogeodata');
  }

  _createLocalFile(String kml, String projectname, FlyToView ftv) async {
    String localPath = await _localPath;
    File localFile = File('$localPath/$projectname.kml');
    localFile.writeAsString(kml);
    File localFile2 = File('$localPath/kmls.txt');
    localFile2.writeAsString(kml);
    return _uploadToLG('$localPath/$projectname.kml', projectname, ftv);
  }

  _uploadToLG(String localPath, String projectname, FlyToView ftv) async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      await _client!.connect();
      await _client!.execute('echo "" > /tmp/query.txt');
      await _client!.execute('> /var/www/html/kmls.txt');

      await _client!.connectSFTP();
      await _client!.sftpUpload(
        path: localPath,
        toPath: '/var/www/html',
        callback: (progress) {
          print('Sent $progress');
        },
      );
      await _client!.execute(ftv.getCommand());
      await _client!.execute(
          'echo "http://lg1:81/$projectname.kml" > /var/www/html/kmls.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  buildOrbit(String content) async {
    String localPath = await _localPath;
    File localFile = File('$localPath/Orbit.kml');
    localFile.writeAsString(content);

    String filePath = '$localPath/Orbit.kml';

    try {
      await _client!.connect();
      await _client!.connectSFTP();
      await _client!.sftpUpload(
        path: filePath,
        toPath: '/var/www/html',
        callback: (progress) {
          print('Sent $progress');
        },
      );
      return await _client!.execute(
          "echo '\nhttp://lg1:81/Orbit.kml' >> /var/www/html/kmls.txt");
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  startOrbit() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      await _client!.connect();
      return await _client!.execute('echo "playtour=Orbit" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  stopOrbit() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      await _client!.connect();
      return await _client!.execute('echo "exittour=true" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  cleanOrbit() async {
    try {
      if (_client == null) {
        print("The client is not initialised.");
        return null;
      }
      await _client!.connect();
      return await _client!.execute('echo "" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }
}
