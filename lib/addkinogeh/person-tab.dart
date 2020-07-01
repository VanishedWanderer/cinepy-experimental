import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:helloworld/chips-input/chip-input.dart';


class PersonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChipInput<AppProfile>(
      findSuggestions: (String query) async {
        await Future.delayed(Duration(milliseconds: 500));
        return mockResults.where((element) => element.name.toLowerCase().contains(query.toLowerCase()));
      },
      suggestionBuilder: (context, AppProfile data, ChipsData<AppProfile> chips) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.imageUrl),
          ),
          title: Text(data.name),
          subtitle: Text(data.email),
          onTap: () => chips.add(data),
        );
      },
      chipsBuilder: (context, AppProfile data, ChipsData<AppProfile> chips){
        return Chip(
          avatar: CircleAvatar(
            backgroundImage: NetworkImage(data.imageUrl),
          ),
          label: Text(data.name),
          deleteIcon: Icon(Icons.close),
          onDeleted: () => chips.delete(data),
        );
      },

    );
  }

}


const mockResults = <AppProfile>[
  AppProfile('Stock Man', 'stock@man.com',
      'https://www.maz-online.de/var/storage/images/rnd/nachrichten/politik/inland/warum-zeigt-google-bei-der-suche-nach-idiot-bilder-von-trump/709854586-1-ger-DE/Warum-zeigt-Google-bei-der-Suche-nach-Idiot-Bilder-von-Trump_big_teaser_article.jpg'),
  AppProfile('Paul', 'paul@google.com',
      'https://ekiwi.de/wp-content/uploads/2018/03/grafik_beitrag_1.jpg'),
  AppProfile('Fred', 'fred@google.com',
      'https://www.tierschutzbund.de/fileadmin/_processed_/4/8/csm_Katze-Pfoten_fe2be12322.jpg'),
  AppProfile('Bera', 'bera@flutter.io',
      'https://www.indiewire.com/wp-content/uploads/2019/10/robert-pattinson-lighthouse.jpg'),
  AppProfile('John', 'john@flutter.io',
      'https://lwlies.com/wp-content/uploads/2020/02/the-lighthouse-willem-dafoe-1108x0-c-default.jpg'),
  AppProfile('Thomas', 'thomas@flutter.io',
      'https://avatars0.githubusercontent.com/u/32226737?s=460&u=72c84aa5507251734f1b305d1c47ecb7e9b52852&v=4'),
  AppProfile('Norbert', 'norbert@flutter.io',
      'https://media04.meinbezirk.at/article/2019/12/29/2/22495902_XXL.jpg?1577620630'),
  AppProfile('Marina', 'marina@flutter.io',
      'https://www1.wdr.de/daserste/lindenstrasse/fotos/foto-dressler-ludwig-haas-redet-nein-bruellt-jack-100~_v-gseapremiumxl.jpg'),
  AppProfile('Marinase', 'marina@flutter.io',
      'https://www.leadersnet.at/resources/images/2012/11/19/10717/tips-wettbewerb-mit-teilnehmerrekord.jpg'),
];

class AppProfile {
  final String name;
  final String email;
  final String imageUrl;

  const AppProfile(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppProfile &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

// -------------------------------------------------
