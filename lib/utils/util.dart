

import 'package:url_launcher/url_launcher.dart';

class Utils{

  //common url launcher
  static urlLauncher({required String url})async{
    if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
    }
  }

  //common map launcher
  static launchPhone({required String mobile}){
    urlLauncher(url: 'tel:+91 $mobile');
  }
}