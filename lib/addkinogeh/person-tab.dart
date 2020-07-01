import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:helloworld/chips-input/chip-input.dart';


class PersonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChipInput<AppProfile>(
      findSuggestions: (String query) async {
        return mockResults;
      },
      suggestionBuilder: (context, AppProfile data, ChipsData<AppProfile> chips) {
        return GestureDetector(
          child: Text(
            data.name,
          ),
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
      'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
  AppProfile('Paul', 'paul@google.com',
      'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
  AppProfile('Fred', 'fred@google.com',
      'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
  AppProfile('Bera', 'bera@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('John', 'john@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('Thomas', 'thomas@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('Norbert', 'norbert@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('Marina', 'marina@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
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
