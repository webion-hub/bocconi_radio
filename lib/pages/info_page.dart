import 'package:bocconi_radio/widgets/info/bocconi_radio_icons.dart';
import 'package:bocconi_radio/widgets/info/info_title.dart';
import 'package:bocconi_radio/widgets/theme_switch.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 16),
        height: MediaQuery.of(context).size.height - 116,
        child: Column(
          children: [
            Text(
              "Info",
              style: Theme.of(context).textTheme.headline6,
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: const [
                      InfoTitle(title: "Social"),
                      ListTile(
                          onTap: SocialRedirects.facebook,
                          leading: Icon(BocconiRadioIcons.facebook),
                          title: Text("Facebook")),
                      ListTile(
                          onTap: SocialRedirects.twitter,
                          leading: Icon(BocconiRadioIcons.twitter),
                          title: Text("Twitter")),
                      ListTile(
                          onTap: SocialRedirects.youtube,
                          leading: Icon(BocconiRadioIcons.youtube),
                          title: Text("Youtube")),
                      ListTile(
                          onTap: SocialRedirects.instagram,
                          leading: Icon(BocconiRadioIcons.instagram),
                          title: Text("Instagram")),
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
                          title: Text("radio@radiobocconi.it")),
                      ListTile(
                          onTap: SocialRedirects.tel,
                          leading: Icon(Icons.call_rounded),
                          title: Text("+39 0258365005")),
                      ListTile(
                          onTap: SocialRedirects.maps,
                          leading: Icon(Icons.business_rounded),
                          title: Text("Via Bocconi, 12 Milano")),
                      InfoTitle(title: "Licenze"),
                      ListTile(title: Text("SIAE n. 1187/I/264")),
                      ListTile(title: Text("SCF n. 170/08")),
                      Divider(),
                      InfoTitle(title: "Tema"),
                      ThemeSwitch(),
                      Divider(),
                    ] +
                    [
                      ListTile(
                        onTap: () => _showAboutDialog(context),
                        title: const Text("Informazioni sull'app"),
                      )
                    ],
              ),
            )
          ],
        ));
  }

  static void _showAboutDialog(BuildContext context) {
    const promotionMessage =
        'Questa applicazione è stata sviluppata da Webion SRL, software house situata a Modena. Puoi scoprire di più visitando ';

    showAboutDialog(
      context: context,
      applicationIcon: SizedBox(
        height: 64,
        width: 64,
        child: Image.asset('assets/images/logo.png'),
      ),
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2022 Webion SRL',
      children: [
        Container(
            margin: const EdgeInsets.only(top: 16),
            child: RichText(
              text: TextSpan(
              children: [
                const TextSpan(text: promotionMessage),
                TextSpan(
                  text: 'webion.it',
                  style: const TextStyle(
                      decoration: TextDecoration.underline, 
                      color: Colors.blue
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => SocialRedirects._launchUrl('https://webion.it'),
                )
              ],
            )
          )
        )
      ],
    );
  }
}

class SocialRedirects {
  static instagram() => _launchUrl('https://www.instagram.com/radiobocconi/');
  static facebook() => _launchUrl('https://m.facebook.com/radiobocconi');
  static twitter() => _launchUrl('https://twitter.com/radiobocconi');
  static youtube() =>
      _launchUrl('https://www.youtube.com/c/radiobocconiplayitloud');
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
