import 'package:bocconi_radio/widgets/info/bocconi_radio_icons.dart';
import 'package:bocconi_radio/widgets/info/info_title.dart';
import 'package:bocconi_radio/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      height: MediaQuery.of(context).size.height - 116,
      child: ListView(
        children: const[
          InfoTitle(title: "Social"),
          ListTile(
            onTap: SocialRedirects.facebook,
            leading: Icon(BocconiRadio.facebook_squared),
            title: Text("Facebook")
          ),
          ListTile(
            onTap: SocialRedirects.twitter,
            leading: Icon(BocconiRadio.twitter_squared),
            title: Text("Twitter")
          ),
          ListTile(
            onTap: SocialRedirects.youtube,
            leading: Icon(BocconiRadio.youtube),
            title: Text("Youtube")
          ),
          
          Divider(),
          
          InfoTitle(title: "Contatti"), 
          ListTile(
            onTap: SocialRedirects.website,
            leading: Icon(Icons.language_rounded),
            title: Text("radiobocconi.it"),
          ),
          ListTile(
            onTap: SocialRedirects.email,
            leading: Icon(Icons.email_rounded),
            title: Text("radio@radiobocconi.it")
          ),
          ListTile(
            onTap: SocialRedirects.tel,
            leading: Icon(Icons.call_rounded),
            title: Text("+39 0258365005")
          ),
          ListTile(
            onTap: SocialRedirects.maps,
            leading: Icon(Icons.business_rounded),
            title: Text("Via Bocconi, 12 Milano")
          ),
          InfoTitle(title: "Licenze"),
          ListTile(
            title: Text("SIAE n. 1187/I/264")
          ),
          ListTile(
            title: Text("SCF n. 170/08")
          ),
          
          Divider(),
          
          InfoTitle(title: "Tema"), 
          ListTile(
            title: ThemeSwitch(),
          ),
        ],
      )
    );
  }
}


class SocialRedirects {
  static facebook() => _launchUrl('https://facebook.com');
  static twitter() => _launchUrl('https://twitter.com');
  static youtube() => _launchUrl('https://youtube.com');
  static website() => _launchUrl('https://radiobocconi.it');
  static email() => _launchUrl('mailto:radio@radiobocconi.it');
  static maps() => _launchUrl('geo:0,0?q=Via Bocconi, 12 Milano');
  static tel() => _launchUrl('tel:+39 0258365005');

  static void _launchUrl(final String url) async {
    final ok = await canLaunch(url);
    if (ok) {
      await launch(url);
    }
  }
}