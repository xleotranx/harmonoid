import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:harmonoid/widgets.dart';
import 'package:harmonoid/screens/settings/about/aboutpage.dart';
import 'package:harmonoid/language/constants.dart';


class AboutSetting extends StatefulWidget {
  const AboutSetting({Key key}) : super(key: key);

  @override
  AboutState createState() => AboutState();
}


class AboutState extends State<AboutSetting> {
  Map<String, dynamic> repository;
  bool _init = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (this._init) {
      try {
        http.Response response = await http.get(
          Uri.https('api.github.com', '/repos/alexmercerind/harmonoid'),
        );
        this.repository = convert.jsonDecode(response.body);
        this.setState(() {});
      } catch (exception) {}
      this._init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: Duration(milliseconds: 400),
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, open) => ClosedTile(
        open: open,
        title: Constants.STRING_ABOUT_TITLE,
        subtitle: Constants.STRING_ABOUT_SUBTITLE,
      ),
      openBuilder: (context, _) => AboutPage(repository: this.repository),
    );
  }
}