import 'package:bocconi_radio/widgets/info_title.dart';
import 'package:bocconi_radio/widgets/theme_switch.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 116,
      child: ListView(
        children: [
          InfoTitle(title: "Social"),                    
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.ac_unit),
            title: const Text("Facebook")
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.ac_unit),
            title: const Text("Twitter")
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.ac_unit),
            title: const Text("Youtube")
          ),
          const Divider(),
          InfoTitle(title: "Contatti"), 
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.language_rounded),
            title: const Text("radiobocconi.it"),
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.email_rounded),
            title: const Text("radio@radiobocconi.it")
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.call_rounded),
            title: const Text("+39 0258365005")
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.business_rounded),
            title: const Text("via Bocconi, 12 Milano")
          ),
          InfoTitle(title: "Licenze"), 
          ListTile(
            onTap: (){},
            title: const Text("SIAE n. 1187/I/264")
          ),
          ListTile(
            onTap: (){},
            title: const Text("SCF n. 170/08")
          ),
          const Divider(),
          InfoTitle(title: "Tema"), 
          ListTile(
            title: Row(
              children: const [
                ThemeSwitch(),
                Text("Dark Mode")
              ],
            ),
          )
        ],
      )
    );
  }
}
