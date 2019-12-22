import 'package:flutter/material.dart';

import 'calculations.dart';

void main() => runApp(WhatRanApp());

class WhatRanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What Ran?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WhatRanHomePage(),
    );
  }
}

class WhatRanHomePage extends StatefulWidget {
  WhatRanHomePage({Key key}) : super(key: key);

  @override
  _WhatRanHomePageState createState() => _WhatRanHomePageState();
}

class _WhatRanHomePageState extends State<WhatRanHomePage> {
  int _cp = 2387;
  int _baseAttack = 300;
  int _baseDefence = 182;
  int _baseHp = 214;
  bool _raid = false;

  TextEditingController _cpController;
  TextEditingController _baseAttackController;
  TextEditingController _baseDefenceController;
  TextEditingController _baseHpController;

  @override
  void initState() {
    super.initState();

    _cpController = TextEditingController(text: "$_cp");
    _baseAttackController = TextEditingController(text: "$_baseAttack");
    _baseDefenceController = TextEditingController(text: "$_baseDefence");
    _baseHpController = TextEditingController(text: "$_baseHp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What Ran?"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _cpController,
              decoration: InputDecoration(labelText: 'CP'),
              keyboardType: TextInputType.number,
              onChanged: (cp) => setState(() => _cp = int.parse(cp)),
            ),
            TextFormField(
              controller: _baseAttackController,
              decoration: InputDecoration(labelText: 'Base Attack'),
              keyboardType: TextInputType.number,
              onChanged: (attack) => setState(() => _baseAttack = int.parse(attack)),
            ),
            TextFormField(
              controller: _baseDefenceController,
              decoration: InputDecoration(labelText: 'Base Defence'),
              keyboardType: TextInputType.number,
              onChanged: (defence) => setState(() => _baseDefence = int.parse(defence)),
            ),
            TextField(
              controller: _baseHpController,
              decoration: InputDecoration(labelText: 'Base HP'),
              keyboardType: TextInputType.number,
              onChanged: (hp) => setState(() => _baseHp = int.parse(hp)),
            ),
            CheckboxListTile(
              value: _raid,
              title: Text("Raid?"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (raid) => setState(() => _raid = raid),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child:
                    Text(_formatIvs(getMatchingIvs(_cp, _baseAttack, _baseDefence, _baseHp, _raid ? [20, 25] : null))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatIvs(List<Iv> ivs) {
    var sb = StringBuffer();
    int level;

    for (var iv in ivs) {
      if (iv.level != level) {
        sb.writeln();
      }

      if (level == null || iv.level != level) {
        level = iv.level;
        sb.writeln("Level $level");
      }

      var pct = ((iv.attack + iv.defence + iv.hp) / 45 * 100);
      sb.writeln("${iv.attack}/${iv.defence}/${iv.hp} (${pct.toStringAsFixed(1)}%)");
    }

    return sb.toString();
  }
}
