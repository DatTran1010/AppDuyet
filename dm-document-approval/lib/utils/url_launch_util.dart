import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class URLLauchUtil {
  static void viewFile(url) async {
    var urllaunchable = await canLaunchUrlString(url);
    if (urllaunchable) {
      await launch(url);
    } else {
      print("URL can't be launched.");
    }
  }
}
