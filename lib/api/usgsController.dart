import 'dart:convert';
import 'dart:io';
import 'package:earthquake_visualiser/widget/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class USGSController {
  getJSON(String startDate, String endDate, double magnitude) async {
    try {
      Uri urlJson = Uri.parse(
          'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$startDate&endtime=$endDate&minmagnitude=$magnitude');
      final response = await http.get(urlJson);
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return jsonBody;
      } else {
        return 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      return e.toString();
    }
  }

  getKML(String startDate, String endDate, double magnitude) async {
    try {
      Uri url = Uri.parse(
          'https://earthquake.usgs.gov/fdsnws/event/1/query?format=kml&kmlanimated=true&kmlcolorby=depth&starttime=$startDate&endtime=$endDate&minmagnitude=$magnitude');
      final ans = await http.get(url);
      if (ans.statusCode == 200) {
        await saveFileFromApi(ans).then((value) {
          print("success");
          kmlValue = ans.body;
        });

        return ans;
      } else {
        return 'Request failed with status: ${ans.statusCode}';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> saveFileFromApi(Response response) async {
    if (response.statusCode == 200) {
      const fileName = 'file.kml';

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
