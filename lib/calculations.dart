import 'dart:math';

import 'levels.dart';

class Iv {
  int attack;
  int defence;
  int hp;
  int level;

  Iv(this.attack, this.defence, this.hp, this.level);
}

int checkCp(int baseAttack, int attack, int baseDefence, int defence, int baseHp, int hp, double levelMultiplier) {
  return (((baseAttack + attack) * pow(baseDefence + defence, 0.5) * pow(baseHp + hp, 0.5) * pow(levelMultiplier, 2)) /
          10)
      .floor();
}

List<Iv> getMatchingIvs(int cp, int baseAttack, int baseDefence, int baseHp, List<int> levels) {
  List<double> multipliers = levelMultipliers;

  if (levels != null) {
    multipliers = List<double>.generate(levels.length, (l) => levelMultipliers[levels[l] - 1]);
  }

  var ivs = <Iv>[];

  for (int multiplier = 0; multiplier < multipliers.length; multiplier++) {
    for (int attack = 0; attack <= 15; attack++) {
      for (int defence = 0; defence <= 15; defence++) {
        for (int hp = 0; hp <= 15; hp++) {
          if (checkCp(baseAttack, attack, baseDefence, defence, baseHp, hp, multipliers[multiplier]) == cp) {
            ivs.add(Iv(attack, defence, hp, levels != null ? levels[multiplier] : multiplier + 1));
          }
        }
      }
    }
  }

  return ivs;
}
