import 'package:flutter/material.dart';
import 'package:flutter_brew/model/brew.dart';
import 'package:flutter_brew/screen/home/widget/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      // length called on null
      itemCount: brews.length,
      itemBuilder: (BuildContext context, int index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
