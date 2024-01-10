import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class USGSController {
  getResponse() async {
    try {
      Uri url = Uri.parse(
          'https://earthquake.usgs.gov/fdsnws/event/1/query?format=kml&kmlanimated=true&kmlcolorby=depth&starttime=2024-01-01&endtime=2024-01-09&minmagnitude=5');
      final ans = await http.get(url);
      await saveFileFromApi(ans).then((value) => print("success"));
      print(ans.body);
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> saveFileFromApi(Response response) async {
    if (response.statusCode == 200) {
      final fileName = 'file.kml';

      final directory = Directory("/storage/emulated/0/Download");
      final filePath = '${directory.path}/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('File saved to: $filePath');
    } else {
      print('Failed to save file: ${response.statusCode}');
    }
  }
}
